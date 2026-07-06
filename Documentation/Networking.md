# Networking

> This document describes the networking architecture used throughout the project.
>
> It explains the design decisions, request lifecycle, dependency flow, testing strategy, and modern Swift features that make the networking layer scalable, maintainable, and production-ready.

---

# Table of Contents

1. Overview
2. Design Goals
3. Request Lifecycle
4. Networking Components
5. Dependency Flow
6. Error Handling
7. Concurrency
8. Testing
9. Design Decisions
10. Trade-offs
11. Future Improvements
12. Repository Interview Questions

---

# 1. Overview

The networking layer is intentionally designed as a collection of small, focused components rather than one large networking manager.

Each component owns exactly one responsibility.

This approach improves:

- Testability
- Maintainability
- Scalability
- Readability

The networking module follows modern Swift best practices including:

- Protocol-Oriented Programming
- Constructor Dependency Injection
- Structured Concurrency
- Builder Pattern
- Factory Pattern

---

# 2. Design Goals

The networking layer was designed with the following goals.

- Avoid tightly coupled networking code.
- Make every component independently testable.
- Support dependency injection.
- Separate request construction from execution.
- Provide consistent error handling.
- Keep Foundation types isolated.
- Support future authentication, logging and retry mechanisms.

---

# 3. Request Lifecycle

Every request follows the same lifecycle.


SwiftUI View
        │
        ▼
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
        │
        ▼
 HTTP Response
        │
        ▼
 ResponseValidator
        │
        ▼
 JSONDecoder
        │
        ▼
 Decoded Model


Every component performs exactly one task before passing responsibility to the next layer.

---

# 4. Networking Components

## Endpoint

### Responsibility

Represents an API request.

An Endpoint describes:

- Path
- HTTP Method
- Headers
- Query Parameters
- Request Body
- Timeout
- Cache Policy

It intentionally does **not** know how requests are executed.

### Why?

Separating request description from request execution allows new APIs to be added without modifying the networking infrastructure.

---

## RequestBuilder

### Responsibility

Converts an `Endpoint` into a `URLRequest`.

### Why?

Building a request and executing a request are different responsibilities.

Separating them follows the Single Responsibility Principle.

### Benefits

- Easier testing
- Reusable
- Cleaner APIClient

---

## HTTPSession

### Responsibility

Abstracts Foundation's `URLSession`.

### Why?

Instead of depending directly on `URLSession`, the networking layer depends on a protocol.

This allows the transport layer to be replaced during testing.

Production

```
URLSession
```

Testing

```
MockHTTPSession
```

---

## URLSessionAPIClient

### Responsibility

Coordinates the complete request lifecycle.

Responsibilities:

- Build request
- Execute request
- Validate response
- Decode response

It delegates each responsibility to dedicated components.
---

## Repository Integration

Repositories consume the networking layer through the `APIClient` protocol.

Rather than exposing networking details to the presentation layer, repositories:

- Execute API requests
- Convert DTOs into domain models
- Hide infrastructure details from ViewModels

This keeps networking concerns isolated and allows the data source to evolve without impacting the presentation layer.
---

## ResponseValidator

### Responsibility

Validates HTTP status codes.

Maps transport responses into domain-specific errors.

Example

```
401

↓

NetworkError.unauthorized
```

The APIClient does not contain HTTP validation logic.

---

## JSONDecoderFactory

### Responsibility

Creates consistently configured `JSONDecoder` instances.

Benefits

- Centralized configuration
- Consistent decoding
- Easy maintenance

---

## NetworkError

### Responsibility

Represents networking errors using application-specific semantics.

The UI never depends directly on Foundation networking errors.

---

# 5. Dependency Flow

The networking layer follows constructor injection.

```
APIClient

↓

RequestBuilder

↓

HTTPSession

↓

URLSession
```

No object creates its own dependencies.

Object creation is handled by the Composition Root.

---

# 6. Error Handling

Errors are mapped into `NetworkError`.

```
URLError.notConnectedToInternet

↓

NetworkError.noInternet
```

```
HTTP 401

↓

NetworkError.unauthorized
```

```
DecodingError

↓

NetworkError.decodingFailed
```

Benefits

- Consistent API
- Cleaner ViewModels
- Easier Testing

---

# 7. Concurrency

The networking layer uses Swift Structured Concurrency.

Features used:

- async / await
- Sendable
- Actor isolation

The project intentionally avoids callback-based networking APIs.

---

# 8. Testing

Every networking component is tested independently.

Current test coverage includes:

- RequestBuilder
- ResponseValidator
- URLSessionAPIClient
- DashboardRepository

Testing infrastructure includes:

- MockHTTPSession
- TestEndpoint
- XCTestCase+Async

The focus is on testing observable behavior rather than implementation details.

---

# 9. Design Decisions

## Why Endpoint?

Separates request definition from request execution.

---

## Why RequestBuilder?

Keeps URLRequest creation independent.

---

## Why HTTPSession?

Makes networking testable.

---

## Why ResponseValidator?

Keeps HTTP validation separate from request execution.

---

## Why JSONDecoderFactory?

Centralizes decoder configuration.

---

## Why Constructor Injection?

Makes dependencies explicit.

Improves testing.

Avoids hidden dependencies.

---

# 10. Trade-offs

Advantages

- Highly testable
- Easy to extend
- Small focused components
- Modern Swift
- Clean dependency graph

Trade-offs

- More files
- Additional abstractions
- Slightly higher onboarding cost

The architecture intentionally favors maintainability over minimal file count.

---

# 11. Future Improvements

The networking layer has been designed to support future enhancements without significant architectural changes.

Planned improvements include:

- Authentication Interceptors
- Request Logging
- Retry Policies
- Metrics
- Certificate Pinning
- Request Cancellation
- Pagination Helpers
- Network Reachability

---

# 12. Repository Interview Questions

## Why Endpoint instead of URLRequest?

Because Endpoint describes a request while RequestBuilder constructs a URLRequest.

---

## Why Builder Pattern?

Request creation and request execution are separate responsibilities.

---

## Why HTTPSession?

It removes the dependency on URLSession and makes the networking layer testable.

---

## Why ResponseValidator?

It isolates HTTP validation from request execution.

---

## Why JSONDecoderFactory?

Decoder configuration exists in one place.

---

## Why async/await?

Cleaner asynchronous code with structured concurrency.

---

## Why Sendable?

Provides compile-time thread safety.

---

## Why Actor?

Actors protect mutable shared state used by concurrent code.

---

## Why protocol-based Dependency Injection?

High-level modules depend on abstractions instead of implementations.

---

# Summary

The networking layer emphasizes simplicity, explicit dependencies, modern Swift concurrency, and protocol-oriented design.

Every component has a single responsibility, every dependency is injectable, and every layer is independently testable.

The result is a networking architecture that is suitable for production applications while remaining easy to understand, extend and maintain.
