import Foundation
import UIKit
import Combine

class DownloadImageAsyncImageLoader {
  let url = URL(string: "https://picsum.photos/200")!
  
  func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
    guard
      let data = data,
      let image = UIImage(data: data),
      let response = response as? HTTPURLResponse,
      response.statusCode >= 200 && response.statusCode < 300 else {
        return nil
    }
    
    return image
  }
  
  func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
    /// URLSession.shared.downloadTask(with: url) executes as soon as this function is called and the next part excecutes when the data comes back from the server.
    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      let image = self?.handleResponse(data: data, response: response)
      completionHandler(image, nil)
    }
    .resume()
  }
  
  func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
    URLSession.shared.dataTaskPublisher(for: url)
      .map(handleResponse)
      .mapError({ $0 })
      .eraseToAnyPublisher()
  }
  
  func downloadWithAsync() async throws -> UIImage? {
    do {
      let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
      return handleResponse(data: data, response: response)
    } catch {
      throw error
    }
  }
}
