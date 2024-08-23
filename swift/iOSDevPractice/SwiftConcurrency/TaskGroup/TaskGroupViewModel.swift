import Foundation
import SwiftUI

class TaskGroupViewModel: ObservableObject {
  @Published var images: [UIImage] = []
  @Published var columns = [GridItem(.flexible()), GridItem(.flexible())]

  private let manager = TaskGroupDataManager()

  func getImages() async {
    //    guard  let images = try? await manager.fetchImagesWithAsyncLet() else { return }
    guard let images = try? await manager.fetchImagesWithTaskGroup() else { return }
    self.images.append(contentsOf: images)
  }
}
