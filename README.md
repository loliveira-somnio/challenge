# Meetup Challenge App

A Flutter application for browsing and bookmarking meetup events, built with a clean architecture approach using BLoC pattern and modular packages.

## 🚀 Features

- **Event Discovery**: Browse and view meetup events
- **Bookmark Management**: Save and manage favorite events
- **Clean Architecture**: Modular design with separate packages for UI, data, and business logic
- **State Management**: BLoC pattern for predictable state management
- **Navigation**: GoRouter for declarative routing with nested navigation
- **Cross-Platform**: Supports iOS, Android, Web, macOS, Linux, and Windows

## 📱 Screenshots

The app features a bottom navigation with two main sections:
- **Events Tab**: Browse and view meetup events
- **Bookmarks Tab**: Manage your saved events

## 🏗️ Architecture

This project follows a clean architecture pattern with the following structure:

```
lib/
├── app/                 # App-level configuration and routing
├── bookmark/           # Bookmark feature module
├── bookmark_list/      # Bookmark list feature module
├── meetup/            # Meetup feature module
└── main/              # App entry point

packages/
├── app_ui/            # Shared UI components and assets
├── meetup_client/     # Data layer for meetup API
└── meetup_repository/ # Repository pattern implementation
```

### Key Dependencies

- **flutter_bloc**: State management using BLoC pattern
- **go_router**: Declarative routing and navigation
- **equatable**: Value equality for Dart objects
- **very_good_analysis**: Linting and code analysis

## 🛠️ Setup

### Prerequisites

- Flutter SDK (>=3.5.0)
- Dart SDK (>=3.5.0)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd challenge
   ```

2. **Install Mason bricks**
   ```bash
   mason get
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Generate code** (if needed)
   ```bash
   flutter packages pub run build_runner build
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## 🧪 Testing

The project includes comprehensive testing with:

- **Unit Tests**: BLoC and Cubit testing with `bloc_test`
- **Widget Tests**: UI component testing
- **Mocking**: Using `mocktail` for test doubles

Run tests:
```bash
flutter test
```

## 📦 Package Structure

### Core Packages

- **`meetup_client`**: Pure Dart package for API communication
- **`meetup_repository`**: Repository pattern implementation with data caching
- **`app_ui`**: Shared UI components, assets, and design system

### Feature Folder

Each feature follows a consistent structure:
```
feature_name/
├── bloc/           # State management
├── view/           # UI components
├── widget/         # Reusable widgets
└── feature_name.dart # Public API
```

## 🚀 Development

### Code Generation

This project uses Mason for code generation. Available bricks:
- `dart_package`: For creating new Dart packages
- `ui_package`: For creating new UI packages

### Code Style

The project uses `very_good_analysis` for consistent code style and linting.

### Adding New Features

1. Create a new feature module in `lib/`
2. Follow the established pattern with `bloc/`, `view/`, and `widget/` directories
3. Add routing configuration in `lib/app/router/app_router.dart`
4. Update the bottom navigation if needed

## 📄 License

This project is licensed under the terms specified in the [LICENSE](LICENSE) file.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [BLoC Documentation](https://bloclibrary.dev/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Mason Documentation](https://docs.brickhub.dev/)
