import Foundation

class DoCatchTryThrowsDataManager {
  
  private let isActive: Bool = true
  
  /// Although we need only one value, a title or an error, but this form of the function always ends up in returning two values.
  /// It's hassle to write this kind of code and make a code less readable. So, the improved version of the getTitle is getTitle2 below.
  func getTitle() -> (title: String?, error: Error?) {
    if isActive {
      return ("New Text!", nil)
    } else {
      return (nil, URLError(.badURL))
    }
  }
  
  /// You can use "Result" if you want to return either a successful state or a failure state. This helps make code more readable.
  /// We can easily identify if the function works successfully or not, but still we can make this function better actually.
  func getTitle2() -> Result<String, Error> {
    if isActive {
      return .success("New Text!")
    } else {
      return .failure(URLError(.badURL))
    }
  }
  
  /// We can just return a string or throw an error.
  func getTitle3() throws -> String {
    if isActive {
      return "New Text!"
    } else {
      throw URLError(.badURL)
    }
  }
  
  /// This function is written just for showing what will happen if getTitle3 with "try?" fails in fetchTitle.
  func getTitle4() throws -> String {
    if isActive {
      return "Final Text!"
    } else {
      throw URLError(.badURL)
    }
  }
}
