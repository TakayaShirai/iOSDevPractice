import Foundation

/// final class: no other class is inheriting from this class.
/// @unchecked means that authors of this code ensure that this class is Sendable themselves. This is really dangerous becuase the compiler doesn't check if this is actually Sendable.
final class MyClassUserInfo: @unchecked Sendable {
  /// name is let and constant so this can be sendable when having only let objects because another reference to this class can't change the let values..
  //  let name: String

  /// But, that's not the case with variables as another reference to this class can change its value. So this is not sendable.
  /// If we send this class into an actor, while it is in the actor, there may be another thread that also has a reference to this class that is not in the actor
  /// but is changing the name while this class is in the actor. We need to avoid this situation.
  //  var name: String

  /// In this class, all of the actions are executed in this queue, so this class is Sendable now. But you do need to make sure this manually when using @unchecked.
  let queue = DispatchQueue(label: "com.MyApp.MyClassUserInfo")
  private var name: String

  init(name: String) {
    self.name = name
  }

  func updateName(name: String) {
    queue.async {
      self.name = name
    }
  }
}
