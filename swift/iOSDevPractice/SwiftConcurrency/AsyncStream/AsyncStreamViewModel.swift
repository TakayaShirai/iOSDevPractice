import Foundation

@MainActor
final class AsyncStreamViewModel: ObservableObject {
  let manager = AsyncStreamDataManager()
  @Published private(set) var currentNumber: Int = 0

  func onViewAppear() {
    //    manager.getFakeData { [weak self] value in
    //      self?.currentNumber = value
    //    }

    /// The life of this Task and that of the closure of DispatchQueue.main (in getFakeData) is different.
    /// If we cancel this task, it is not gonna cancel the code inside the DispatchQueue.main
    let task = Task {
      do {
        for try await value in manager.getAsyncStream().dropFirst(2) {
          currentNumber = value
        }
      } catch {
        print(error)
      }
    }

    /// this cancel stop the above code in the Task but not gonna stop the code inside the getFakeData.
    /// so this is gonna stop updating the UI but, NEW DATA: 6, 7, 8, 9, 10 are still printed in the console.
    DispatchQueue.main.asyncAfter(
      deadline: .now() + 5,
      execute: {
        task.cancel()
        print("TASK CANCELLED")
      })
  }
}
