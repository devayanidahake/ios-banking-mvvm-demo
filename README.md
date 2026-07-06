# iOS Banking App – MVVM + SwiftUI + Clean Architecture

> A production-inspired iOS banking application demonstrating modern Swift architecture, scalable networking, dependency injection, and comprehensive unit testing.

![Platform](https://img.shields.io/badge/iOS-17+-blue)
![Swift](https://img.shields.io/badge/Swift-6-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-Latest-green)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

---

## 📱 Project Overview

This repository demonstrates how to build a scalable, maintainable and testable iOS application using modern Swift.

The focus is on software architecture rather than UI complexity.

### Highlights

- Swift 6
- SwiftUI
- MVVM
- Clean Architecture
- Repository Pattern
- Protocol-Oriented Programming
- Dependency Injection
- Async/Await
- XCTest
- Enterprise PR Workflow
- Architecture Decision Records (ADR)

---

## 🏛 Architecture

```
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
```

The architecture emphasizes:

- Separation of Concerns
- Dependency Inversion
- Constructor Injection
- Testability
- Scalability

For more details see:

- Documentation/Architecture.md
- Documentation/Networking.md

---

## 🚀 Current Features

### Networking

- Endpoint-based API definition
- RequestBuilder
- URLSession abstraction
- Response validation
- JSON decoding
- Domain-specific errors

### Testing

- MockHTTPSession
- RequestBuilderTests
- ResponseValidatorTests
- URLSessionAPIClientTests
- Async XCTest helpers

### Documentation

- Architecture Guide
- Networking Guide
- Folder Structure
- Testing Guide
- Repository Interview Guide
- Architecture Decision Records (ADR)

---

## 🛠 Tech Stack

| Category | Technology |
|----------|------------|
| Language | Swift 6 |
| UI | SwiftUI |
| Architecture | MVVM |
| Networking | URLSession |
| Concurrency | Async/Await |
| Testing | XCTest |
| Dependency Injection | Constructor Injection |
| Version Control | Git + GitHub |

---

## 📂 Project Structure

```
BankingApp
│
├── App
├── Core
├── Features
├── Resources
├── Documentation
└── Tests
```

Detailed explanation:

📄 Documentation/FolderStructure.md

---

## 📚 Documentation

| Document | Description |
|----------|-------------|
| Architecture.md | Overall architecture |
| Networking.md | Networking layer |
| FolderStructure.md | Project organization |
| Testing.md | Testing strategy |
| InterviewGuide.md | Repository-specific interview questions |
| ADR | Architecture Decision Records |

---

## 🧪 Testing

Current coverage includes:

- RequestBuilder
- ResponseValidator
- URLSessionAPIClient

Testing infrastructure:

- MockHTTPSession
- TestEndpoint
- XCTestCase+Async

---

## 🛣 Roadmap

### Completed

- ✅ Project Bootstrap
- ✅ Networking Foundation
- ✅ Application Bootstrap
- ✅ Networking Tests
- ✅ Engineering Documentation
- ✅ Architecture Decision Records

### Planned

- ⏳ Composition Root
- ⏳ Repository Layer
- ⏳ Authentication
- ⏳ Dashboard Feature
- ⏳ Offline Persistence
- ⏳ CI/CD Pipeline

---

## 🎯 Repository Goals

This project demonstrates:

- Production-ready architecture
- Modern Swift best practices
- Scalable networking
- Test-driven design
- Enterprise documentation
- Professional Git workflow

---

## 🤝 Contributing

Contributions, suggestions and feedback are welcome.

Feel free to open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the MIT License.
