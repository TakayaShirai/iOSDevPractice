import Foundation
import UIKit
import Combine

class DownloadImagesWithAsyncViewModel: ObservableObject {
  @Published var image: UIImage? = nil
  let loader = DownloadImageAsyncImageLoader()
  var cancellables = Set<AnyCancellable>()
  
  func fetchImage() async {
    //    loader.downloadWithEscaping { [weak self] image, error in
    //      DispatchQueue.main.async {
    //        self?.image = image
    //      }
    //    }
    
    //    loader.downloadWithCombine()
    //      .receive(on: DispatchQueue.main)
    //      .sink { _ in
    //
    //      } receiveValue: { [weak self] image in
    //          self?.image = image
    //      }
    //      .store(in: &cancellables)
    
    /// If downloadWithAsync() throws an error, the optional binding try? will return nil instead of propagating the error.
    let image = try? await loader.downloadWithAsync()
    /// This is used to ensure that the code inside the closure runs on the main thread. UI updates must occur on the main thread to avoid any thread-related issues.
    await MainActor.run {
      self.image = image
    }
  }
}
