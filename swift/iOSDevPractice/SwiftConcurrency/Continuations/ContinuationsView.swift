import SwiftUI

struct ContinuationsView: View {

  private enum LayoutConstant {
    static let buttonSize: CGFloat = 200
  }

  @StateObject private var viewModel = ContinuationsViewModel()

  var body: some View {
    ZStack {
      if let image = viewModel.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.buttonSize, height: LayoutConstant.buttonSize)
      }
    }
    .task {
      //      await viewModel.getImage()
      await viewModel.getHeartImage()
    }
  }
}

#Preview {
  ContinuationsView()
}
