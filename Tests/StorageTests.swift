import XCTest
@testable import Storage

class TestStorageProvider: StorageProvider {
    var store: [String: Data] = [:]
    
    func get(_ key: String) -> Data? {
        self.store[key]
    }
    
    func set(_ key: String, _ data: Data) {
        self.store[key] = data
    }
    
    func delete(_ key: String) {
        self.store[key] = nil
    }
}

struct Person: Equatable, Codable, CustomStringConvertible {
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

let alice = Person(id: 1, name: "Alice")
let bob = Person(id: 2, name: "Bob")

class StorageTests: XCTestCase {
    override func setUp() {
        Storage.provider = TestStorageProvider()
    }
    
    func testUnsetKey() {
        XCTAssertNil(Storage[PeopleKey.self])
    }
    
    func testSetKey() {
        Storage.people = [alice]
        XCTAssertEqual(Storage.people, [alice])
    }
    
    func testUpdateUnsetKey() {
        Storage.people.append(bob)
        XCTAssertEqual(Storage.people, [bob])
    }
    
    func testUpdateSetKey() {
        Storage.people = [alice]
        Storage.people.append(bob)
        XCTAssertEqual(Storage.people, [alice, bob])
    }
}
