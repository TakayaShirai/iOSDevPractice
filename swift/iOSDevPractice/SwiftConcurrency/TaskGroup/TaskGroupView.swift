import SwiftUI

struct TaskGroupView: View {

  private enum LayoutConstant {
    static let imageHeight: CGFloat = 150
  }

  @StateObject private var viewModel = TaskGroupViewModel()
  @StateObject private var dataManager = TaskGroupDataManager()

  var body: some View {
    ScrollView {
      LazyVGrid(columns: viewModel.columns) {
        ForEach(viewModel.images, id: \.self) { image in
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(height: LayoutConstant.imageHeight)
        }
      }
    }
    .navigationTitle("Task Group 🙂")
    .task {
      await viewModel.getImages()
    }
  }
}

#Preview {
  TaskGroupView()
}
