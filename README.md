# HabitTrackerApp

A full-stack habit tracking application with SwiftUI iOS client and Vapor backend, deployed on Heroku.

> **Learning Goal**: This project serves as a hands-on learning experience for backend development with Vapor, Swift's server-side framework.

## 🏗 Architecture Overview

```
HabitTrackerApp/
├── iOS-Client/           # SwiftUI iOS Application
├── Backend/              # Vapor Server Application
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

### Authentication & Security
- **User Registration**: Create new user accounts
- **JWT Authentication**: Secure token-based authentication
- **Protected Routes**: Backend API secured with JWT middleware
- **Session Management**: Automatic token refresh and logout

## 🛠 Technology Stack

### iOS Client (SwiftUI)
- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming for data flow
- **URLSession**: HTTP networking
- **Keychain**: Secure token storage
- **Calendar Integration**: Native iOS calendar components

### Backend (Vapor)
- **Vapor 4**: Swift-based server framework
- **Fluent ORM**: Database abstraction layer
- **JWT**: JSON Web Token authentication
- **PostgreSQL**: Production database (Heroku)
- **SQLite**: Development database

### Deployment
- **Heroku**: Cloud platform hosting
- **PostgreSQL**: Heroku Postgres add-on
- **Environment Variables**: Secure configuration management

## 📋 Database Schema

### User
```swift
- id: UUID
- email: String (unique)
- username: String (unique)
- passwordHash: String
- createdAt: Date
- updatedAt: Date
```

### Category
```swift
- id: UUID
- name: String
- color: String (hex color)
- icon: String (SF Symbol name)
- userId: UUID (foreign key)
- createdAt: Date
```

### Habit
```swift
- id: UUID
- title: String
- description: String?
- categoryId: UUID (foreign key)
- userId: UUID (foreign key)
- targetDays: [Int] (days of week: 0-6)
- isActive: Bool
- createdAt: Date
```

### HabitEntry
```swift
- id: UUID
- habitId: UUID (foreign key)
- userId: UUID (foreign key)
- completedAt: Date
- notes: String?
```

## 🔌 API Endpoints

### Authentication
```
POST /api/auth/register     # User registration
POST /api/auth/login        # User login
POST /api/auth/refresh      # Token refresh
POST /api/auth/logout       # User logout
```

### Categories
```
GET    /api/categories      # Get user categories
POST   /api/categories      # Create category
PUT    /api/categories/:id  # Update category
DELETE /api/categories/:id  # Delete category
```

### Habits
```
GET    /api/habits          # Get user habits
POST   /api/habits          # Create habit
PUT    /api/habits/:id      # Update habit
DELETE /api/habits/:id      # Delete habit
GET    /api/habits/:id/entries  # Get habit entries
```

### Habit Entries
```
POST   /api/entries         # Mark habit as completed
DELETE /api/entries/:id     # Remove completion
GET    /api/entries/calendar/:month  # Get monthly calendar data
```

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- Swift 5.9+
- macOS 14.0+
- Docker (for local development)
- Heroku CLI (for deployment)

### Backend Setup
```bash
cd Backend
swift package resolve
swift run App serve --hostname 0.0.0.0 --port 8080
```

### iOS Client Setup
```bash
cd iOS-Client
open HabitTrackerApp.xcodeproj
# Build and run in Xcode simulator
```

### Environment Configuration
Create `.env` file in Backend directory:
```
DATABASE_URL=sqlite:///habit_tracker.sqlite
JWT_SECRET=your-secret-key-here
```

## 🌍 Deployment

### Heroku Deployment
```bash
# Backend deployment
cd Backend
heroku create your-app-name
heroku addons:create heroku-postgresql:mini
git push heroku main
```

### Environment Variables (Heroku)
```
JWT_SECRET=production-secret-key
DATABASE_URL=postgres://... (auto-configured by Heroku Postgres)
```

## 📊 Development Roadmap

### Phase 1: Foundation ✅
- [x] Project structure setup and organization
- [x] Basic SwiftUI client structure
- [x] Vapor backend scaffolding
- [ ] Backend API with authentication
- [ ] User registration/login flow

### Phase 2: Core Backend Development 🔧
- [ ] Database models and migrations
- [ ] User authentication system with JWT
- [ ] Category management API endpoints
- [ ] Habit CRUD operations API
- [ ] Habit completion tracking API

### Phase 3: iOS Client Development 📱
- [ ] Authentication screens and flow
- [ ] Category management UI
- [ ] Habit creation and management
- [ ] Calendar view implementation
- [ ] Progress tracking views

### Phase 4: Integration & Polish
- [ ] Client-server integration
- [ ] Streak calculations
- [ ] Progress analytics
- [ ] UI/UX improvements
- [ ] Performance optimization

### Phase 5: Deployment & Distribution
- [ ] Heroku deployment
- [ ] App Store preparation
- [ ] Push notifications
- [ ] Advanced features (habit templates, etc.)

## 🧪 Testing

### Backend Tests
```bash
cd Backend
swift test
```

### iOS Tests
- Unit tests for ViewModels and Services
- UI tests for critical user flows
- Integration tests with mock backend

## 📁 Project Structure

```
HabitTrackerApp/
├── iOS-Client/
│   ├── HabitTrackerApp.xcodeproj      # Xcode project
│   ├── HabitTrackerApp/               # iOS app source
│   │   ├── HabitTrackerAppApp.swift   # App entry point
│   │   ├── ContentView.swift          # Main view
│   │   └── Assets.xcassets/           # App assets
│   └── (Future: Tests and Features)
├── Backend/
│   ├── Package.swift                  # Swift Package Manager
│   ├── Sources/
│   │   └── HabitTrackerAppServer/
│   │       ├── entrypoint.swift       # Server entry point
│   │       ├── configure.swift        # App configuration
│   │       └── routes.swift           # Route definitions
│   ├── Tests/
│   │   └── HabitTrackerAppServerTests/
│   ├── Public/                        # Static files
│   └── .vscode/                       # VS Code settings
├── Shared/                            # Shared models (planned)
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