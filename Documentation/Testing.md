# Testing

> This document describes the testing strategy, testing philosophy, and supporting infrastructure used throughout the project.
>
> The goal is to ensure every architectural component can be verified independently through deterministic, fast and maintainable unit tests.

---

# Table of Contents

1. Testing Philosophy
2. Testing Pyramid
3. Test Organization
4. Test Infrastructure
5. Testing Principles
6. Naming Convention
7. Async Testing
8. Mocking Strategy
9. Current Test Coverage
10. Future Improvements
11. Repository Interview Questions

---

# 1. Testing Philosophy

Testing is considered a first-class part of the architecture rather than an afterthought.

The project emphasizes:

- Fast execution
- Deterministic behavior
- Independent components
- Clear failure messages
- Behavior-driven testing

Tests should verify observable behavior instead of implementation details.

---

# Why test behavior instead of implementation?

Implementation changes over time.

Behavior should remain stable.

For example:

Instead of testing whether a specific private method is called, tests verify the final observable result.

This allows internal refactoring without breaking the test suite.

---

# 2. Testing Pyramid

The project follows the traditional testing pyramid.

```
                UI Tests
                   ▲
                   │
          Integration Tests
                   ▲
                   │
             Unit Tests
```

Current focus:

✅ Unit Tests

Future additions:

- Integration Tests
- UI Tests

---

# 3. Test Organization

The test target mirrors the production structure.

```
BankingAppTests

Networking

Repositories

Features

Utilities
```

Keeping the same structure makes files easier to locate.

---

# 4. Test Infrastructure

The project includes reusable testing infrastructure.

---

## MockHTTPSession

Purpose

Replaces URLSession during testing.

Benefits

- No real network requests
- Deterministic results
- Fast execution

---

## TestEndpoint

Purpose

Provides a reusable configurable Endpoint for networking tests.

Avoids duplicated endpoint definitions.

---

## XCTestCase+Async

Purpose

Provides reusable asynchronous assertion helpers.

Benefits

- Less duplicated code
- Better readability
- Consistent failure messages

---

# 5. Testing Principles

The following principles are applied throughout the project.

---

## Arrange – Act – Assert

Every test follows the same structure.

```
Arrange

Act

Assert
```

Benefits

- Consistent layout
- Easy to review
- Easy to debug

---

## One Behavior Per Test

Each test verifies one behavior.

Example

```
test_request_givenTimeout_throwsRequestTimedOut()
```

The test does not verify unrelated functionality.

---

## Independent Tests

Tests should never depend on the execution order of other tests.

Every test prepares its own data.

---

## Deterministic Tests

Tests always produce the same result.

No:

- Network
- Time
- Random values
- External services

---

## Readability

Tests are documentation.

A developer should understand the behavior without reading production code.

---

# 6. Naming Convention

Tests follow the pattern:

```
test_<method>_given<condition>_<expectedResult>()
```

Examples

```
test_request_givenSuccessfulResponse_returnsDecodedModel()

test_request_givenTimeout_throwsRequestTimedOut()

test_build_givenGETEndpoint_createsGETRequest()
```

Benefits

- Self-documenting
- Easy searching
- Consistent style

---

# 7. Async Testing

The networking layer uses Swift Structured Concurrency.

Tests also use async/await.

Example

```
let account: AccountDTO = try await sut.request(endpoint)
```

Benefits

- Cleaner code
- Better readability
- No expectation-based callback testing

---

# 8. Mocking Strategy

The project prefers protocol-based mocking.

Example

```
HTTPSession

↓

MockHTTPSession
```

The networking layer never depends directly on URLSession during testing.

Benefits

- Fast
- Reliable
- Isolated

---

# Why not mock URLSession directly?

Foundation networking is already tested by Apple.

Our responsibility is to test application behavior.

---

# 9. Current Test Coverage

Networking

- RequestBuilder
- ResponseValidator
- URLSessionAPIClient

Supporting Infrastructure

- MockHTTPSession
- TestEndpoint
- XCTestCase+Async

Future coverage will include:

- Repositories
- ViewModels
- Authentication
- Persistence

---

# 10. Future Improvements

The testing strategy is designed to evolve.

Planned additions include:

- Repository Tests
- ViewModel Tests
- Snapshot Tests
- Integration Tests
- UI Tests
- Performance Tests
- Code Coverage Reports
- Continuous Integration

---

# 11. Repository Interview Questions

## Why MockHTTPSession?

To isolate the networking layer from Foundation networking.

---

## Why TestEndpoint?

To reuse a configurable endpoint across networking tests.

---

## Why async tests?

To match production code and simplify asynchronous testing.

---

## Why one behavior per test?

Smaller tests are easier to understand and maintain.

---

## Why Arrange–Act–Assert?

Provides a consistent structure across the entire test suite.

---

## Why test behavior instead of implementation?

Behavior is stable.

Implementation evolves.

---

## Why deterministic tests?

Reliable tests build confidence.

Flaky tests reduce trust.

---

# Summary

The testing strategy emphasizes simplicity, determinism and maintainability.

Every architectural component is tested independently using protocol-based dependency injection and reusable test infrastructure.

The result is a fast, reliable and scalable unit test suite that supports long-term development and confident refactoring.

---

# Related Documentation

- README.md
- Architecture.md
- Networking.md
- FolderStructure.md
- InterviewGuide.md
