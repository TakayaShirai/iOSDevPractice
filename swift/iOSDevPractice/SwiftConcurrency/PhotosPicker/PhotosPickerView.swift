import PhotosUI
import SwiftUI

struct PhotosPickerView: View {

  private enum LayoutConstant {
    static let vStackSpacing: CGFloat = 20.0
    static let singleImageWidth: CGFloat = 200.0
    static let singleImageHeight: CGFloat = 200.0
    static let singleImageCornerRadius: CGFloat = 10.0
    static let multipleImageWidth: CGFloat = 50.0
    static let multipleImageHeight: CGFloat = 50.0
    static let multipleImageCornerRadius: CGFloat = 10.0
  }

  private enum LocalizedString {
    static let photosPickerTitle = String(localized: "Open the photos picker!")
  }

  @StateObject private var viewModel = PhotosPickerViewModel()

  var body: some View {
    VStack(spacing: LayoutConstant.vStackSpacing) {
      Text("Hello, World!")

      if let image = viewModel.selectedImage {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
          .frame(width: LayoutConstant.singleImageWidth, height: LayoutConstant.singleImageHeight)
          .cornerRadius(LayoutConstant.singleImageCornerRadius)
      }

      PhotosPicker(selection: $viewModel.imageSelection, matching: .images) {
        Text(LocalizedString.photosPickerTitle)
          .foregroundStyle(.red)
      }

      if !viewModel.selectedImages.isEmpty {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(viewModel.selectedImages, id: \.self) { image in
              Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(
                  width: LayoutConstant.multipleImageWidth,
                  height: LayoutConstant.multipleImageHeight
                )
                .cornerRadius(LayoutConstant.multipleImageCornerRadius)
            }
          }
        }
      }

      PhotosPicker(selection: $viewModel.imageSelections, matching: .images) {
        Text(LocalizedString.photosPickerTitle)
          .foregroundStyle(.blue)
      }
    }
  }
}

#Preview {
  PhotosPickerView()
}
