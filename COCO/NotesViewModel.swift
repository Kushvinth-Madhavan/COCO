import SwiftUI

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    init() {
        // Add some sample notes for preview
        #if DEBUG
        notes = [
            Note(title: "Linear Algebra", content: "Introductory Classes", emoji: "🧠"),
            Note(title: "SOLID Principles", content: "DevOPS Introduction", emoji: "🏗️"),
            Note(title: "Hello, World!", content: "Hello, World!", emoji: "👋")
        ]
        #endif
    }
    
    func addNote(title: String, content: String, emoji: String) {
        let note = Note(title: title, content: content, emoji: emoji)
        notes.insert(note, at: 0)
    }
    
    func deleteNote(at indexSet: IndexSet) {
        notes.remove(atOffsets: indexSet)
    }
}
