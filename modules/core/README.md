# Core Module

A shared Flutter module providing essential functionality and utilities for the six_amtech_task application.

## Overview

The Core module serves as the foundation layer for the six_amtech_task project, containing shared utilities, services, and common functionality that can be reused across different parts of the application.

### Key Features

- **State Management**: Built with Riverpod for reactive state management
- **Network Layer**: HTTP client implementation using Dio with custom interceptors
- **Data Persistence**: Local storage capabilities using Hive database
- **Logging System**: Structured logging with configurable levels
- **Code Generation**: Support for JSON serialization and immutable data classes
- **Type Safety**: Equatable integration for value equality comparisons

### Dependencies

#### Core Dependencies
- `flutter_riverpod` - State management solution
- `dio` - HTTP client for API communications
- `hive` & `hive_flutter` - NoSQL database for local storage
- `logger` - Logging utility
- `equatable` - Value equality for Dart classes

#### Development Tools
- `freezed` - Code generation for immutable classes
- `json_serializable` - JSON serialization code generation
- `build_runner` - Code generation runner
- `riverpod_lint` - Linting rules for Riverpod
- `flutter_gen_runner` - Asset generation

## Usage

This module is designed to be imported as a dependency in the main application. It provides the core infrastructure and utilities needed for building robust Flutter applications.

```yaml
dependencies:
  core:
    path: modules/core
```
