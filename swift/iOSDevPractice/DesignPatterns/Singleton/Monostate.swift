//class CEO: CustomStringConvertible {
//  private static var _name = ""
//  private static var _age = 0
//
//  var name: String {
//    get { return type(of: self)._name}
//    set(value) { type(of: self)._name = value}
//  }
//
//  var age: Int {
//    get { return type(of: self)._age}
//    set(value) { type(of: self)._age = value}
//  }
//
//  var description: String {
//    return "\(name) is \(age) years old"
//  }
//}
//
//func main() {
//  let ceo = CEO()
//  ceo.name = "Adam Smith"
//  ceo.age = 55
//
//  let ceo2 = CEO()
//  ceo.age = 65
//
//  print(ceo) // Adam Smith is 65 years old
//  print(ceo2) // Adam Smith is 65 years old
//}
//
//main()
