//
//  Pick.swift
//  SlotMachine
//
//  Created by Aksilont on 19.02.2022.
//

import Foundation

struct Pick: Identifiable, Equatable {
    let id = UUID()
    let value: String
    
    static func == (lhs: Pick, rhs: Pick) -> Bool {
        lhs.value == rhs.value
    }
}
