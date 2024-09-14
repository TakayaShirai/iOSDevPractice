import Foundation

actor MyActorDataManager {

  static let instance = MyActorDataManager()
  private init() {}

  var data: [String] = []
  nonisolated let myRandomText: String = "uiahirghoaorg"

  func getRandomData() -> String? {
    self.data.append(UUID().uuidString)
    print(Thread.current)
    return self.data.randomElement()
  }

  /// We don't have to await to get into the actor in order to access this function.
  nonisolated
    func getSavedData() -> String
  {
    return "NEW DATA"
  }
}
