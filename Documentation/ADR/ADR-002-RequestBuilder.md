# ADR-002: Introduce RequestBuilder

## Status

Accepted

---

## Context

Creating a `URLRequest` requires combining multiple pieces of information including URL, HTTP method, headers, query parameters and body.

Mixing request construction with request execution violates the Single Responsibility Principle.

---

## Decision

Introduce a dedicated `RequestBuilder`.

Its responsibility is only to convert an `Endpoint` into a `URLRequest`.

Request execution remains the responsibility of `APIClient`.

---

## Alternatives Considered

### Build request inside APIClient

Pros

- Fewer files

Cons

- Multiple responsibilities
- Harder testing
- Difficult maintenance

---

## Consequences

### Positive

- Single Responsibility
- Builder Pattern
- Independent testing
- Cleaner APIClient

### Negative

- Additional type to maintain

---

## Related Files

- RequestBuilder.swift
- URLSessionAPIClient.swift

---

## Interview Questions

- Why Builder Pattern?
- Why separate request creation from execution?
