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
    
    private var cancellable = Set<AnyCancellable>()
    private var subscription: AnyCancellable?
    
    private lazy var publisher = {
        Timer
            .publish(every: 0.1, on: RunLoop.main, in: .default)
            .autoconnect()
            .share()
    }()
    
    func startMachine() {
        publisher
            .sink { [unowned self] _ in
                combination.nextCombination()
            }
            .store(in: &cancellable)
    }
    
    init() {
        subscription = $running
            .sink { [unowned self] value in
                if value { startMachine() }
                else {
                    cancellable.forEach { $0.cancel() }
                }
            }
    }
    
    deinit {
        subscription?.cancel()
        cancellable.forEach { $0.cancel() }
    }
}
