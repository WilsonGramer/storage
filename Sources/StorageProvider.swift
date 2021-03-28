import Foundation

/// Conform to this protocol to use your own storage provider.
///
/// - Tag: StorageProvider
public protocol StorageProvider {
    /// Retrieve the data stored for the given key.
    func get(_ key: String) -> Data?
    
    /// Set the data stored for the given key.
    func set(_ key: String, _ data: Data)
    
    /// Remove the key from storage.
    func delete(_ key: String)
}

extension UserDefaults: StorageProvider {
    public func get(_ key: String) -> Data? {
        self.data(forKey: key)
    }
    
    public func set(_ key: String, _ data: Data) {
        self.set(data, forKey: key)
    }
    
    public func delete(_ key: String) {
        self.removeObject(forKey: key)
    }
}
