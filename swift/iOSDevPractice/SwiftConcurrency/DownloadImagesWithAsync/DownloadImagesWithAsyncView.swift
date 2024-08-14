import SwiftUI

struct DownloadImagesWithAsyncView: View {

  private enum LayoutConstant {
    static let imageSize: CGFloat = 250
  }

  @StateObject private var viewModel = DownloadImagesWithAsyncViewModel()

  var body: some View {
    ZStack {
      if let image = viewModel.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
      }
    }
    .onAppear {
      Task {
        await viewModel.fetchImage()
      }
    }
  }
}

#Preview {
  DownloadImagesWithAsyncView()
}
