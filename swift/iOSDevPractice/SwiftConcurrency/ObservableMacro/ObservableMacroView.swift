import SwiftUI

struct ObservableMacroView: View {

  @State private var viewModel = ObservableMacroViewModel()

  var body: some View {
    Text(viewModel.title)
      .task {
        await viewModel.updateTitle()

        /// The below line is for the code when you use the Task inside the updateTitle()
        // viewModel.updateTitle
      }
  }
}

#Preview {
  ObservableMacroView()
}
