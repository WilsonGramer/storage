import Foundation

/// Simple and type-safe global storage management.
///
/// This example shows how to store a list of `Person` values:
///
/// ```
/// struct Person: Codable, CustomStringConvertible {
///     let id: Int
///     let name: String
///
///     var description: String {
///         self.name
///     }
/// }
///
/// struct PeopleKey: StorageKey {
///     typealias Value = [Person]
///
///     static let key = "people"
/// }
///
/// extension Storage {
///     static var people: [Person] {
///         get { Storage[PeopleKey.self] ?? [] }
///         set { Storage[PeopleKey.self] = newValue }
///     }
/// }
///
/// print(Storage.people) // [Alice]
///
/// let bob = Person(id: 2, name: "Bob")
/// Storage.people.append(bob)
///
/// print(Storage.people) // [Alice, Bob]
/// ```
///
/// - Tag: Storage
public enum Storage {
    /// Override this value to change the [storage provider](x-source-tag://StorageProvider).
    /// By default, `UserDefaults.standard` is used.
    public static var provider: StorageProvider = UserDefaults.standard
    
    /// Retrieve or update a value in storage. Setting `nil` will remove the key
    /// from storage.
    ///
    /// - Parameter key: The [storage key](x-source-tag://StorageKey) to use.
    ///
    /// - Returns: The value in storage for the provided key, or `nil` if the
    ///   key is not present or the value could not be decoded.
    ///
    /// - Important: This function will crash if the provided value cannot be
    ///   encoded.
    public static subscript<Key: StorageKey>(key: Key.Type) -> Key.Value? {
        get {
            guard
                let data = self.provider.get(Key.key),
                let value = try? JSONDecoder().decode(Key.Value.self, from: data)
            else {
                return nil
            }
            
            return value
        }
        
        set {
            if let newValue = newValue {
                let data = try! JSONEncoder().encode(newValue)
                self.provider.set(Key.key, data)
            } else {
                self.provider.delete(Key.key)
            }
        }
    }
}
