/// Prototype: A partially or fully initialized object that you copy (clone) and make use of.

protocol Copying {
  init(copyFrom other: Self)
}

class AddressClass: CustomStringConvertible, Copying {
  /// This creates a new instance of AddressClass by copying the properties (streetAddress and city) from another AddressClass instance.
  required init(copyFrom other: AddressClass) {
    self.streetAddress = other.streetAddress
    self.city = other.city
  }

  var streetAddress: String
  var city: String

  init(streetAddress: String, city: String) {
    self.streetAddress = streetAddress
    self.city = city
  }

  var description: String {
    return "\(streetAddress), \(city)"
  }

  func clone() -> AddressClass {
    return cloneImplementation()
  }

  /// just writing return AddressClass(streetAddress: streetAddress, city: city) inside the clone method returns an error.
  /// This is why this method is needed.
  private func cloneImplementation<T>() -> T {
    return AddressClass(streetAddress: streetAddress, city: city) as! T
  }
}

class EmployeeClass: CustomStringConvertible, Copying {
  required init(copyFrom other: EmployeeClass) {
    self.name = other.name

    // Option 1
    //    address = AddressClass(streetAddress: other.address.streetAddress, city: other.address.city)

    // Option 2
    self.address = AddressClass(copyFrom: other.address)
  }

  var name: String
  var address: AddressClass

  init(name: String, address: AddressClass) {
    self.name = name
    self.address = address
  }

  var description: String {
    return "My name is \(name), and I live at \(address)"
  }

  func clone() -> EmployeeClass {
    return cloneImplementation()
  }

  private func cloneImplementation<T>() -> T {
    return EmployeeClass(name: name, address: address.clone()) as! T
  }
}

struct AddressStruct: CustomStringConvertible {
  var streetAddress: String
  var city: String

  init(streetAddress: String, city: String) {
    self.streetAddress = streetAddress
    self.city = city
  }

  func clone() -> AddressStruct {
    return AddressStruct(streetAddress: streetAddress, city: city)
  }

  var description: String {
    return "\(streetAddress), \(city)"
  }
}

struct EmployeeStruct: CustomStringConvertible {
  var name: String
  var address: AddressStruct

  init(name: String, address: AddressStruct) {
    self.name = name
    self.address = address
  }

  func clone() -> EmployeeStruct {
    return EmployeeStruct(name: name, address: address.clone())
  }

  var description: String {
    return "My name is \(name), and I live at \(address)"
  }
}

func main() {
  let john = EmployeeClass(
    name: "John", address: AddressClass(streetAddress: "123 LondonRoad", city: "London"))

  /// this is gonna be trouble as Class is the reference type.
  let chris = john
  chris.name = "Chris"

  print(john)  // My name is Chris, and I live at 123 LondonRoad, London
  print(chris)  // My name is Chris, and I live at 123 LondonRoad, London

  /// By using the Copying Protocol, we can copy the object of Class properly.
  let dan = EmployeeClass(copyFrom: john)
  dan.name = "Dan"
  dan.address.streetAddress = "124 LondonRoad"

  print(john)  // My name is Chris, and I live at 123 LondonRoad, London
  print(dan)  // My name is Dan, and I live at 124 LondonRoad, London

  /// Using the clone method.
  let taro = john.clone()
  taro.name = "Taro"
  taro.address.city = "Tokyo"

  print(john)  // My name is Chris, and I live at 123 LondonRoad, London
  print(taro)  // My name is Taro, and I live at 123 LondonRoad, Tokyo

  /// This is fine as Struct is the value type.
  let alice = EmployeeStruct(
    name: "Alice", address: AddressStruct(streetAddress: "8888 University Drive", city: "Burnaby"))
  var bob = alice
  bob.name = "bob"
  bob.address.streetAddress = "8889 University Drive"

  print(alice)  // My name is Alice, and I live at 8888 University Drive, Burnaby
  print(bob)  // My name is bob, and I live at 8889 University Drive, Burnaby

}

//main()
