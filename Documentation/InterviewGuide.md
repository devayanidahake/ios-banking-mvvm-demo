# Repository Interview Guide

> This document contains interview questions and answers specific to this repository.
>
> Every answer can be demonstrated directly from the source code.
>
> The purpose of this guide is to explain the architectural decisions behind the project rather than provide generic iOS interview preparation.

---

# Table of Contents

1. Architecture
2. Dependency Injection
3. Networking
4. Swift Concurrency
5. Testing
6. Git Strategy
7. Design Patterns
8. Scalability
9. Future Improvements

---

# 1. Architecture

---

## Why MVVM?

### Code Reference

Features/*

### Answer

MVVM separates presentation logic from the UI.

Views remain responsible only for rendering.

Business logic belongs inside ViewModels.

Benefits:

- Better separation of concerns
- Easier testing
- Better maintainability
- Cleaner SwiftUI Views

---

## Why Repository Pattern?

### Code Reference

(Implemented in future PR)

### Answer

Repositories abstract data sources from the presentation layer.

Today data comes from networking.

Tomorrow the same repository can combine:

- Remote APIs
- Local database
- Cache

without affecting ViewModels.

---

## Why Clean Architecture?

### Answer

The architecture separates responsibilities into independent layers.

Each layer depends only on abstractions.

This improves:

- Testability
- Scalability
- Replaceability

---

# 2. Dependency Injection

---

## Why Constructor Injection?

### Code Reference

URLSessionAPIClient.swift

### Answer

Dependencies are supplied during initialization rather than created internally.

Benefits:

- Explicit dependencies
- Easier testing
- Better maintainability

---

## Why not Singleton?

### Answer

Singletons introduce hidden dependencies and global state.

Constructor Injection keeps dependencies explicit and replaceable.

---

## Why protocols?

### Code Reference

APIClient

HTTPSession

Endpoint

### Answer

Protocols decouple implementation from usage.

Production and test implementations become interchangeable.

---

# 3. Networking

---

## Why Endpoint?

### Code Reference

Endpoint.swift

### Answer

Endpoint describes an API request without executing it.

Responsibilities include:

- Path
- HTTP Method
- Headers
- Query Parameters
- Request Body

This separates request definition from execution.

---

## Why RequestBuilder?

### Code Reference

RequestBuilder.swift

### Answer

RequestBuilder converts an Endpoint into a URLRequest.

It follows the Builder Pattern.

Benefits:

- Single Responsibility
- Easier testing
- Better separation of concerns

---

## Why URLComponents?

### Code Reference

RequestBuilder.swift

### Answer

URLComponents safely constructs URLs.

Benefits:

- Automatic percent encoding
- Safer query parameter handling
- Reduced risk of malformed URLs

---

## Why HTTPSession?

### Code Reference

HTTPSession.swift

### Answer

HTTPSession abstracts Foundation's URLSession.

Benefits:

- Easy mocking
- Better testing
- Dependency inversion

---

## Why APIClient?

### Code Reference

APIClient.swift

### Answer

APIClient defines the networking contract.

Consumers depend on the protocol instead of a concrete implementation.

---

## Why ResponseValidator?

### Code Reference

ResponseValidator.swift

### Answer

HTTP validation is separated from networking execution.

This keeps APIClient focused on orchestration rather than HTTP status code interpretation.

---

## Why JSONDecoderFactory?

### Code Reference

JSONDecoderFactory.swift

### Answer

Centralizes decoder configuration.

Every decoder is configured consistently.

---

## Why NetworkError?

### Code Reference

NetworkError.swift

### Answer

Maps Foundation networking errors into application-specific errors.

The UI never depends directly on URLError.

---

# 4. Swift Concurrency

---

## Why async/await?

### Answer

Provides structured concurrency with cleaner asynchronous code.

Benefits:

- Better readability
- Automatic error propagation
- Cancellation support

---

## Why Sendable?

### Code Reference

Networking Models

### Answer

Sendable provides compile-time guarantees for values crossing concurrency boundaries.

---

## Why Actor?

### Code Reference

MockHTTPSession.swift

### Answer

Actors protect mutable shared state.

Using an actor for MockHTTPSession ensures thread safety during concurrent test execution.

---

# 5. Testing

---

## Why MockHTTPSession?

### Code Reference

MockHTTPSession.swift

### Answer

Prevents real network requests during testing.

Tests remain deterministic and fast.

---

## Why TestEndpoint?

### Code Reference

TestEndpoint.swift

### Answer

Provides a reusable configurable Endpoint implementation for networking tests.

Avoids duplication.

---

## Why XCTestCase+Async?

### Code Reference

XCTestCase+Async.swift

### Answer

Encapsulates reusable asynchronous assertions.

Improves readability and consistency.

---

## Why Arrange–Act–Assert?

### Answer

Provides a consistent structure across the test suite.

Benefits:

- Easier review
- Easier debugging
- Better readability

---

## Why one behavior per test?

### Answer

Focused tests produce clearer failures and simplify maintenance.

---

# 6. Git Strategy

---

## Why small PRs?

Each Pull Request introduces one logical change.

Benefits:

- Easier reviews
- Smaller diffs
- Simpler rollbacks

---

## Why feature branches?

Feature branches isolate work from the main branch.

---

## Why Squash Merge?

Keeps the main branch history clean while preserving detailed commit history within the Pull Request.

---

# 7. Design Patterns

| Pattern | Usage |
|----------|------|
| MVVM | Presentation Layer |
| Repository | Data Layer |
| Builder | RequestBuilder |
| Factory | JSONDecoderFactory |
| Strategy | HTTPSession |
| Dependency Injection | Constructor Injection |
| Composition Root | AppContainer *(PR-6)* |

---

# 8. Scalability

The architecture has been designed to support future additions including:

- Repository Layer
- Authentication
- Offline Persistence
- Retry Policies
- Request Interceptors
- Logging
- Analytics
- Swift Package modularization

without requiring major architectural changes.

---

# 9. Future Improvements

Planned milestones include:

- Composition Root
- Repository Layer
- Authentication
- Design System
- Offline Persistence
- CI/CD
- Feature Modules

Each milestone builds upon the existing architecture rather than replacing it.

---

# Summary

Every architectural decision in this repository was made with the following priorities:

- Maintainability
- Testability
- Scalability
- Modern Swift
- Explicit dependencies
- Production-readiness

The project intentionally favors clean architecture and long-term maintainability over minimizing the number of files.

---

# Related Documentation

- README.md
- Architecture.md
- Networking.md
- FolderStructure.md
- Testing.md
