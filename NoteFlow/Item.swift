//
//  Item.swift
//  NoteFlow
//
//  Created by Kushvinth Madhavan on 22/05/25.
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

//
//struct Note: Identifiable, Codable {
//    let id: UUID
//    var title: String
//    var content: String
//    var emoji: String
//    var timestamp: Date
//    
//    init(id: UUID = UUID(), title: String, content: String, emoji: String = "📝", timestamp: Date = Date()) {
//        self.id = id
//        self.title = title
//        self.content = content
//        self.emoji = emoji
//        self.timestamp = timestamp
//    }
//}
//
