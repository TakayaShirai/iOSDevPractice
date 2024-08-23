import Foundation
import UIKit

class ContinuationsNetworkManager {
  func getData(url: URL) async throws -> Data {
    do {
      let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
      return data
    } catch {
      throw error
    }
  }

  func getData2(url: URL) async throws -> Data {
    return try await withCheckedThrowingContinuation { continuation in
      URLSession.shared.dataTask(with: url) { data, URLResponse, error in
        if let data = data {
          continuation.resume(returning: data)
        } else if let error = error {
          continuation.resume(throwing: error)
        } else {
          continuation.resume(throwing: URLError(.badURL))
        }
      }
      .resume()
    }
  }

  func getHeartImageFromDatabase(compleitonHandler: @escaping (_ image: UIImage) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      compleitonHandler(UIImage(systemName: "heart.fill")!)
    }
  }

  func getHeartImageFromDatabase() async -> UIImage {
    return await withCheckedContinuation { continuaiton in
      getHeartImageFromDatabase { image in
        continuaiton.resume(returning: image)
      }
    }
  }
}
