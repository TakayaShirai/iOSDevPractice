import SwiftUI

struct StrongWeakReferencesView: View {

  @StateObject private var viewModel = StrongWeakReferencesViewModel()

  var body: some View {
    Text(viewModel.data)
      .onAppear {
        viewModel.updateData()
      }
      .onDisappear {
        viewModel.cancelTasks()
      }
  }
}

#Preview {
  StrongWeakReferencesView()
}
