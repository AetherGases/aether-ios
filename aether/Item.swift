//
//  Item.swift
//  aether
//
//  Created by Vinicius Boas on 07/08/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
