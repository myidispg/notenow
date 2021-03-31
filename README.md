# notes_app

Flutter app for taking notes. A watered down version of Google Keep!

## Features of the application
 - Creading, editing and deleting notes. Each note has a title, content and a colored label assigned to it.
 - Online sync with Firebase Firestore.
 - Offline storage of notes using [sqflite](https://pub.dev/packages/sqflite). Notes are stored offline for persistence accross restarts until the user switches to online sync. Then only online sync.
 - A theme switcher to switch between dark and light theme. The user's preference is saved among app restarts using [shared_prederences](https://pub.dev/packages/shared_preferences).
 
