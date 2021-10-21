# TVMAZeApp

https://user-images.githubusercontent.com/16884034/138203207-69287d6a-5ec0-4d02-a302-31a28567c009.mov

(Xcode Version 12.4, iOS 13+)

## Base Features:
- List of all series contained in [TVMaze API](https://www.tvmaze.com/api) using paging provided by the API Showing Title, poster and summary.
- Users can search series by name in the Shows tab, the series are displayed with title summary and score provided by the API
- Once the user clicks a serie, it shows the detail, showing the poster, the title, the days, the time during the series airs, the genres, and the sumary
- The user can choose a season by clickingin the season picker and selecting the season which loads the episodes that the season contains
- If the user wants to see the detail of the episode he/she can click on the episode, the detail of the episode will show the title, episode number, season number and a summary of this episode

## Bonus Features:
- The user can select between dark mode or light mode for the entire app in the tab settings
- The user can add a layer of security by adding a pin and setting up Biometrics, this will be required once the app starts if it is enabled, the pin is saved with sha256 compression algorithm in the keychain.
- Support for large text by changing Accessibility settings
- TextDebouncer was added to handle search by waiting 500ms before launching a request to the API
- Most of the app is fully navigable by voice over.
- If the user wants to add to favorites a serie he/she can click on the heart button in the detail of the serie.
- the user can scroll through their favourites series by clicking on the favourites Tab button.
- The whole style app could be changed in a easy way without hard breaking changes.
- Unit tests were added to the search and show detail VIPER modules.

## VIPER App architecture 
![68747470733a2f2f6b6f656e69672d6d656469612e72617977656e6465726c6963682e636f6d2f75706c6f6164732f323032302f30322f76697065722e706e67](https://user-images.githubusercontent.com/16884034/138205431-2fee833d-720a-4d37-aeb3-b84141261928.png)

The Project was built to follow all the alignments defined by the VIPER Architecture which is an acronym of:

- **VIEW:**  is in charge of receiving actions and interactions from the user and notifies the presenter to take a decision over it.

- **INTERACTOR:** is a component which handles business rules and informs to the presenter which is the info to be handle.

- **PRESENTER:** Controls the main amount of the components, by sending actions.
- **ENTITY:** Represents the information for the business rules
- **ROUTER:** Handles the app navigation.

## Style:
- Font: `FontStyle` is in charge to provide the correct size and font by choosing between title or body style it was to handle dynamic font size to accessibility users, each type has a size for L M and S.
- Color: `BaseColorPalette` is in charge of the color of the whole App this handles also dark mode colors.

## Authentication 
- Biometrics are handle by the protocol `LocalBiometricAuthenticationManager` which is implemented by `AuthenticationManager` to handle biometrics authentication across the app
- Pin is being handled by the whole viper module `PinAuthentication` it can be presented by passing the `PinAuthenticationType` and delegating the result with `PinDelegateResult`

## DataStore
- There are two kinds of data store (`DefaultStore` and `SecureStore`) Secure is in charge to save sensitive information to the keychain whereas the Default Store is in charge to save user defaults information, both are implementing the protocol `LocalStore`

