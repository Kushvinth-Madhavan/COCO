# NoteFlow - Smart Notes App 📝

A modern Ai iOS note-taking application built with SwiftUI that focuses on simplicity 

## Technical Stack 🛠

- **Framework**: SwiftUI
- **Authentication**: Google Sign-In SDK
- **Architecture**: MVVM
- **State Management**: Combine (@Published, ObservableObject)
- **Data Persistence**: @AppStorage
- **Minimum iOS Version**: 18.2

## Architecture 🏗

The app follows MVVM architecture with a focus on:
- Clear separation of concerns
- Reactive state management
- Dependency injection
- Single source of truth for authentication

### Authentication Flow
1. App launch → Check auth state
2. Show loading indicator
3. Restore previous sign-in if available
4. Direct user to appropriate view

## Requirements 📋

- Xcode 15.0+
- iOS 18.2+
- Swift 5.0+
- Google Sign-In SDK
- Active Google Cloud Platform account

## Future Enhancements 🔮
- [ ] Ai Feature
- [ ] Storeage Session Optimisation 
- [ ] Note sharing functionality
- [ ] Cloud sync
- [ ] Rich text formatting
- [ ] Categories and tags
- [ ] Search functionality
- [ ] Export options

## Contributing 🤝

Feel free to submit issues, fork the repository, and create pull requests for any improvements.

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments 🙏

- Google Sign-In SDK
- SwiftUI framework
- The Swift community
- 

---

Built with ❤️ by Kushvinth Madhavan
