# Architecture

> This document describes the architectural decisions, design principles, dependency flow, and scalability considerations used throughout the BankingApp project.
>
> The primary goal of this architecture is to build a modular, testable, scalable, and production-ready iOS application using modern Swift.

---

# Table of Contents

1. Overview
2. Architectural Goals
3. High-Level Architecture
4. Layer Responsibilities
5. Dependency Flow
6. Design Principles
7. Design Patterns
8. Dependency Injection
9. Concurrency Model
10. Error Handling
11. Testing Strategy
12. Scalability
13. Trade-offs
14. Future Evolution

---

# 1. Overview

The project follows a layered architecture inspired by Clean Architecture and modern MVVM principles.

Instead of tightly coupling networking, business logic, and presentation, each layer owns a single responsibility and communicates only through abstractions.

The architecture is designed to be:

- Modular
- Testable
- Scalable
- Maintainable
- Easy to evolve

---

# 2. Architectural Goals

The architecture was designed around the following goals:

- Separate concerns into independent layers.
- Prefer composition over inheritance.
- Depend on abstractions rather than implementations.
- Keep every component independently testable.
- Support Swift Concurrency.
- Avoid global state.
- Enable future modularization using Swift Packages.

---

# 3. High-Level Architecture

```text
                SwiftUI Views
                       │
                       ▼
                  ViewModels
                       │
                       ▼
                  Repositories
                       │
                       ▼
                  APIClient
                       │
        ┌──────────────┴──────────────┐
        ▼                             ▼
 RequestBuilder              ResponseValidator
        │
        ▼
    HTTPSession
        │
        ▼
    URLSession
```

Dependencies always flow downward.

Higher layers never know implementation details of lower layers.

---

# 4. Layer Responsibilities

## SwiftUI Views

Responsible for:

- Rendering UI
- Handling user interactions
- Binding ViewModel state

Views never perform networking or business logic.

---

## ViewModels

Responsible for:

- UI state
- Business flow orchestration
- Calling repositories

ViewModels never create dependencies.

---

## Repositories

Responsible for:

- Data access
- Combining multiple data sources
- Business data transformations

Repositories hide networking and persistence details.

---

## APIClient

Responsible for:

- Executing requests
- Returning decoded models

APIClient delegates:

- Request creation
- Response validation
- Decoding

to dedicated components.

---

## RequestBuilder

Responsible only for converting an `Endpoint` into a `URLRequest`.

It never executes requests.

---

## HTTPSession

Responsible only for transport.

The protocol abstracts Foundation's `URLSession`.

---

## ResponseValidator

Responsible only for validating HTTP responses.

It does not know how requests are created or executed.

---

## JSONDecoderFactory

Responsible for creating consistently configured `JSONDecoder` instances.

---

# 5. Dependency Flow

Every dependency is injected through constructors.

```text
ViewModel
        │
        ▼
Repository
        │
        ▼
APIClient
        │
        ▼
RequestBuilder
        │
        ▼
HTTPSession
        │
        ▼
URLSession
```

Object creation is centralized.

Dependencies are never created inside business logic.

---

# 6. Design Principles

The architecture follows the following principles:

## Single Responsibility Principle

Each type has one reason to change.

Examples:

- RequestBuilder
- ResponseValidator
- JSONDecoderFactory

---

## Dependency Inversion Principle

High-level modules depend on protocols.

Examples:

- APIClient
- HTTPSession

Concrete implementations can be replaced without changing consumers.

---

## Open-Closed Principle

Adding a new API endpoint requires creating a new `Endpoint`.

Existing networking code remains unchanged.

---

## Composition Over Inheritance

Behavior is composed through dependency injection.

Inheritance is intentionally minimized.

---

## Protocol-Oriented Programming

Protocols define contracts.

Implementations remain replaceable.

---

# 7. Design Patterns

The following design patterns are used throughout the project.

| Pattern | Implementation |
|----------|----------------|
| MVVM | Presentation Layer |
| Repository | Data Layer |
| Builder | RequestBuilder |
| Factory | JSONDecoderFactory |
| Dependency Injection | Constructor Injection |
| Strategy | HTTPSession implementations |
| Composition Root | AppContainer *(Introduced in PR-5)* |

---

# 8. Dependency Injection

The project uses constructor injection.

Example:

```swift
URLSessionAPIClient(
    session: session,
    requestBuilder: requestBuilder,
    responseValidator: responseValidator,
    decoder: decoder
)
```

Benefits:

- Loose coupling
- Better testing
- Clear dependency graph
- Easier maintenance

No object creates its own dependencies.

---

# 9. Concurrency Model

The project adopts Swift Structured Concurrency.

Key features:

- async / await
- Sendable
- Actor isolation
- Cooperative cancellation

The networking layer avoids callback-based APIs.

---

# 10. Error Handling

Errors are mapped into a domain-specific `NetworkError`.

The UI never depends directly on `URLError` or Foundation networking errors.

Benefits:

- Consistent API
- Easier testing
- Clear business semantics

---

# 11. Testing Strategy

Every architectural component is tested independently.

Current coverage includes:

- RequestBuilder
- ResponseValidator
- URLSessionAPIClient

Testing uses:

- XCTest
- MockHTTPSession
- TestEndpoint
- Async test helpers

The focus is on testing observable behavior rather than implementation details.

---

# 12. Scalability

The architecture supports future expansion including:

- Authentication
- Repository Layer
- Offline Persistence
- Swift Package modularization
- Logging
- Request Interceptors
- Retry Policies
- Analytics
- Feature Flags

These additions can be introduced without major architectural changes.

---

# 13. Trade-offs

Every architecture involves trade-offs.

Advantages:

- Excellent testability
- Clear separation of concerns
- Easy maintenance
- High scalability

Trade-offs:

- More files than a simple demo project
- Additional abstraction
- Slightly higher initial learning curve

These trade-offs are intentional in favor of long-term maintainability.

---

# 14. Future Evolution

The architecture will continue evolving through the following milestones:

- Composition Root
- Repository Layer
- Authentication
- Offline Persistence
- Design System
- Feature Modules
- CI/CD Pipeline

Each milestone builds upon the current architecture without requiring major refactoring.

---

# Summary

This architecture emphasizes simplicity, explicit dependencies, protocol-oriented design, and modern Swift best practices.

The project intentionally favors long-term maintainability over short-term convenience, making it suitable for production-scale applications and technical interviews alike.
