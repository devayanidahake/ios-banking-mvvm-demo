# ADR-001: Use Endpoint Protocol

## Status

Accepted

---

## Context

The application requires a scalable way to define API requests without tightly coupling networking logic to specific endpoints.

Directly creating `URLRequest` objects throughout the codebase would lead to duplicated logic and make the networking layer harder to maintain.

---

## Decision

Introduce an `Endpoint` protocol that describes an API request.

Each endpoint defines:

- Path
- HTTP Method
- Headers
- Query Parameters
- Request Body
- Timeout
- Cache Policy

The networking layer is responsible for converting an `Endpoint` into a `URLRequest`.

---

## Alternatives Considered

### Build URLRequest directly

Pros

- Less code
- Simple for small projects

Cons

- Repeated request-building logic
- Difficult to test
- Hard to maintain

---

### Enum Router

Pros

- Simple

Cons

- Large switch statements
- Poor scalability

---

## Consequences

### Positive

- Scalable
- Testable
- Open for extension
- Cleaner networking layer

### Negative

- Adds one additional abstraction

---

## Related Files

- Endpoint.swift
- RequestBuilder.swift

---

## Interview Questions

- Why Endpoint?
- Why not URLRequest directly?
- Why not enum Router?
