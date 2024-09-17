import Foundation

@globalActor
struct MyFirstGlobalActor {
  static var shared = MyNewDataManager()
}
