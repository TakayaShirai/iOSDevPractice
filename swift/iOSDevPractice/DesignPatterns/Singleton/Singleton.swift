/// For some components it only makes sense to have one in the system e.g., Database repository, Object Factory
/// Also, in those cases, the initializer call is expensive -> we wanna do it once, provide everyone with the same instance.
/// and wanna prevent anyone creating additional copies.
/// Singleton: A component which is instantiated only once.
//
//import Foundation
//import XCTest
//
//protocol Database {
//  func getPopulation(_ name: String) -> Int
//}
//
//class SingletonDatabase: Database {
//  var capitals = [String : Int]()
//  static var instanceCount = 0
//
//  // singleton
//  static var instance = SingletonDatabase()
//
//  private init() {
//    type(of: self).instanceCount += 1
//    print("initializing database")
//
//    let path = "/Users/taka/Desktop/iOSDevPractice/swift/iOSDevPractice/DesignPatterns/Singleton/capitals.txt"
//
//    if let text = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) {
//      let strings = text.components(separatedBy: .newlines)
//                       .filter{ !$0.isEmpty }
//                       .map{ $0.trimmingCharacters(in: .whitespaces ) }
//
//      for i in 0..<(strings.count/2) {
//        capitals[strings[i*2]] = Int(strings[i*2+1])!
//      }
//    }
//  }
//
//  func getPopulation(name: String) -> Int {
//    return capitals[name]!
//  }
//}
//
//class SingletonRecordFinder {
//  func totalPopulation(_ names: [String]) -> Int {
//    var result = 0
//    for name in names {
//      result += SingletonDatabase.instance.getPopulation(name: name)
//    }
//
//    return result
//  }
//}
//
//class DummyDatabase: Database {
//  func getPopulation(_ name: String) -> Int {
//    return ["alpha" : 1, "beta" : 2, "gamma" : 3][name]!
//  }
//}
//
//class ConfigurableRecordFinder {
//  let database: Database
//
//  init(database: Database) {
//    self.data.base = database
//  }
//
//  func totalPopulation(_ names: [String]) -> Int {
//    var result = 0
//    for name in names {
//      result += SingletonDatabase.instance.getPopulation(name: name)
//    }
//
//    return result
//  }
//}
//
//func main_old() {
//  let db = SingletonDatabase.instance
//  var city = "Tokyo"
//  print("\(city) has population \(db.getPopulation(name: city))")
//
//  let db2 = SingletonDatabase.instance
//  city = "Manila"
//  print("\(city) has population \(db2.getPopulation(name: city))")
//  print(SingletonDatabase.instanceCount)
//}
//
//class SingletonTests: XCTestCase {
//  static var allTests = [
//    ("test_singletonPopulationTest", test_singletonPopulationTest)
//  ]
//
//  /// This is dependent on the real database and there is a possibility that this cannot pass the test as the database is changed even though it should pass the test.
//  func test_singletonPopulationTest() {
//    let rf = SingletonRecordFinder()
//    let names = ["Seoul", "Mexico City"]
//    let tp = rf.totalPopulation(names)
//    XCTAssertEqual(17_500_000+17_400_000, tp, "population size must match")
//  }
//
//  /// This is not dependent on the real database.
//  func test_dependantTotalPopulationTest() {
//    let db = DummyDatabase()
//    let names = ["alpha", "gamma"]
//    let rf = ConfigurableRecordFinder(database: db)
//    XCTAssertEqual(4, rf.totalPopulation(names), "population size must match")
//  }
//}
//
//func main() {
//  XCTMain([testCase(SingletonTests.allTests)])
//}
//
//main()
