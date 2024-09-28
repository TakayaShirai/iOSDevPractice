import Foundation

@MainActor
final class MVVMViewModel: ObservableObject {
  let managerClass = MyManagerClass()
  let managerActor = MyManagerActor()

  @Published private(set) var myData: String = "Starting text"
  private var tasks: [Task<Void, Never>] = []

  func cancelTask() {
    tasks.forEach({ $0.cancel() })
    tasks = []
  }

  func onCallToActionButtonPressed() {
    let task = Task {
      do {
        //        myData = try await managerClass.getData()

        /// When we come back from this await, it'll return to the actor that it was called on.
        /// So here we can assume that when we call this function on the main actorr, when it goes and gets the data it's going to be on the managerActor
        /// but when it returns the data here, it's actually coming back onto the main actor.
        myData = try await managerActor.getData()
      } catch {
        print(error)
      }
    }

    tasks.append(task)
  }
}
