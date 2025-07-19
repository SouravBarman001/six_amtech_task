# StackFood - 6amTech Task

A delicious food delivery app built with Flutter, showcasing modern architecture patterns, responsive design, and clean code principles.

## 📱 Screenshots & Features

<div align="center">
  <img src="images/Full View and Mobile UI.png" alt="Full View and Mobile UI" width="800"/>
  <br/>
  <em>Full View and Mobile UI - Responsive Design</em>
</div>

<br/>

<div align="center">
  <img src="images/Simulator Screenshot - iPhone 15 - 2025-07-19 at 23.12.55.png" alt="Mobile Screenshot" width="300"/>
  <br/>
  <em>Mobile View - iPhone 15 Simulator</em>
</div>

### Key Features
- **Responsive Design**: Optimized for Mobile, Tablet, and Desktop
- **Modern UI/UX**: Clean and intuitive food delivery interface
- **Enhanced User Experience**: Haptic feedback and image zoom effects
- **State Management**: Riverpod for robust state management
- **Modular Architecture**: Clean architecture with feature-based structure
- **UI Components**: Clean header design and food item displays
- **Error Handling**: Comprehensive error handling with logging
- **Performance Optimized**: Efficient rendering and smooth animations

## 🚀 Setup Criteria

### Prerequisites
- **Flutter SDK**: 3.32.0 (Tested) - 3.8.0 or higher required
- **Dart SDK**: 3.8.0 (Included with Flutter)
- **IDE**: VS Code / Android Studio / IntelliJ IDEA
- **Platform Tools**: 
  - Android: Android Studio & SDK
  - iOS: Xcode (macOS only)
  - Web: Chrome browser

### Project Tested Environment
```bash
Flutter 3.32.0 • channel stable
Framework • revision be698c48a6
Engine • revision 1881800949
Tools • Dart 3.8.0 • DevTools 2.45.1
```

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/SouravBarman001/six_amtech_task.git
   cd six_amtech_task
   ```

2. **Check Flutter Environment**
   ```bash
   flutter doctor -v
   ```

3. **Install Dependencies**
   ```bash
   # Install main project dependencies
   flutter pub get
   
   # Install core module dependencies
   cd modules/core
   flutter pub get
   cd ../..
   ```

4. **Run the Application**
   ```bash
   # For development
   flutter run
   
   # For specific platform
   flutter run -d chrome    # Web
   flutter run -d ios       # iOS Simulator
   flutter run -d android   # Android Emulator
   ```

5. **Build for Production**
   ```bash
   # Android APK
   flutter build apk --release
   
   # iOS
   flutter build ios --release
   
   # Web
   flutter build web --release
   ```

## 🏗️ Project Structure

```
six_amtech_task/
├── 📁 android/                    # Android platform files
├── 📁 ios/                       # iOS platform files
├── 📁 web/                       # Web platform files
├── 📁 assets/                    # Application assets
│   ├── biryani.png
│   ├── donut.png
│   ├── fast-food.png
│   ├── hamburger.png
│   └── pizza.png
├── 📁 images/                    # Screenshots & documentation images
│   ├── Full View and Mobile UI.png
│   ├── Simulator Screenshot - iPhone 15.png
│   ├── colour picking tool.png
│   ├── logging and error handling.png
│   └── post-man api test.png
├── 📁 lib/                       # Main application code
│   ├── 📁 core/                  # Core utilities (app-level)
│   │   └── 📁 utils/
│   │       └── responsive_helper.dart
│   ├── 📁 feature/               # Feature-based modules
│   │   └── 📁 home_page/
│   │       ├── 📁 data/          # Data layer
│   │       │   ├── 📁 datasources/
│   │       │   ├── 📁 models/
│   │       │   └── 📁 repositories/
│   │       ├── 📁 domain/        # Domain layer
│   │       │   ├── 📁 entities/
│   │       │   ├── 📁 repositories/
│   │       │   └── 📁 usecases/
│   │       ├── 📁 presentation/  # Presentation layer
│   │       │   ├── 📁 pages/
│   │       │   ├── 📁 providers/
│   │       │   └── 📁 widgets/
│   │       └── 📁 utils/         # Feature-specific utilities
│   ├── main.dart                 # App entry point
│   └── splash_screen.dart        # Splash screen
├── 📁 modules/                   # Shared modules
│   └── 📁 core/                  # Core module (shared)
│       ├── 📁 lib/
│       │   ├── 📁 src/
│       │   │   ├── 📁 base/      # Base classes
│       │   │   ├── 📁 constants/ # App constants
│       │   │   ├── 📁 helpers/   # Helper utilities
│       │   │   ├── 📁 log/       # Logging utilities
│       │   │   ├── 📁 riverpod/  # Riverpod configurations
│       │   │   └── 📁 service/   # Network & services
│       │   └── core.dart         # Core module exports
│       └── pubspec.yaml          # Core module dependencies
├── 📁 test/                      # Test files
├── pubspec.yaml                  # Main dependencies
├── analysis_options.yaml         # Linting rules
└── README.md                     # This file
```

### Architecture Explanation

#### **Clean Architecture Layers**
1. **Presentation Layer**: UI components, state management, user interactions
2. **Domain Layer**: Business logic, entities, use cases (business rules)
3. **Data Layer**: API calls, local storage, repositories implementation

#### **Feature-Based Structure**
- Each feature is self-contained with its own data, domain, and presentation layers
- Promotes modularity, testability, and maintainability
- Easy to scale and add new features

## 🎨 State Management & Responsiveness

### State Management with Riverpod

#### **Why Riverpod?**
- **Compile-time Safety**: Catches errors at compile time
- **No BuildContext**: Providers can be accessed anywhere
- **Better Testing**: Easy to mock and test
- **Performance**: Optimized rebuilds and caching
- **DevTools Support**: Excellent debugging experience

#### **Provider Types Used**
```dart
// State Provider - For simple state
final counterProvider = StateProvider<int>((ref) => 0);

