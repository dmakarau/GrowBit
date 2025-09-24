# HabitTrackerApp

A SwiftUI iOS habit tracking application focused on clean architecture and user experience.

> **Learning Goal**: This project serves as a hands-on learning experience for iOS development with SwiftUI and modern iOS architecture patterns.

## 🏗 Architecture Overview

```
HabitTrackerApp/
├── iOS-Client/           # SwiftUI iOS Application
├── Shared/              # Shared models and utilities
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
- **Combine**: Reactive programming for data flow
- **Core Data**: Local data persistence
- **CloudKit**: iCloud synchronization
- **Calendar Integration**: Native iOS calendar components
- **SF Symbols**: Apple's icon system
- **WidgetKit**: Home screen widget support

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
cd iOS-Client
open HabitTrackerApp.xcodeproj
# Build and run in Xcode simulator
```

### Configuration
- Enable CloudKit in your Apple Developer account
- Configure CloudKit container in Xcode project settings
- Ensure proper entitlements for CloudKit and Core Data

## 📊 Development Roadmap

### Phase 1: Foundation ✅
- [x] Project structure setup and organization
- [x] Basic SwiftUI client structure
- [ ] Core Data model setup
- [ ] Basic UI navigation structure

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
HabitTrackerApp/
├── iOS-Client/
│   ├── HabitTrackerApp.xcodeproj      # Xcode project
│   ├── HabitTrackerApp/               # iOS app source
│   │   ├── HabitTrackerAppApp.swift   # App entry point
│   │   ├── ContentView.swift          # Main view
│   │   ├── Models/                    # Core Data models
│   │   ├── Views/                     # SwiftUI views
│   │   ├── ViewModels/                # MVVM view models
│   │   ├── Services/                  # Data services
│   │   └── Assets.xcassets/           # App assets
│   ├── HabitTrackerAppTests/          # Unit tests
│   ├── HabitTrackerAppUITests/        # UI tests
│   └── Widgets/                       # Widget extension
├── Shared/                            # Shared models and utilities
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