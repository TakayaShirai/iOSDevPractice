import Foundation

class GlobalActorViewModel: ObservableObject {
  @MainActor @Published var dataArray: [String] = []
  let manager = MyFirstGlobalActor.shared

  /// As this getData() function is executed in the .task in GlobalActorView, this is gonna be run on the main actor, or the main thread.
  /// But, we don't want the main thread to be cloggerd down with really heavy complex tasks.
  /// You can define globalActor to avoid this situation and run the heavy tasks on the global actor and change UI on the main actor
  /// even though func getData() is not in the actor. ( Make func getData() isolates to @MyFirstGlobalActor)
  @MyFirstGlobalActor func getData() {
    // HEAVY COMPLEX METHODS

    Task {
      let data = await manager.getDataFromDatabase()
      /// We need to update UI on the Main thread but this doesn't show the error about that (When you run the code, purple errors are shown though).
      /// And probably this causes an actual thread error. You can avoid this by adding @Mainactor to dataArray.
      // self.dataArray = data

      await MainActor.run {
        self.dataArray = data
      }
    }
  }
}
