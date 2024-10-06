import Foundation

//@MainActor
//final class ObservableMacroViewModel: ObservableObject {
//
//  let database = TitleDatabase()
//  @Published var title: String = "Starting title"
//
//  func updateTitle() async {
//    title = await database.getNewTitle()
//  }
//}

/// With this @Observable macro, the purple error (thread error) does not appear even when the UI is not updated on the main thread.
/// We can solve this problem by adding @MainActor to properties, and adding it methods as well or expicitly wrintng MainActor.run.
@Observable class ObservableMacroViewModel {

  @ObservationIgnored let database = TitleDatabase()
  @MainActor var title: String = "Starting title"

  //    @MainActor
  func updateTitle() async {
    let title = await database.getNewTitle()

    await MainActor.run {
      self.title = title
    }

    //      Task { @MainActor in
    //        title = await database.getNewTitle()
    //      }
  }
}