// Future Provider - For async operations
final userDataProvider = FutureProvider<User>((ref) async {
  return await userRepository.fetchUser();
});

// State Notifier Provider - For complex state
final foodListProvider = StateNotifierProvider<FoodListNotifier, FoodListState>(
  (ref) => FoodListNotifier(),
);
```

#### **State Management Pattern**
1. **Providers**: Declare providers for state management
2. **Notifiers**: Handle state changes and business logic
3. **Consumer Widgets**: React to state changes
4. **Repository Pattern**: Abstract data sources

### Responsiveness Implementation

#### **Responsive Helper Utility**
```dart
class ResponsiveHelper {
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1200;
  
  // Screen type detection
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < mobileMaxWidth;
  static bool isTablet(BuildContext context) => /* tablet logic */;
  static bool isDesktop(BuildContext context) => /* desktop logic */;
  
  // Responsive values
  static double getResponsiveValue({
    required BuildContext context,
    required double mobile,
    required double tablet, 
    required double desktop,
  }) {
    // Returns appropriate value based on screen size
  }
}
```

#### **Responsive Design Strategy**
1. **Breakpoints**: Mobile (<600px), Tablet (600-1200px), Desktop (>1200px)
2. **Flexible Layouts**: ConstrainedBox with max width constraints
3. **Adaptive Spacing**: Different padding/margins for each screen size
4. **Scalable Typography**: Screen-size appropriate font sizes
5. **Grid Systems**: Different column counts for different screens

#### **ScreenUtil Integration**
- **Design Size**: Based on iPhone X (375x812)
- **Adaptive Text**: Automatically scales text based on screen size
- **Responsive Dimensions**: `.w`, `.h`, `.r` extensions for responsive sizing

## 🔧 Core Module Importance

### Why Separate Core Module?

#### **1. Separation of Concerns**
- **Shared Utilities**: Common functionality across features
- **Reusability**: Used by multiple features without duplication
- **Maintainability**: Central location for core functionality
- **Testing**: Easier to test shared components

#### **2. Core Module Components**

#### **Base Classes (`src/base/`)**
```dart
abstract class UseCase<Type, Params> {
  Future<Result<Type>> call(Params params);
}

