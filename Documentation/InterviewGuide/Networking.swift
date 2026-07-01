//
//  Networking.swift
//  BankingApp
//
//  Created by Devayani Purandare on 29/06/26.
//
///
/*
# Interview Notes - HTTPMethod.swift

---

## Q1. Why did you use an enum instead of String?

### Expected Senior Answer

Using an enum provides compile-time safety.

Instead of:

```swift
request.httpMethod = "POST"
```

someone could accidentally write:

```swift
request.httpMethod = "Psot"
```

which would only fail at runtime.

Using

```swift
HTTPMethod.post
```

ensures only valid HTTP methods can be used.

**Benefits**

* Compile-time safety
* Better autocomplete
* Easier refactoring
* No magic strings

---

## Q2. Why is HTTPMethod a RawRepresentable enum?

### Answer

Foundation's `URLRequest` expects the HTTP method as a `String`.

By making it:

```swift
enum HTTPMethod: String
```

we can simply write:

```swift
request.httpMethod = endpoint.method.rawValue
```

without additional mapping.

---

## Q3. Why conform to Sendable?

### Answer

Our networking layer uses Swift Concurrency (`async/await`).

Objects crossing concurrency boundaries should conform to `Sendable` to guarantee thread safety.

Although enums without associated mutable values are naturally safe, explicitly adopting `Sendable` documents the intent and aligns with Swift 6 concurrency.

---

## Q4. Why not use a struct?

### Answer

An enum restricts values to a finite set.

A struct could allow invalid HTTP methods.

Enums better model protocols like HTTP where only predefined methods are valid.

---

## Q5. Why include all HTTP methods instead of only GET and POST?

### Answer

A reusable networking layer should support the HTTP specification rather than the current application.

Even if today's banking app only uses GET and POST, tomorrow it may require:

* PUT
* PATCH
* DELETE
* HEAD
* OPTIONS

Adding them later would require modifying the networking foundation.

---

## Q6. Which SOLID principle does this follow?

**Single Responsibility**

The enum has one responsibility:

Represent HTTP methods.

---

## Q7. Which design pattern is used?

Not every file implements a design pattern.

This file demonstrates:

* Strong Type Modeling
* Value Semantics
* Protocol-Oriented Programming (`Sendable`)

---

## Common Follow-up Question

**Why didn't you use Foundation's built-in HTTPMethod?**

Answer:

This project intentionally models its own networking abstractions to keep the networking layer independent and interview-friendly.

---

# Interview Notes - NetworkError.swift

---

## Q1. Why create a custom NetworkError instead of using Error?

### Expected Senior Answer

Using the generic `Error` protocol leaks implementation details.

Instead, the networking layer exposes **semantic errors**.

For example:

```swift
NetworkError.noInternet
```

instead of

```swift
URLError.notConnectedToInternet
```

The rest of the application shouldn't depend on Foundation networking errors.

---

## Q2. Why conform to LocalizedError?

### Answer

LocalizedError provides a user-facing description.

UI can simply display:

```swift
error.localizedDescription
```

without additional mapping.

It also centralizes user-friendly messages.

---

## Q3. Why remove Equatable?

### Answer

Initially it seemed useful for unit tests.

However,

```swift
case decodingFailed(Error)
```

prevents automatic Equatable synthesis.

Rather than writing unnecessary comparison logic, we removed Equatable because it's not essential.

Tests should verify behavior rather than compare raw errors.

---

## Q4. Why remove the associated Error values?

### Answer

Instead of:

```swift
case unknown(Error)
```

we use:

```swift
case unknown
```

Reasons:

* Keeps the enum `Sendable`
* Avoids leaking Foundation implementation details
* Simplifies testing
* Logging belongs in the logging layer, not in the error model

---

## Q5. Why categorize errors?

Instead of

```swift
case unknown
```

for everything,

we categorize:

Request

Transport

Response

Parsing

Unknown

Benefits:

* Easier debugging
* Better analytics
* Better UI handling
* Easier monitoring

---

## Q6. Why not expose URLError directly?

### Answer

The Domain and Features layers should not know Foundation networking types.

Otherwise they become tightly coupled to URLSession.

The networking layer acts as an abstraction.

---

## Q7. How would you handle logging?

The networking layer throws:

```swift
NetworkError.decodingFailed
```

The original error is logged by:

```swift
Logger
```

This keeps responsibilities separated.

---

## Q8. Which SOLID principles are demonstrated?

### Single Responsibility

Only represents networking failures.

### Dependency Inversion

Higher layers depend on NetworkError instead of Foundation errors.

---

## Q9. How would you extend this in production?

Examples:

```swift
case rateLimited

case maintenance

case sslPinningFailed

case certificateExpired

case requestCancelledByUser
```

No architecture changes required.

---

## Q10. Why not use NSError everywhere?

NSError belongs to Objective-C APIs.

Swift encourages expressive enums with associated meaning.

Enums provide:

* exhaustive switching
* better readability
* stronger typing

---

## Common Follow-up Question

**Why not have one AppError instead of NetworkError?**

Answer:

Each layer should model its own failures.

Examples:

```text
NetworkError

AuthenticationError

PersistenceError

ValidationError
```

Later, these can be mapped into a higher-level `AppError` if the presentation layer needs a single abstraction.

---

# Endpoint Protocol - Interview Notes

## Q1. Why did you create an Endpoint protocol?

### Answer

The Endpoint protocol defines the metadata required to make an API request without coupling it to the networking implementation.

It represents **what** the request is, not **how** the request is executed.

This keeps the networking layer modular and follows the Single Responsibility Principle.

Responsibilities are clearly separated:

* Endpoint → describes an API
* RequestBuilder → converts Endpoint into URLRequest
* APIClient → executes the request
* ResponseValidator → validates the response

This separation makes every component independently testable.

---

## Q2. Why use a protocol instead of a concrete class?

### Answer

Protocols provide abstraction and allow different endpoint implementations.

For example:

* LoginEndpoint
* AccountsEndpoint
* TransactionsEndpoint

Each endpoint only provides its own metadata while sharing the same networking pipeline.

Benefits:

* Loose coupling
* Easier unit testing
* Better scalability
* Open/Closed Principle

---

## Q3. Why not use URLRequest directly?

### Answer

URLRequest belongs to Foundation and contains transport-specific details.

If ViewModels or repositories start creating URLRequest objects directly:

* business logic becomes coupled to Foundation
* request creation logic is duplicated
* testing becomes harder

Instead:

Endpoint → RequestBuilder → URLRequest

Only one component knows how to build URLRequest.

---

## Q4. Why isn't baseURL inside Endpoint?

### Answer

The base URL is environment configuration, not endpoint information.

The endpoint should only know:

* path
* HTTP method
* headers
* query parameters
* body

The base URL changes between:

* Development
* QA
* Staging
* Production

Keeping it inside NetworkConfiguration allows changing environments without modifying endpoint implementations.

---

## Q5. Why provide default implementations in the protocol extension?

### Answer

Most endpoints don't need:

* custom headers
* request body
* query parameters
* timeout

If every endpoint had to implement them, it would create unnecessary boilerplate.

Using protocol extensions:

* keeps endpoint implementations concise
* improves readability
* allows overriding only when needed

This follows the DRY (Don't Repeat Yourself) principle.

---

## Q6. Why not use an enum for all APIs?

Example:

enum API {
case login
case accounts
case transactions
}

### Answer

An enum works well for small applications but becomes difficult to maintain as the application grows.

Large enterprise applications often have hundreds of endpoints.

A protocol-based design allows each feature to own its own endpoint types without modifying a central enum.

This follows the Open/Closed Principle.

---

## Q7. Why store body as Data instead of Encodable?

### Answer

Protocols cannot easily store values of type Encodable because it is a protocol with associated behavior.

Using Data keeps Endpoint simple and independent.

Encoding responsibility belongs to RequestBuilder.

This creates a cleaner separation of responsibilities.

---

## Q8. Which SOLID principles does Endpoint follow?

* Single Responsibility

  * Endpoint only describes request metadata.

* Open/Closed

  * New endpoints are added without modifying existing ones.

* Dependency Inversion

  * APIClient depends on the Endpoint abstraction rather than concrete request types.

---

## Q9. Which design patterns are demonstrated?

* Protocol-Oriented Programming
* Builder Pattern (RequestBuilder)
* Strategy Pattern (different Endpoint implementations)
* Dependency Injection (Endpoint injected into APIClient)

---

## Q10. How would this scale in a large banking application?

Example:

Authentication/
LoginEndpoint.swift

Accounts/
AccountsEndpoint.swift

Cards/
CardsEndpoint.swift

Transfers/
TransferEndpoint.swift

Loans/
LoanEndpoint.swift

Each feature owns its own endpoints while sharing the same networking infrastructure.

This minimizes merge conflicts and keeps feature boundaries clear.

---

## Trade-offs

Advantages:

* Highly testable
* Modular
* Easy to extend
* Enterprise-friendly
* Clean separation of concerns

Disadvantages:

* Slightly more boilerplate
* More files compared to a simple NetworkManager

For medium and large applications, the maintainability benefits outweigh the additional structure.
*/
