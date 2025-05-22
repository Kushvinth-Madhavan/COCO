import SwiftUI

struct AllNotesView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var showingNewNote = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "gear")
                    .imageScale(.large)
                    .symbolRenderingMode(.monochrome)
                    .padding(.horizontal)
            }
            
            Text("All Notes")
                .font(.system(.largeTitle, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipped()
                .padding(.leading)
                .padding(.bottom, 8)
            
            ScrollView {
                VStack {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 4)], spacing: 4) {
                        ForEach(viewModel.notes) { note in
                            NoteCard(note: note)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxWidth: .infinity)
                .clipped()
                .padding(.top, 98)
                .padding(.bottom, 150)
            }
            
            // New Note Button
            VStack(spacing: 0) {
                Button(action: { showingNewNote.toggle() }) {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(.orange)
                        .frame(width: 140, height: 50)
                        .clipped()
                        .overlay {
                            Text("New Note")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                }
            }
            .frame(height: 81, alignment: .top)
            .clipped()
        }
        .sheet(isPresented: $showingNewNote) {
            NewNoteView(viewModel: viewModel)
        }
    }
}

struct NoteCard: View {
    let note: Note
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .background(Material.regular)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .aspectRatio(40/10, contentMode: .fit)
                .clipped()
                .mask { RoundedRectangle(cornerRadius: 15, style: .continuous) }
            
            HStack {
                Circle()
                    .fill(Color(.tertiaryLabel))
                    .frame(width: 50, height: 50)
                    .clipped()
                    .padding(.leading)
                    .overlay {
                        Text(note.emoji)
                            .padding(.leading)
                    }
                
                VStack(alignment: .leading) {
                    Text(note.title)
                        .font(.body)
                    Text(note.content)
                        .font(.system(.footnote, weight: .thin))
                        .lineLimit(1)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .symbolRenderingMode(.monochrome)
                    .padding()
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct NewNoteView: View {
    @ObservedObject var viewModel: NotesViewModel
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var content = ""
    @State private var emoji = "📝"
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Content", text: $content)
                TextField("Emoji", text: $emoji)
            }
            .navigationTitle("New Note")
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") {
                    viewModel.addNote(title: title, content: content, emoji: emoji)
                    dismiss()
                }
                .disabled(title.isEmpty || content.isEmpty)
            )
        }
    }
}
