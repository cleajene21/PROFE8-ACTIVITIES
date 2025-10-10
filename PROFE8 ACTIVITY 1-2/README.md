# CameraRent Pro

A comprehensive Flutter camera rental service app that demonstrates Flutter development best practices and various widget implementations.

## Project Structure

This project follows Flutter best practices with a clean architecture:

\`\`\`
lib/
├── main.dart                    # App entry point
├── models/                      # Data models
│   ├── camera.dart             # Camera model with specs and pricing
│   ├── rental.dart             # Rental booking model
│   └── user.dart               # User profile model
├── views/                      # Screen-level components
│   ├── main_view.dart          # Main app with navigation
│   ├── home_view.dart          # Camera browsing screen
│   ├── rentals_view.dart       # User rentals screen
│   ├── rental_form_view.dart   # Rental booking form
│   ├── hello_world_stateless.dart    # StatelessWidget demo
│   ├── hello_world_stateful.dart     # StatefulWidget with counter
│   └── cupertino_material_demo.dart  # Platform design comparison
├── widgets/                    # Reusable UI components
│   ├── camera_card.dart        # Individual camera display
│   └── custom_button.dart      # Reusable button component
└── services/                   # Business logic and data
    ├── camera_service.dart     # Camera data management
    └── rental_service.dart     # Rental operations
\`\`\`

## Architecture Benefits

- **Separation of Concerns**: Models, views, widgets, and services are clearly separated
- **Reusability**: Custom widgets can be used across multiple screens
- **Maintainability**: Business logic is isolated in service classes
- **Scalability**: Easy to add new features without affecting existing code
- **Code Quality**: Comprehensive linting rules via analysis_options.yaml

## Features

### Main Application
- Browse available cameras in a staggered grid layout using `flutter_staggered_grid_view`
- View camera details with pricing and ratings
- Fill out rental forms with personal information
- Select rental dates with date pickers
- View rental history and status
- Bottom navigation between Browse and My Rentals
- Drawer navigation for accessing demo screens

### Development Demos
- **Hello World StatelessWidget**: Basic widget structure demonstration
- **Hello World StatefulWidget**: State management with counter functionality
- **Material vs Cupertino**: Side-by-side comparison of platform-specific widgets

## Widget Hierarchy

\`\`\`
MaterialApp
└── MainView (StatefulWidget)
    ├── AppBar (with counter and drawer)
    ├── Drawer (navigation to demo screens)
    ├── IndexedStack
    │   ├── HomeView
    │   │   └── StaggeredGridView (third-party package)
    │   │       └── CameraCard (custom widget)
    │   └── RentalsView
    │       └── ListView
    │           └── Card (rental items)
    └── BottomNavigationBar (2 tabs)
\`\`\`

## Development Guidelines Compliance

1. ✅ **Project Organization**: Structured into models, views, widgets, and services folders
2. ✅ **StatelessWidget**: Hello World app using only StatelessWidget
3. ✅ **StatefulWidget**: Converted Hello World to StatefulWidget with counter button
4. ✅ **Custom Reusable Widget**: CustomButton widget used across multiple screens
5. ✅ **Material & Cupertino**: Implemented both design systems in comparison demo
6. ✅ **Navigation**: Two-page app with both BottomNavigationBar and Drawer navigation
7. ✅ **Widget Tree**: Clear hierarchy documented with parent-child relationships
8. ✅ **Refactoring**: Long widget trees broken into smaller, reusable components
9. ✅ **Third-party Package**: `flutter_staggered_grid_view` integrated for dynamic layouts
10. ✅ **Documentation**: Comprehensive README explaining project structure and decisions

## Technical Implementation

### State Management
- Uses StatefulWidget for local state management
- Singleton pattern for service classes to maintain data consistency
- GlobalKey for cross-widget communication

### UI/UX Design
- Material Design principles throughout the main app
- Cupertino widgets demonstrated in comparison screen
- Responsive layouts with proper spacing and typography
- Custom color schemes and consistent styling

### Code Quality
- Comprehensive linting rules via `analysis_options.yaml`
- Proper const constructors for performance optimization
- Clear separation of concerns between UI and business logic
- Consistent naming conventions and code organization

## Getting Started

1. Ensure Flutter SDK is installed (>=3.0.0)
2. Run `flutter pub get` to install dependencies
3. Run `flutter analyze` to check code quality
4. Run `flutter run` to start the app

## Dependencies

- `flutter_staggered_grid_view: ^0.7.0` - For dynamic grid layouts
- `flutter_lints: ^3.0.0` - For code quality enforcement

## Future Enhancements

- Add image loading for camera photos
- Implement real backend integration
- Add user authentication
- Include payment processing
- Add camera search and filtering
- Implement unit and widget tests
- Add internationalization support
