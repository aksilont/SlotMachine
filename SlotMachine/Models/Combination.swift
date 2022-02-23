//
//  Combination.swift
//  SlotMachine
//
//  Created by Aksilont on 18.02.2022.
//

import Foundation

struct Combination {
    private let itemsPack = ["🍋", "🍏", "🍓", "🥕", "🍒"]
    private var randomItem: String {
        itemsPack[Int.random(in: (0...4))]
    }
    
    let numberOfPicks = 3
    
    var leftLine: [Pick] = []
    var middleLine: [Pick] = []
    var rightLine: [Pick] = []
    
    mutating func nextCombination1() {
        leftLine.removeFirst()
        leftLine.append(Pick(value: randomItem))
    }
    
    mutating func nextCombination2() {
        middleLine.removeFirst()
        middleLine.append(Pick(value: randomItem))
    }
    
    mutating func nextCombination3() {
        rightLine.removeFirst()
        rightLine.append(Pick(value: randomItem))
    }
    
    func checkLineFor(id: Int) -> Bool {
        return leftLine[id] == middleLine[id] && leftLine[id] == rightLine[id]
    }
    
    init() {
        for _ in (1...numberOfPicks) {
            leftLine.append(Pick(value: randomItem))
            middleLine.append(Pick(value: randomItem))
            rightLine.append(Pick(value: randomItem))
        }
    }
}
