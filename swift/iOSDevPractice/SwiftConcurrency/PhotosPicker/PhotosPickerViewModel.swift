import PhotosUI
import SwiftUI

@MainActor
final class PhotosPickerViewModel: ObservableObject {
  @Published private(set) var selectedImage: UIImage? = nil
  @Published var imageSelection: PhotosPickerItem? = nil {
    didSet {
      setImage(from: imageSelection)
    }
  }

  @Published private(set) var selectedImages: [UIImage] = []
  @Published var imageSelections: [PhotosPickerItem] = [] {
    didSet {
      setImages(from: imageSelections)
    }
  }

  private func setImage(from selection: PhotosPickerItem?) {
    guard let selection else { return }

    Task {
      //      if let data = try? await selection.loadTransferable(type: Data.self) {
      //        if let uiImage = UIImage(data: data) {
      //          selectedImage = uiImage
      //          return
      //        }
      //      }

      do {
        let data = try await selection.loadTransferable(type: Data.self)

        guard let data, let uiImage = UIImage(data: data) else {
          throw URLError(.badServerResponse)
        }

        selectedImage = uiImage
      } catch {
        print(error)
      }
    }
  }

  private func setImages(from selections: [PhotosPickerItem]) {
    Task {
      var images: [UIImage] = []

      for selection in selections {
        if let data = try? await selection.loadTransferable(type: Data.self) {
          if let uiImage = UIImage(data: data) {
            images.append(uiImage)
          }
        }
      }

      selectedImages = images
    }
  }
}
