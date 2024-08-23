import Foundation
import UIKit

class TaskGroupDataManager: ObservableObject {

  func fetchImagesWithAsyncLet() async throws -> [UIImage] {
    async let fetchImage1 = fetchImage(urlString: "https://picsum.photos/200")
    async let fetchImage2 = fetchImage(urlString: "https://picsum.photos/200")
    async let fetchImage3 = fetchImage(urlString: "https://picsum.photos/200")
    async let fetchImage4 = fetchImage(urlString: "https://picsum.photos/200")

    let (image1, image2, image3, image4) = await (
      try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4
    )

    return [image1, image2, image3, image4]
  }

  func fetchImagesWithTaskGroup() async throws -> [UIImage] {
    let urlStrings = [
      "https://picsum.photos/200",
      "https://picsum.photos/300",
      "https://picsum.photos/200",
      "https://picsum.photos/300",
      "https://picsum.photos/200",
      "https://picsum.photos/300",
    ]

    return try await withThrowingTaskGroup(of: UIImage?.self) { group in
      var images: [UIImage] = []

      images.reserveCapacity(urlStrings.count)

      for urlString in urlStrings {
        group.addTask {
          /// if one try throws an error, this entire task throws an error and stops running.
          //          try await self.fetchImage(urlString: urlString)

          try? await self.fetchImage(urlString: urlString)
        }
      }

      for try await image in group {
        if let image = image {
          images.append(image)
        }
      }

      return images
    }
  }

  private func fetchImage(urlString: String) async throws -> UIImage {
    guard let url = URL(string: urlString) else { throw URLError(.badURL) }

    do {
      let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
      if let image = UIImage(data: data) {
        return image
      } else {
        throw URLError(.badURL)
      }
    } catch {
      throw error
    }
  }

}
