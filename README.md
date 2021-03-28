# Storage

[![Tests](https://github.com/WilsonGramer/storage/actions/workflows/test.yml/badge.svg)](https://github.com/WilsonGramer/storage/actions/workflows/test.yml)

Simple and type-safe global storage management.

This example shows how to store a list of `Person` values:

```swift
struct Person: Codable, CustomStringConvertible {
    let id: Int
    let name: String
    
    var description: String {
        self.name
    }
}

struct PeopleKey: StorageKey {
    typealias Value = [Person]
    
    static let key = "people"
}

extension Storage {
    static var people: [Person] {
        get { Storage[PeopleKey.self] ?? [] }
        set { Storage[PeopleKey.self] = newValue }
    }
}

print(Storage.people) // [Alice]

let bob = Person(id: 2, name: "Bob")
Storage.people.append(bob)

print(Storage.people) // [Alice, Bob]
```

## Custom storage providers

By default, Storage uses User Defaults. You can change this by setting `Storage.provider` to a value conforming to `StorageProvider`.

## Installation

Add Storage as a dependency in your `Package.swift`:

```swift
.package(url: "https://github.com/WilsonGramer/storage", .branch("master"))
```