abstract class Repository {
  // Common repository methods
}
```

#### **Constants (`src/constants/`)**
```dart
class AppConstants {
  static const String appName = 'StackFood';
  static const String appVersion = '1.0.0';
  static const Duration animationDuration = Duration(milliseconds: 300);
}
```

#### **Helpers (`src/helpers/`)**
- **Network Helper**: HTTP client configuration
- **Storage Helper**: Local storage utilities  
- **Validation Helper**: Common validation functions
- **Date Helper**: Date formatting utilities

#### **Logging (`src/log/`)**
```dart
class AppLogger {
  static void debug(String message) { /* Debug logging */ }
  static void error(String message, [dynamic error, StackTrace? stackTrace]) { /* Error logging */ }
  static void info(String message) { /* Info logging */ }
}
```

#### **Riverpod Configuration (`src/riverpod/`)**
- **Provider Overrides**: For testing and different environments
- **Observer Configuration**: State change monitoring
- **Error Handling**: Global error handling for providers

#### **Services (`src/service/`)**
```dart
class UIService {
  static void showSnackBar(String message) {
    // Show snackbar implementation
  }
  
  static void showDialog(String title, String message) {
    // Show dialog implementation
  }
}
```

#### **3. Benefits of Core Module**
- **Dependency Management**: Shared dependencies in one place
- **Version Control**: Easy to update shared functionality
- **Code Reuse**: Prevents code duplication across features
- **Standard Patterns**: Enforces consistent patterns across the app
- **Easy Integration**: Simple to add to new projects

## 🧪 API Testing in Postman

<div align="center">
  <img src="images/post-man api test.png" alt="Postman API Testing" width="800"/>
  <br/>
  <em>Postman API Collection - Testing Food Delivery APIs</em>
</div>

## ⚠️ Error Handling

<div align="center">
  <img src="images/logging and error handling.png" alt="Logging and Error Handling" width="600"/>
  <br/>
  <em>Logging and Error Handling Implementation</em>
</div>

### Comprehensive Error Handling Strategy

#### **1. Error Types & Classification**
```dart
enum ErrorType {
  network,
  server,
  authentication,
  validation,
  cache,
  unknown
}

class AppError extends Equatable {
  final ErrorType type;
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppError({
    required this.type,
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [type, message, code];
}
```

#### **2. Result Pattern Implementation**
```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final AppError error;
  const Failure(this.error);
}
```

#### **3. Network Error Handling**
```dart
class NetworkService {
  static Future<Result<T>> safeApiCall<T>({
    required Future<T> Function() apiCall,
    required String endpoint,
  }) async {
    try {
      final result = await apiCall();
      AppLogger.info('API Success: $endpoint');
      return Success(result);
    } on DioException catch (e, stackTrace) {
      final error = _handleDioError(e, endpoint, stackTrace);
      AppLogger.error('API Error: $endpoint', e, stackTrace);
      return Failure(error);
    } catch (e, stackTrace) {
      final error = AppError(
        type: ErrorType.unknown,
        message: 'Unexpected error occurred',
        originalError: e,
        stackTrace: stackTrace,
      );
      AppLogger.error('Unexpected Error: $endpoint', e, stackTrace);
      return Failure(error);
    }
  }

  static AppError _handleDioError(DioException e, String endpoint, StackTrace stackTrace) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError(
          type: ErrorType.network,
          message: 'Connection timeout. Please check your internet connection.',
          code: 'TIMEOUT',
          originalError: e,
          stackTrace: stackTrace,
        );
      
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        return AppError(
          type: statusCode == 401 ? ErrorType.authentication : ErrorType.server,
          message: _getErrorMessage(statusCode, e.response?.data),
          code: statusCode?.toString(),
          originalError: e,
          stackTrace: stackTrace,
        );
      
      case DioExceptionType.connectionError:
        return AppError(
          type: ErrorType.network,
          message: 'No internet connection. Please check your network.',
          code: 'NO_CONNECTION',
          originalError: e,
          stackTrace: stackTrace,
        );
      
      default:
        return AppError(
          type: ErrorType.network,
          message: 'Network error occurred. Please try again.',
          code: 'NETWORK_ERROR',
          originalError: e,
          stackTrace: stackTrace,
        );
    }
  }
}
```

#### **4. State Management Error Handling**
```dart
class FoodListNotifier extends StateNotifier<AsyncValue<List<Food>>> {
  final FoodRepository _repository;
  
  FoodListNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadFoods() async {
    state = const AsyncValue.loading();
    
    final result = await _repository.getFoods();
    
    result.when(
      success: (foods) {
        state = AsyncValue.data(foods);
        AppLogger.info('Foods loaded successfully: ${foods.length} items');
      },
      failure: (error) {
        state = AsyncValue.error(error, StackTrace.current);
        AppLogger.error('Failed to load foods', error);
        
        // Show user-friendly error message
        _showErrorMessage(error);
      },
    );
  }

