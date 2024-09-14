import Foundation

class MyDataManager {

  static let instance = MyDataManager()
  private init() {}

  var data: [String] = []
  private let lock = DispatchQueue(label: "com.MyApp.MyDataManager")

  func getRandomData(completionHandler: @escaping (_ title: String?) -> Void) {
    lock.async {
      self.data.append(UUID().uuidString)
      print(Thread.current)
      completionHandler(self.data.randomElement())
    }
  }
}
