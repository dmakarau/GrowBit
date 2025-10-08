# GrowBit

A SwiftUI iOS habit tracking application focused on clean architecture and user experience.

## 🏗 Architecture Overview

The app follows a clean, protocol-oriented architecture with clear separation of concerns:

- **MVVM Pattern**: ViewModels manage business logic and state
- **Coordinator Pattern**: Centralized navigation via `AppCoordinator`
- **Service Layer**: Protocol-based services (`NetworkService`, `AuthenticationService`)
- **Dependency Injection**: Services injected via protocols for testability

```
GrowBit/
├── GrowBit.xcodeproj            # Xcode project
├── GrowBit/                     # SwiftUI iOS Application
│   ├── Screens/                 # Feature screens (Login, Registration, etc.)
│   ├── ViewModels/              # MVVM view models
│   ├── Services/                # Business logic services
│   ├── Coordination/            # Navigation coordination
│   ├── Components/              # Reusable UI components
│   ├── Extensions/              # Swift extensions
│   └── Utils/                   # Constants and utilities
└── README.md
```

## 📱 Features

### Core Functionality
- **Habit Categories**: Organize habits into customizable categories
- **Habit Management**: Create, edit, and delete habits within categories
- **Calendar Tracking**: Visual calendar showing daily habit completion
- **Streak Tracking**: Monitor consecutive days of habit completion
- **Progress Analytics**: View habit completion statistics and trends

### Data Management
- **Local Storage**: Core Data for persistent habit tracking
- **iCloud Sync**: Seamless data synchronization across devices
- **Data Export**: Export habit data for backup and analysis

## 🛠 Technology Stack

### iOS Application
- **SwiftUI**: Modern declarative UI framework
- **Swift 6.0+**: Latest Swift features with strict concurrency
- **@Observable**: Modern state management with Observation framework
- **URLSession**: Native networking with async/await
- **Core Data**: Local data persistence (planned)
- **CloudKit**: iCloud synchronization (planned)
- **SF Symbols**: Apple's icon system
- **HabitTrackerAppSharedDTO**: Shared Swift package for data transfer objects with backend

## 📋 Core Data Models

### Category
```swift
- id: UUID
- name: String
- color: String (hex color)
- icon: String (SF Symbol name)
- createdAt: Date
- habits: [Habit] (relationship)
```

### Habit
```swift
- id: UUID
- title: String
- description: String?
- category: Category (relationship)
- targetDays: [Int] (days of week: 0-6)
- isActive: Bool
- createdAt: Date
- entries: [HabitEntry] (relationship)
```

### HabitEntry
```swift
- id: UUID
- habit: Habit (relationship)
- completedAt: Date
- notes: String?
```

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 17.0+
- macOS 14.0+

### Setup
```bash
open GrowBit.xcodeproj
# Build and run in Xcode simulator
```

### Configuration
- Enable CloudKit in your Apple Developer account
- Configure CloudKit container in Xcode project settings
- Ensure proper entitlements for CloudKit and Core Data

## 📊 Development Roadmap

### Phase 1: Foundation ✅
- [x] Project structure setup and organization
- [x] Clean architecture with protocol-oriented design
- [x] MVVM pattern implementation
- [x] Coordinator pattern for navigation
- [x] Service layer architecture (HTTPClient, NetworkService, AuthenticationService)
- [x] User registration and login functionality
- [x] Backend integration with shared DTO package
- [x] Token-based authentication with secure storage
- [x] AddCategory screen with color selector component
- [ ] Core Data model setup
- [x] Basic UI navigation structure

### Phase 2: Core Data & Models 🔧
- [ ] Core Data stack implementation
- [ ] Category and Habit models
- [ ] CloudKit integration setup
- [ ] Data persistence layer

### Phase 3: UI Development 📱
- [ ] Category management UI
- [ ] Habit creation and management
- [ ] Calendar view implementation
- [ ] Progress tracking views
- [ ] Settings and preferences

### Phase 4: Advanced Features
- [ ] Streak calculations
- [ ] Progress analytics and insights
- [ ] Widget implementation
- [ ] Notifications and reminders
- [ ] Data export functionality

### Phase 5: Polish & Distribution
- [ ] App Store preparation
- [ ] UI/UX improvements
- [ ] Performance optimization
- [ ] Advanced features (habit templates, etc.)

## 🧪 Testing

### iOS Tests
- Unit tests for ViewModels and Core Data operations
- UI tests for critical user flows
- Widget functionality tests
- CloudKit synchronization tests

## 📁 Project Structure

```
GrowBit/
├── GrowBit.xcodeproj                  # Xcode project
├── GrowBit/                           # iOS app source
│   ├── GrowBitApp.swift               # App entry point
│   ├── Screens/                       # Feature screens
│   │   ├── LoginScreen.swift
│   │   ├── RegistrationScreen.swift
│   │   └── AddCategoryScreen.swift
│   ├── ViewModels/                    # MVVM view models
│   │   ├── LoginViewModel.swift
│   │   ├── RegistrationViewModel.swift
│   │   └── AddCategoryViewModel.swift
│   ├── Services/                      # Business logic services
│   │   ├── NetworkService.swift       # API communication
│   │   ├── AuthenticationService.swift # Auth & token management
│   │   └── Client/
│   │       └── HTTPClient.swift       # Low-level HTTP client
│   ├── Coordination/                  # Navigation management
│   │   └── AppCoordinator.swift
│   ├── Components/                    # Reusable UI components
│   │   └── ColorSelector.swift
│   ├── Extensions/                    # Swift extensions
│   │   ├── Color+Extensions.swift
│   │   └── Strings+Extensions.swift
│   ├── Utils/                         # Constants and utilities
│   │   └── Constants.swift
│   └── Assets.xcassets/               # App assets
├── GrowBitTests/                      # Unit tests (planned)
├── GrowBitUITests/                    # UI tests (planned)
├── CLAUDE.md                          # Claude Code guidance
├── LICENSE
└── README.md
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🔮 Future Enhancements

- Apple Watch companion app
- Widget support
- Social features and habit sharing
- Habit insights with ML recommendations
- Dark mode support
- Accessibility improvements
- Multi-language support
