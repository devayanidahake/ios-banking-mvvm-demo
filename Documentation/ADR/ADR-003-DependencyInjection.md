# ADR-003: Constructor-Based Dependency Injection

## Status

Accepted

---

## Context

Directly creating dependencies inside business logic tightly couples components and makes unit testing difficult.

Example:

```swift
let apiClient = URLSessionAPIClient()
```

This prevents replacing implementations during testing.

---

## Decision

Use constructor-based dependency injection throughout the project.

Dependencies are provided during initialization rather than created internally.

Examples include:

- APIClient
- HTTPSession
- ResponseValidator
- JSONDecoder

---

## Alternatives Considered

### Singleton

Pros

- Easy access

Cons

- Global state
- Hidden dependencies
- Difficult testing

---

### Property Injection

Pros

- Flexible

Cons

- Dependencies may be missing
- Less explicit

---

## Consequences

### Positive

- Loose coupling
- Better testing
- Explicit dependency graph
- Easier maintenance

### Negative

- Slightly more initialization code

---

## Related Files

- URLSessionAPIClient.swift

---

## Interview Questions

- Why Constructor Injection?
- Why not Singleton?
- Why protocols?
