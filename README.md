# New York Times - Top Stories iOS App

This is an iOS app that presents a list of the top stories from the New York Times, along with a detail view for each story. The app fetches data from the New York Times public API and follows Apple's Human Interface Guidelines. It aims to provide a clean and user-friendly interface for users to browse and read top stories.

## Features

The app includes the following features:

### List View
- Displays a list of top stories
- Each item in the list includes:
  - Small image thumbnail
  - Title
  - Author

### Detail View
- Displays detailed information about a selected story
- Includes the following details:
  - Navigation bar title
  - Large image
  - Title
  - Description
  - Author
  - "See more" button to open and preview the full article within the app, without leaving the app

## Requirements

The app has the following requirements:

- Developed using the latest version of Swift
- Deployment target: iOS 13.0 or later
- Supports both portrait and landscape orientations

## Bonus Points

The app implementation will be awarded bonus points for the following:

- Minimal use of external dependencies (only if necessary)
- Avoidance of WKWebView usage
- Implementation follows the MVVM design pattern
- Strong attention to quality and testing
- Clean code with proper organization and separation of concerns
- Utilization of design patterns
- Maintaining a clean and organized git history
- Optional: Separate view code (View Code) for better modularity and testability

## Project Structure

The project follows the following folder and file structure:

```
- Models
    - FavoriteStory+CoreDataClass.swift
    - FavoriteStory+CoreDataProperties.swift
- NYTApp
    - Controllers
        - ListViewController.swift
        - DetailViewController.swift
    - Extensions
        - UIImageView+Extensions.swift
    - Utils
        - FavoriteManager.swift
        - FavoriteStory.xcdatamodeld
    - Views
        - ListView.swift
        - ListCell.swift
        - DetailView.swift
        - Launchscreen.storyboard
    - ViewModels
        - ListViewModel.swift
        - DetailViewModel.swift
    - Sources
        - SceneDelegate.swift
        - AppDelegate.swift
        - Info.plist
        - Assets.xcassets
- NYTAppTests
    - NYTAppTests.swift
- NYTAppUITests
    - NYTAppUITests.swift
    - NYTAppUITestsLaunchTests.swift
- Products
- Frameworks
```

Additionally, the project includes the "NYTimesAPI" package, which contains the following folder and file structure:

```
- NYTimesAPI
    - README.md
    - Package.swift
    - Sources
        - NYTimesAPI
            - DTOs
                - NYTimes.swift
            - Helper
                - Decoders.swift
            - Responses
                - TopStoriesResponse.swift
            - Services
                - NYTimesService.swift
            - NYTimesAPI.swift
    - Tests
        - NYTimesAPITests
            - NYTimesAPITests.swift
```

## Implementation Details

Here are some key implementation details for the project:

### Utils/FavoriteManager.swift
- Manages favorites by using CoreData for storing and retrieving data
- Provides methods to add, remove, and check if a story is marked as a favorite

### Extensions/UIImageView+Extensions.swift
- Adds an extension to UIImageView for downloading and displaying images from a given URL using the SDWebImage library
- Includes an activity indicator for indicating image loading progress

### Views/ListView.swift
- Represents the main view for displaying the list of top stories
- Includes a UITableView for rendering the list
- Sets up constraints and registers the ListCell for reuse

### Views/ListCell.swift
- Represents a custom UITableViewCell used in the list view
- Configures the cell with data from the corresponding StoryViewModel
- Includes UI elements for displaying story details such as the title, author, and thumbnail image
- Provides a favorite button for marking/unmarking a story as a favorite

### Views/DetailView.swift
- Represents the detail view for displaying detailed information about a selected story
- Configures the view with data from the corresponding DetailViewModel
-

 Includes UI elements for displaying the large image, title, author, description, and a "See more" button
- Provides a favorite button for marking/unmarking a story as a favorite

### ViewModels/ListViewModel.swift
- Manages the business logic for the list view
- Fetches the top stories from the NYTimesService and provides the necessary data for the view
- Includes a method for creating a StoryViewModel for a specific story

### ViewModels/DetailViewModel.swift
- Manages the business logic for the detail view
- Provides the necessary data for the view based on a selected story

### Controllers/ListViewController.swift
- Handles the list view controller logic
- Sets up the navigation bar and the activity indicator
- Fetches the top stories using the ListViewModel and updates the table view

### Controllers/DetailViewController.swift
- Handles the detail view controller logic
- Sets up the navigation bar and the "See more" button
- Updates the favorite button based on the favorite status
- Handles the favorite button tap action and updates the favorite status accordingly
- Provides a callback for notifying the list view controller when the favorite status changes

## Usage

To use the app, follow these steps:

1. Clone the project from the GitHub repository.
2. Open the project in Xcode.
3. Build and run the app on an iOS device or simulator.
4. The app will display a list of top stories from the New York Times.
5. Tap on a story to view its details.
6. Within the detail view, you can mark/unmark a story as a favorite using the favorite button.
7. Tap the "See more" button to open and preview the full article within the app.

## Conclusion

The New York Times - Top Stories app provides an intuitive and user-friendly interface for browsing and reading top stories. The app follows Apple's Human Interface Guidelines and implements clean code with proper organization and separation of concerns. It utilizes the NYTimesAPI package to fetch data from the New York Times public API. The app aims to provide a seamless and enjoyable reading experience for users.

Simulator Video and Screenshots:
![Simulator Video](/path/to/simulator-video.mov)!


![Screenshots](https://github.com/bakiucann/Bakiucan_HW2/assets/113190194/220ee7e2-ae01-4dc0-82d2-9225410f5201)



Please note that the paths to the simulator video and screenshots need to be updated with the actual file paths.
