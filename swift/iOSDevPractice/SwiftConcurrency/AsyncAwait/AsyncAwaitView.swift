import SwiftUI

struct AsyncAwaitView: View {

  @StateObject private var viewModel = AsyncAwaitViewModel()

  var body: some View {
    List {
      ForEach(viewModel.dataArray, id: \.self) { data in
        Text(data)
      }
    }
    .onAppear {
      Task {
        await viewModel.addAuthor1()
        await viewModel.addSomething()
      }
      //      viewModel.addTitle1()
      //      viewModel.addTitle2()
    }
  }
}

#Preview {
  AsyncAwaitView()
}
