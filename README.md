# Note Taking App

A simple Flutter app for creating, editing, and managing notes. This project uses `Provider` for state management and supports dark mode.

## Features

- Create, edit, and delete notes
- Light and dark mode support
- Organized UI with Material Design

## Getting Started

### Prerequisites

- Flutter installed on your machine (Install Flutter)
- A device/emulator to run the app

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/note-taking-app.git
   ```
2. Navigate to the project folder:
   ```sh
   cd note-taking-app
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## Project Structure

```
/lib
│-- main.dart             # Entry point of the app
│-- models
│   ├── note_model.dart   # Note data model
│-- providers
│   ├── note_provider.dart  # Manages note state
│   ├── theme_provider.dart # Manages theme state
│-- screens
│   ├── home_screen.dart    # Displays list of notes
│   ├── note_detail_screen.dart # View and edit notes
│-- widgets
│   ├── note_card.dart      # Custom UI component for notes
```

## Dependencies

This project uses:

- `provider` for state management
- `shared_preferences` for storing theme settings

## Future Improvements

- Add search functionality
- Implement cloud sync (Firebase)
- Improve UI/UX



