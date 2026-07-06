# ADR-004: Unit Testing Strategy

## Status

Accepted

---

## Context

The networking layer should be tested without making real HTTP requests.

Tests must be deterministic, fast and independent.

---

## Decision

Adopt a unit testing strategy based on protocol-oriented dependency injection.

Supporting infrastructure includes:

- MockHTTPSession
- TestEndpoint
- XCTestCase+Async

Tests focus on observable behavior rather than implementation details.

---

## Alternatives Considered

### Test real APIs

Pros

- Tests full integration

Cons

- Slow
- Flaky
- Network dependent

---

### Mock URLSession directly

Pros

- Uses Foundation

Cons

- More complex
- Less isolated

---

## Consequences

### Positive

- Fast execution
- Reliable tests
- Easy debugging
- Independent components

### Negative

- Requires additional mock implementations

---

## Related Files

- MockHTTPSession.swift
- TestEndpoint.swift
- XCTestCase+Async.swift

---

## Interview Questions

- Why MockHTTPSession?
- Why behavior testing?
- Why one behavior per test?
- Why async tests?

