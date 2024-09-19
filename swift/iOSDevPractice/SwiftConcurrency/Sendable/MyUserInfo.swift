import Foundation

/// Sendable: A type whose values can safely be passed across concurrency domains by coping.
/// If we have something that is not sendable, it means it is not safe for concurrent code.
/// structs are a Value type, so it conforms to Sendable protocol by default.
struct MyUserInfo: Sendable {
  let name: String
}
