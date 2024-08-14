import UIKit

class TaskViewModel: ObservableObject {

  @Published var image: UIImage? = nil
  @Published var image2: UIImage? = nil

  func fetchImage() async {
    try? await Task.sleep(nanoseconds: 2_000_000_000)

    /// Chances are that for-loop could be still running after the task is cancelled, and would cause a problem in an applicaiton.
    /// A solution to this problem is to check for cancellation ocassionally in a code. (Task.checkCancellation())
    //    for x in array {
    //      // long task
    //      try Task.checkCancellation()
    //    }

    do {
      guard let url = URL(string: "https://picsum.photos/200") else { return }
      let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)

      await MainActor.run {
        let image = UIImage(data: data)
        self.image = image
        print("Image Returned Successfully")
      }
    } catch {
      print(error.localizedDescription)
    }
  }

  func fetchImage2() async {
    do {
      guard let url = URL(string: "https://picsum.photos/1000") else { return }
      let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)

      await MainActor.run {
        let image = UIImage(data: data)
        self.image2 = image
        print("Image Returned Successfully")
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}
