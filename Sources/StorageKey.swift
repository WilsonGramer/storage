/// Conform to this protocol to define a storage key.
///
/// To make it easier to use your key, you can also define a property on
/// [`Storage`](x-source-tag://Storage):
///
/// ```
/// struct FooKey: StorageKey {
///     typealias Value = String
///
///     static let key = "foo"
/// }
///
/// extension Storage {
///     static var foo: String? {
///         get { Storage[FooKey.self] }
///         set { Storage[FooKey.self] = newValue }
///     }
/// }
/// ```
///
/// - Tag: StorageKey
public protocol StorageKey {
    /// The type of value this key represents in storage.
    associatedtype Value: Codable
    
    /// The raw key to use for storing values. Must be unique.
    static var key: String { get }
}
