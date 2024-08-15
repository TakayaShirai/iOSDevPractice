import Foundation
import SwiftUI
import UIKit

class AsyncLetViewModel: ObservableObject {
  @Published var images: [UIImage] = []
  @Published var columns = [GridItem(.flexible()), GridItem(.flexible())]

  func appendImage() {
    images.append(UIImage(systemName: "heart.fill")!)
  }

  func fetchImage(from url: URL) async throws -> UIImage {
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

  func fetchTitle() async -> String {
    return "NEW TITLE"
  }
}
