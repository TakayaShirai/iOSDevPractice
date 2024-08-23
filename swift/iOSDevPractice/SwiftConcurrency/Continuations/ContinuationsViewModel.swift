import UIKit

class ContinuationsViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  let networkManager = ContinuationsNetworkManager()

  func getImage() async {
    guard let url = URL(string: "https://picsum.photos/200") else { return }

    do {
      let data = try await networkManager.getData2(url: url)

      guard let image = UIImage(data: data) else { return }
      await MainActor.run {
        self.image = image
      }
    } catch {
      print(error)
    }
  }

  func getHeartImage() async {
    self.image = await networkManager.getHeartImageFromDatabase()

    /// bad pattern
    //    networkManager.getHeartImageFromDatabase { [weak self] image in
    //      self?.image = image
    //    }
  }
}