  void _showErrorMessage(AppError error) {
    String message;
    switch (error.type) {
      case ErrorType.network:
        message = 'Please check your internet connection and try again.';
        break;
      case ErrorType.server:
        message = 'Server error. Please try again later.';
        break;
      case ErrorType.authentication:
        message = 'Please login again to continue.';
        break;
      default:
        message = error.message;
    }
    
    // Show snackbar or dialog with user-friendly message
    NotificationService.showError(message);
  }
}
```

#### **5. UI Error Handling**
```dart
class ErrorWidget extends StatelessWidget {
  final AppError error;
  final VoidCallback? onRetry;

  const ErrorWidget({
    super.key,
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getErrorIcon(error.type),
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            _getUserFriendlyMessage(error),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getErrorIcon(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.server:
        return Icons.error_outline;
      case ErrorType.authentication:
        return Icons.lock_outline;
      default:
        return Icons.warning_outlined;
    }
  }

  String _getUserFriendlyMessage(AppError error) {
    switch (error.type) {
      case ErrorType.network:
        return 'No internet connection.\nPlease check your network and try again.';
      case ErrorType.server:
        return 'Something went wrong on our end.\nPlease try again later.';
      case ErrorType.authentication:
        return 'Session expired.\nPlease login again.';
      default:
        return error.message;
    }
  }
}
```

#### **6. Global Error Handler**
```dart
class GlobalErrorHandler {
  static void initialize() {
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      AppLogger.error('Flutter Error', details.exception, details.stack);
      
      // Report to crash analytics (Firebase Crashlytics, Sentry, etc.)
      CrashReporting.recordFlutterError(details);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      AppLogger.error('Platform Error', error, stack);
      
      // Report to crash analytics
      CrashReporting.recordError(error, stack);
      
      return true;
    };
  }

  static void handleProviderError(Object error, StackTrace stackTrace) {
    AppLogger.error('Provider Error', error, stackTrace);
    
    // Show user notification for critical errors
    if (error is AppError && error.type == ErrorType.authentication) {
      NavigationService.navigateToLogin();
    }
    
    // Report non-critical errors
    CrashReporting.recordError(error, stackTrace);
  }
}
```

#### **7. Logging Configuration**
```dart
class AppLogger {
  static late Logger _logger;

  static void initialize() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
    );
  }

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
```

#### **8. Error Handling Best Practices**

1. **Graceful Degradation**: App continues to function with limited features
2. **User-Friendly Messages**: Convert technical errors to understandable messages
3. **Retry Mechanisms**: Allow users to retry failed operations
4. **Offline Support**: Cache data and handle offline scenarios
5. **Error Reporting**: Track errors for improvement and debugging
6. **Loading States**: Show appropriate loading indicators during operations
7. **Validation**: Prevent errors through input validation
8. **Recovery Actions**: Provide clear steps for error recovery

### Error Handling Checklist
- ✅ Network connectivity errors
- ✅ API response errors (4xx, 5xx)
- ✅ Authentication/authorization errors
- ✅ Data parsing/serialization errors
- ✅ Cache/storage errors
- ✅ Widget building errors
- ✅ State management errors
- ✅ Platform-specific errors

## 🚀 Additional Features

<div align="center">
  <img src="images/colour picking tool.png" alt="Color Picking Tool" width="400"/>
  <br/>
  <em>Color Picking Tool - UI Design Consistency</em>
</div>

### **Development Tools**
- **Flutter Inspector**: Debug widget tree and properties
- **Riverpod DevTools**: Monitor provider state changes
- **Network Inspector**: Debug API calls and responses
- **Performance Profiler**: Identify performance bottlenecks
- **Color Picking Tools**: Maintain design consistency

### **Testing Strategy**
- **Unit Tests**: Test business logic and utilities
- **Widget Tests**: Test individual widgets and interactions
- **Integration Tests**: Test complete user flows
- **Golden Tests**: Visual regression testing
- **Error Scenario Tests**: Test error handling paths

### **CI/CD Pipeline** (Recommended)
```yaml
# .github/workflows/flutter.yml
name: Flutter CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test
      - run: flutter build apk
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Sourav Barman**
- GitHub: [@SouravBarman001](https://github.com/SouravBarman001)
- LinkedIn: [Sourav Barman](https://linkedin.com/in/souravbarman001)

---

**Happy Coding! 🍕📱**
