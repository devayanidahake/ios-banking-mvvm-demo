# Folder Structure

> This document explains the purpose and responsibility of every top-level folder in the project.
>
> A consistent folder structure improves discoverability, maintainability, onboarding, and long-term scalability.
>
> The project is organized by responsibility rather than file type.

---

# Table of Contents

1. Guiding Principles
2. Current Folder Structure
3. Folder Responsibilities
4. Dependency Rules
5. Feature Organization
6. Naming Conventions
7. Scalability
8. Common Questions
9. Future Evolution

---

# 1. Guiding Principles

The project follows several architectural principles when organizing files.

- Organize by responsibility rather than technology.
- Keep related files together.
- Avoid mixing UI, business logic and infrastructure.
- Make every folder easy to understand.
- Support future modularization.

Every folder should answer one simple question:

> **What responsibility does this folder own?**

---

# 2. Current Folder Structure

```
BankingApp

├── App
├── Core
├── Features
├── Resources
├── Tests
└── Documentation
```

The project intentionally keeps the number of top-level folders small.

As the application grows, new folders should rarely be added.

Instead, existing folders should evolve.

---

# 3. Folder Responsibilities

---

## App

### Responsibility

Contains application startup and composition.

Examples

- BankingAppApp
- RootView
- AppContainer (PR-5)

App is responsible only for bootstrapping the application.

It should never contain business logic.

---

## Core

### Responsibility

Contains reusable infrastructure shared across the application.

Examples

- Networking
- Utilities
- Extensions
- Common Models
- Configuration

Everything inside Core should be reusable.

Core should never depend on Features.

---

## Features

### Responsibility

Contains business features.

Each feature owns its own:

- Views
- ViewModels
- Repository
- Models

Example

```
Features

Account

Transfer

Settings

Authentication
```

Features should be isolated from each other whenever possible.

---

## Resources

### Responsibility

Contains application resources.

Examples

- Assets
- Colors
- Localization
- Fonts
- Images

Business logic should never exist inside Resources.

---

## Tests

### Responsibility

Contains all unit tests.

The test target mirrors the production structure.

Example

```
Tests

Networking

Repositories

Features

Utilities
```

Keeping the same structure improves discoverability.

---

## Documentation

### Responsibility

Contains engineering documentation.

Examples

- Architecture
- Networking
- Testing
- ADR
- Interview Guide

Documentation evolves alongside the codebase.

---

# 4. Dependency Rules

The project follows strict dependency direction.

```
App

↓

Features

↓

Core

↓

Foundation
```

Higher layers may depend on lower layers.

Lower layers must never depend on higher layers.

Example

```
ViewModel

↓

Repository

↓

APIClient

↓

URLSession
```

Never the opposite.

---

# 5. Feature Organization

Each feature follows the same internal structure.

```
Account

Views

ViewModels

Models

Repositories
```

Benefits

- Predictable
- Easy onboarding
- Independent development
- Easier testing

Every new feature should follow this convention.

---

# 6. Naming Conventions

Folders use singular names.

Examples

```
Feature

Repository

Networking

Testing
```

Avoid

```
Helpers

Misc

CommonStuff

Utilities2
```

Folder names should clearly communicate responsibility.

---

# 7. Scalability

The folder structure supports future growth without major restructuring.

Future additions include:

```
Authentication

Dashboard

Payments

Transactions

Profile

Notifications
```

Each feature can be added independently.

---

# 8. Common Questions

## Why not organize by file type?

Instead of:

```
Views

Models

ViewModels
```

The project groups files by responsibility.

This keeps all files related to a feature together.

---

## Why Core?

Core contains reusable infrastructure.

Business features should not duplicate infrastructure.

---

## Why Features?

Business capabilities evolve independently.

Separating them simplifies maintenance.

---

## Why Documentation?

Engineering documentation belongs beside the source code.

It evolves together with the implementation.

---

# 9. Future Evolution

As the project grows, the structure will evolve naturally.

Planned additions include:

- Dependency Injection
- Repository Layer
- Authentication
- Design System
- Offline Persistence
- CI/CD

The top-level structure should remain stable.

Only the contents of each folder should grow.

---

# Summary

The folder structure is intentionally simple.

Every top-level folder owns a single responsibility.

The organization prioritizes:

- Scalability
- Maintainability
- Predictability
- Discoverability

This makes the project easier to navigate, easier to extend and easier to maintain over time.

---

# Related Documentation

- README.md
- Architecture.md
- Networking.md
- Testing.md
- InterviewGuide.md
