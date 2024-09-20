import Combine
import SwiftUI

class AsyncPublisherViewModel: ObservableObject {

  @MainActor @Published var dataArray: [String] = []

  let manager = AsyncPublisherDataManager()
  var cancellables = Set<AnyCancellable>()

  init() {
    addSubscribers()
  }

  private func addSubscribers() {
    Task {
      await MainActor.run {
        self.dataArray = ["ONE"]
      }
      /// This addSubscribers() method starts the asynchronous task that listens for values from the manager.$myData publisher
      /// when the @StateObject property wrapper initializes the viewModel in the AsyncPublisherView.
      /// This for-loop is basically going to be waiting for values forever.
      /// Because it never knows when the publisher myData is going to stop. It's always going to be listening for that next value.
      /// So unless we are actually ending this loop and breaking out of it, it's never going to stop.
      /// You have the code down here, it's never going to be executed.
      for await value in manager.$myData.values {
        /// values: The elements produced by the publisher, as an asynchronous sequence.
        await MainActor.run {
          self.dataArray = value
        }
      }

      await MainActor.run {
        self.dataArray = ["TWO"]
      }
    }
    //    manager.$myData
    //      .receive(on: DispatchQueue.main, options: nil)
    //      .sink { dataArray in
    //        self.dataArray = dataArray
    //      }
    //      .store(in: &cancellables)
  }

  func start() async {
    await manager.addData()
  }
}

#Preview {
  AsyncPublisherView()
}
