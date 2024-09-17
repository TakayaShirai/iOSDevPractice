import SwiftUI

struct GlobalActorView: View {
  @StateObject private var viewModel = GlobalActorViewModel()

  var body: some View {
    ScrollView {
      VStack {
        ForEach(viewModel.dataArray, id: \.self) {
          Text($0)
            .font(.headline)
        }
      }
    }
    .task {
      await viewModel.getData()
    }
    /// Error Message: Call to global actor 'MyFirstGlobalActor'-isolated instance method 'getData()' in a synchronous main actor-isolated context
    /// We can't use getData() without an await keyword because it isolates to the MyFirstGlobalActor.
    //      .onAppear {
    //        viewModel.getData()
    //      }
  }
}

#Preview {
  GlobalActorView()
}
