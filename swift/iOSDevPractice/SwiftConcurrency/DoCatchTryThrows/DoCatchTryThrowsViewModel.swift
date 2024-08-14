import Foundation

class DoCatchTryThrowsViewModel: ObservableObject {
  @Published var text: String = "Initial text."

  let manager = DoCatchTryThrowsDataManager()

  func fetchTitle() {
    /// for getTitle()
    /*
     let returnedValue = manager.getTitle()

     if let newTitle = returnedValue.title {
     self.text = newTitle
     } else if let error = returnedValue.error {
     self.text = error.localizedDescription
     }
     */
    /// for getTitle2()
    /*
     let result = manager.getTitle2()

     switch result {
     case .success(let newTitle):
     self.text = newTitle
     case .failure(let error):
     self.text = error.localizedDescription
     }
     */

    /// for getTitle3()
    /// If one of these fails,, the rest of the do block will not even execute and you immediately go into the catch block. (e.g. when getTitle3 fails, the text become the error message.)
    do {
      let newTitle = try manager.getTitle3()
      self.text = newTitle

      let finalTitle = try manager.getTitle4()
      self.text = finalTitle

    } catch let error {
      self.text = error.localizedDescription
    }

    /// You can also add "?" to try. and make try optional. In this case, instead of getting an error back, you'll set that value as nil.
    /// If you don't so much care about the error, you can save your time as you don't need to write do catch block.
    //    let newTitle = try? manager.getTitle3()
    //    if let newTitle = newTitle {
    //      self.text = newTitle
    //    }

    /// When you use an optional try in a do-catch block, you don't go to a catch block even though that function with an optional try throws an error.
    //    do {
    //      let newTitle = try? manager.getTitle3()
    //      if let newTitle = newTitle {
    //        self.text = newTitle
    //      }
    //
    //      let finalTitle = try manager.getTitle4()
    //      self.text = finalTitle
    //
    //    } catch let error {
    //      self.text = error.localizedDescription
    //    }
  }
}
