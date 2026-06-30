# Networking Module

## Responsibilities

- Build URLRequest

- Execute HTTP requests

- Validate HTTP responses

- Decode JSON

## Architecture

Endpoint
↓

RequestBuilder
↓

HTTPSession
↓

ResponseValidator
↓

JSONDecoder
↓

APIClient

## Design Patterns

- Builder

- Factory

- Strategy

- Dependency Injection

## SOLID

SRP

DIP

OCP

## Interview Topics

- Why Endpoint?

- Why Builder?

- Why Protocol?

- Why async/await?

- Why Sendable?

- Why URLComponents?

Interview Topics
Why Endpoint?

Answer

The Endpoint protocol defines what an API request needs rather than how it is executed. It describes request metadata such as the path, HTTP method, headers, query parameters, and request body without depending on URLRequest or URLSession.

Why?
Separates request definition from request execution.
Keeps endpoints independent of Foundation networking APIs.
Makes adding new APIs straightforward without modifying existing networking code.
Follows the Open/Closed Principle (OCP).
Benefits
Reusable
Easy to unit test
Feature-oriented
Scalable for large applications
Why RequestBuilder?

Answer

RequestBuilder is responsible for converting an Endpoint into a URLRequest.

It follows the Builder Pattern by encapsulating the logic of constructing a complex object.

Why?

Without a builder, every API call would duplicate:

URL creation
Query parameter encoding
Header configuration
Timeout configuration
Cache policy configuration

By centralizing this logic, every request is created consistently.

Benefits
Single Responsibility Principle (SRP)
Eliminates duplicate code
Easy to extend
Easy to test
Why Protocols?

Answer

Protocols define contracts, not implementations.

High-level components should depend on abstractions instead of concrete types.

Example:

Repository
        │
        ▼
APIClient (Protocol)
        │
        ▼
URLSessionAPIClient

This follows the Dependency Inversion Principle (DIP).

Benefits
Loose coupling
Easy mocking
Better unit testing
Multiple implementations without changing consumers

Examples:

HTTPSession
APIClient
Endpoint
Why async/await?

Answer

Swift Concurrency provides a safer and more readable way to perform asynchronous work compared to completion handlers.

Instead of nested callbacks:

apiClient.request { result in
    ...
}

we write:

let accounts = try await apiClient.request(endpoint)
Benefits
Readable linear code
Structured concurrency
Automatic error propagation
Cancellation support
Better debugging
Easier unit testing
Why Sendable?

Answer

Sendable indicates that a type can safely cross concurrency boundaries.

As the networking layer is fully based on Swift Concurrency, models transferred between asynchronous tasks should conform to Sendable.

Benefits
Compile-time thread-safety checks
Future-proof for Swift 6+
Prevents data races
Documents concurrency intent

Examples:

HTTPMethod
NetworkConfiguration
DTOs
Why URLComponents?

Answer

URLComponents safely constructs URLs by handling:

Query parameters
URL encoding
Reserved characters
Unicode characters

Instead of manually concatenating strings:

let url = URL(string: baseURL + path)

we use:

URLComponents(...)

which is safer and less error-prone.

Benefits
Correct URL encoding
Prevents malformed URLs
Handles query parameters automatically
Recommended Foundation API
Design Patterns Used
Pattern    Usage
Builder    RequestBuilder
Factory    JSONDecoderFactory
Strategy    HTTPSession, Endpoint implementations
Dependency Injection    Constructor injection throughout the networking layer
Protocol-Oriented Programming    APIClient, Endpoint, HTTPSession
SOLID Principles
Principle    Implementation
Single Responsibility    RequestBuilder, ResponseValidator, JSONDecoderFactory each have one responsibility
Open/Closed    New endpoints can be added without modifying the networking infrastructure
Liskov Substitution    Any implementation of HTTPSession or APIClient can replace another
Interface Segregation    Small focused protocols (Endpoint, HTTPSession, APIClient)
Dependency Inversion    High-level layers depend on abstractions rather than concrete implementations


Decision    Why Chosen    Why Not
Endpoint Protocol    Extensible, testable    Not a single enum API because it doesn't scale well
RequestBuilder    SRP, reusable    Not building URLRequest inside repositories to avoid duplication
HTTPSession Protocol    Mockable, DI-friendly    Not URLSession.shared because it couples the code to Foundation and hurts testing
JSONDecoderFactory    Centralized decoder configuration    Not JSONDecoder() everywhere because it duplicates configuration
async/await    Modern Swift concurrency    Not completion handlers because they're harder to read, compose, and test



