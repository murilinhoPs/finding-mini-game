<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Finding-Mini-game (find objects, investigation)

Creates a **mini-game** where you have to find "*hidden*" objects and you'll have a **inventory** to show which items you've collected so far, and also keep track which ***key items*** you have in order to collect locked objects (like a key to get a item inside a chest). 

It has **clues** to help the player to find the hidden objects, and because is for a **narrative-game** I'm developing, it shows the narrator lines sometimes when player gets new clues but it's an optional field to add to the game.

## Features
You can use this package in your flutter **game** 👀 or app (it's up to you): 

- Draw the game background and it's items on flutter Canvas
- Show the items to pick-up, even the disabled items that requires a "key"
- You can slide up and down to see the parts of image that are outside of the screen
  - I'm trying to make this better or in the final game make a illustration with the correct size
- Use the help button to make easier to find objects

<img src="assets/miniGameDemo.gif" style="height: 240px" />
    
   > In the future I want to create a customizable theme for the game
    I'm using a "blue theme" because I think fits better the actual background

## Getting started

Install the package and pass to `AppWidget` the background image path and the data (json) path where's all the mini-game information

#### Usage

Just install and do like folowing example:

```dart
    return MaterialApp(
      home: const AppWidget(
        backgroundPath: 'assets/backgrounds/Interior6.png',
        jsonPath: 'assets/jsons/interior_6.json',
      ),
    );
```

#### Package structure and architecture
- The `finding_mini_game.dart` in `lib` folder, just exports the package
- I'm using the `provider` package to deal with D.I and the `equatable` package to be easier to test and use the `models` on `controllers`
- The `src/` folder is all the game logic, view and data
  - I choose to organize the `src` structure into `data/`, where's the `json` data to get all the mini-game data; 
  - The `models/` are all the models required to parse the `json` data and use through the application (core information); 
  - `controllers/` are used to manage all the game `logic` and `states`, to pass to the `view` all the information needed to update it; 
  - the `view/` is all the view (widgets...)

## Additional information

If you want to know more about the package, here's my [github](https://github.com/murilinhoPs)! And feel free to drop any comments, suggestions or feedback (my socials are on my github profile) or open an issue/pull-request if you have an idea!
