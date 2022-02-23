//
//  Combination.swift
//  SlotMachine
//
//  Created by Aksilont on 18.02.2022.
//

import Foundation

struct Combination {
    private let itemsPack = ["🍋", "🍏", "🍓", "🥕", "🍒"]
    private let nubmerOfPicks = 3
    private var randomItem: String {
        itemsPack[Int.random(in: (0...4))]
    }
    
    var firstLine: [Pick] = []
    var currentLine: [Pick] = []
    var nextLine: [Pick] = []
    
    mutating func nextCombination() {
        firstLine = currentLine
        currentLine = nextLine
        nextLine.removeAll()
        
        for _ in (1...nubmerOfPicks) {
            nextLine.append(Pick(value: randomItem))
        }
    }
    
    init() {
        for _ in (1...nubmerOfPicks) {
            firstLine.append(Pick(value: "🔄"))
            currentLine.append(Pick(value: "🔄"))
            nextLine.append(Pick(value: "🔄"))
        }
    }
}
