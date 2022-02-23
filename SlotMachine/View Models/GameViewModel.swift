//
//  GameViewModel.swift
//  SlotMachine
//
//  Created by Aksilont on 18.02.2022.
//

import Foundation
import Combine

class GameViewModel: ObservableObject {
    // Input
    @Published var running: Bool = false
    
    // Output
    @Published var combination = Combination()
    @Published var winer = false
    
    private var cancellable = Set<AnyCancellable>()
    private var subscription: AnyCancellable?
    
    private lazy var publisher1 = {
        Timer
            .publish(every: 0.7, on: RunLoop.main, in: .default)
            .autoconnect()
            .share()
    }()
    
    private lazy var publisher2 = {
        Timer
            .publish(every: 0.25, on: RunLoop.main, in: .default)
            .autoconnect()
            .share()
    }()
    
    private lazy var publisher3 = {
        Timer
            .publish(every: 0.4, on: RunLoop.main, in: .default)
            .autoconnect()
            .share()
    }()
    
    var leftLine: [Pick] {
        combination.leftLine
    }
    var middleLine: [Pick] {
        combination.middleLine
    }
    var rightLine: [Pick] {
        combination.rightLine
    }
    
    func startMachine() {
        winer = false
        
        publisher1
            .sink { [unowned self] _ in
                combination.nextCombination1()
            }
            .store(in: &cancellable)
        
        publisher2
            .sink { [unowned self] _ in
                combination.nextCombination2()
            }
            .store(in: &cancellable)
        
        
        publisher3
            .sink { [unowned self] _ in
                combination.nextCombination3()
            }
            .store(in: &cancellable)
    }
    
    private func checkForWin() {
        // Проверка на победную комбинацию по всем линиям
        (0..<combination.numberOfPicks).forEach { index in
            guard !winer else { return }
            winer = combination.checkLineFor(id: index)
        }
    }
    
    init() {
        subscription = $running
            .sink { [unowned self] value in
                if value { startMachine() }
                else {
                    checkForWin()
                    cancellable.forEach { $0.cancel() }
                }
            }
    }
    
    deinit {
        subscription?.cancel()
        cancellable.forEach { $0.cancel() }
    }
}
