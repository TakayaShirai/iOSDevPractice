import SwiftUI

struct TaskHomeView: View {
  private enum LayoutConstant {
    static let vStackSpacing: CGFloat = 40.0
    static let imageSize: CGFloat = 200.0
  }

  @StateObject private var viewModel = TaskViewModel()
  @State private var fetchImageTask: Task<(), Never>? = nil

  var body: some View {
    ZStack {
      NavigationLink("CLICK ME!", destination: TaskView())
    }
  }

  @ViewBuilder
  private func TaskView() -> some View {
    VStack(spacing: LayoutConstant.vStackSpacing) {
      if let image = viewModel.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
      }

      if let image2 = viewModel.image2 {
        Image(uiImage: image2)
          .resizable()
          .scaledToFit()
          .frame(width: LayoutConstant.imageSize, height: LayoutConstant.imageSize)
      }
    }
    /// You can use .task instead of using onDisappear and onAppear.
    /// If the task doesn’t finish before SwiftUI removes the view or the view changes identity, SwiftUI cancels the task.
    /// Note that, in a long-task that includes multiple pieces, you might need to check for cancellation at several points,
    /// and handle cancellation differently at each point. If you only need to throw an error to stop the work,
    /// call the Task.checkCancellation() function to check for cancellation.
    /// please ref the documentation of Apple if you want to more dive in this point.
    .task {
      await viewModel.fetchImage()
    }
    /// Without this cancellation, if users tap the back button in the navigation bar while fetching an image,
    /// that image will be fetched and "Image Returned Successfully" be printed out even when users are not in the TaskView.
    /// ref: fetchImage() and fetchImage2()
    //    .onDisappear {
    //      fetchImageTask?.cancel()
    //    }
    //    .onAppear {
    /// In this case, image2 will be fetched after fetchImage() are done.
    //      fetchImageTask = Task {
    //        await viewModel.fetchImage()
    //        await viewModel.fetchImage2()
    //      }

    /// In the case below, as in the parentheces of .onAppear is a syncronous code, fetchImage() and fetchImage2() will execeute seperately at the same time without waiting fetchImage() gets done.
    /// If we have bunch of tasks that are occuring on the thread, how do we know which one to perform first? Which one has the first priority?
    //            Task {
    //              print(Thread.current)
    //              print(Task.currentPriority)
    //              await viewModel.fetchImage()
    //            }
    //
    //            Task {
    //              print(Thread.current)
    //              print(Task.currentPriority)
    //              await viewModel.fetchImage2()
    //            }

    /// The below order is the priority order from a high priority to a low priority.
    /// Note that a high priority doesn't necessarily mean that it will end first.
    //            Task(priority: .high) {
    //              try? await Task.sleep(nanoseconds: 2_000_000_000)
    //              print("high : \(Thread()) : \(Task.currentPriority)")
    //            }
    //            Task(priority: .userInitiated) {
    //              print("userInitiated : \(Thread()) : \(Task.currentPriority)")
    //            }
    //            Task(priority: .medium) {
    //              print("medium : \(Thread()) : \(Task.currentPriority)")
    //            }
    //            Task(priority: .low) {
    //              print("low : \(Thread()) : \(Task.currentPriority)")
    //            }
    //            Task(priority: .utility) {
    //              print("utility : \(Thread()) : \(Task.currentPriority)")
    //            }
    //            Task(priority: .background) {
    //              print("background : \(Thread()) : \(Task.currentPriority)")
    //            }

    //            Task (priority: .userInitiated) {
    //              print("userInitiated : \(Thread()) : \(Task.currentPriority)")
    //
    /// This is not a right way to write this kind of Task code, but just ignore it now.
    /// Child tasks inherit the parent task's priority and task-local storage,
    /// and canceling a parent task automatically cancels all of its child tasks.
    //              Task {
    //                print("userInitiated2 : \(Thread()) : \(Task.currentPriority)")
    //              }

    /// Don't use a detached task if it's possible.
    /// You need to handle considerations mentioned above manually with a detached task.
    //              Task.detached(priority: .low) {
    //                print("detached : \(Thread()) : \(Task.currentPriority)")
    //              }
    //            }
    //    }
  }
}

#Preview {
  TaskHomeView()
}
