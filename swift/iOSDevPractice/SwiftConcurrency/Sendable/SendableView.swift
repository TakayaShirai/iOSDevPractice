import SwiftUI

/// Why the Sendable Protocol
/// Heap is shared across all threads so if the different threads access the same object in the heap or the same class, you can run into data races.
/// The solution to this is make the class thread safe (or make it Actor).
/// But what if you have another object that you are gonna send into that actor?
/// What if you have an actor which is thread safe but you're sending a class that is not thread safe into the actor?
/// In this case, you might still run into problems.

struct SendableView: View {
  @StateObject private var viewModel = SendableViewModel()

  var body: some View {
    Text("Hello, World!")
      .task {

      }
  }
}

#Preview {
  SendableView()
}
