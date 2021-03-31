# notes_app

Flutter app for taking notes. A watered down version of Google Keep!

## Features of the application
 - Creading, editing and deleting notes. Each note has a title, content and a colored label assigned to it.
 - Online sync with Firebase Firestore.
 - Offline storage of notes using [sqflite](https://pub.dev/packages/sqflite). Notes are stored offline for persistence accross restarts until the user switches to online sync. Then only online sync.
 - Searching for notes based on title and content.
 - A theme switcher to switch between dark and light theme. The user's preference is saved among app restarts using [shared_prederences](https://pub.dev/packages/shared_preferences).
 
## A demo of creating notes
![Android Emulator - Pixel_3a_XL_API_30_Android_R_5554 2021-03-31 15-48-04](https://user-images.githubusercontent.com/36075176/113130054-3da5cf80-9239-11eb-9ad6-6e0a79fc4b31.gif)

## Demoing the search functionality
![Android Emulator - Pixel_3a_XL_API_30_Android_R_5554 2021-03-31 15-53-56](https://user-images.githubusercontent.com/36075176/113130422-af7e1900-9239-11eb-8fa5-c4f53922abc9.gif)

## Theme Switching
![Theme](https://user-images.githubusercontent.com/36075176/113131271-a04b9b00-923a-11eb-9350-3d26d805ba99.gif)
