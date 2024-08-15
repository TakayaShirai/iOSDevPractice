import SwiftUI

struct AsyncLetView: View {

  @StateObject private var viewModel = AsyncLetViewModel()
  private let url = URL(string: "https://picsum.photos/200")!

  var body: some View {
    ScrollView {
      LazyVGrid(columns: viewModel.columns) {
        ForEach(viewModel.images, id: \.self) { image in
          Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(height: 150)
        }
      }
    }
    .navigationTitle("Async Let 🙂")
    .onAppear {
      /// The four images below will be fetched from the url one after another.
      /// How do we fetch them at the exactly same time?
      //      Task {
      //        do {
      //          let image1 = try await viewModel.fetchImage(from: url)
      //          viewModel.images.append(image1)
      //
      //          let image2 = try await viewModel.fetchImage(from: url)
      //          viewModel.images.append(image2)
      //
      //          let image3 = try await viewModel.fetchImage(from: url)
      //          viewModel.images.append(image3)
      //
      //          let image4 = try await viewModel.fetchImage(from: url)
      //          viewModel.images.append(image4)
      //
      //        } catch {
      //          throw error
      //        }
      //      }

      /// We can just do that by seperating like this but this doesn't seem really well.
      /// Considering their cancellation or priorities, there are many extra work in this code.
      //      Task {
      //        do {
      //          let image1 = try await viewModel.fetchImage(from: url)
      //          viewModel.images.append(image1)
      //        } catch {
      //          throw error
      //        }
      //      }
      //      Task {
      //        do {
      //          let image2 = try await viewModel.fetchImage(from: url)
      //          viewModel.images.append(image2)
      //        } catch {
      //          throw error
      //        }
      //      }
      //      Task {
      //        do {
      //          let image3 = try await viewModel.fetchImage(from: url)
      //          viewModel.images.append(image3)
      //        } catch {
      //          throw error
      //        }
      //      }
      //      Task {
      //        do {
      //          let image4 = try await viewModel.fetchImage(from: url)
      //          viewModel.images.append(image4)
      //        } catch {
      //          throw error
      //        }
      //      }

      /// You can write a code like a below one when you want to do the all tasks at the same time
      /// by using async let. When the first one happens really quickly but the last one takes five seconds,
      /// we're gonna wait that whole five seconds.
      /// One of them fails, they're all going to throw an error. If you are okey with one of them failing,
      /// just mark that try as optional try?.
      /// Plus, functions don't have to be the same function.
      Task {
        do {
          async let fetchImage1 = viewModel.fetchImage(from: url)
          async let fetchImage2 = viewModel.fetchImage(from: url)
          async let fetchImage3 = viewModel.fetchImage(from: url)
          async let fetchImage4 = viewModel.fetchImage(from: url)
          //          async let fetchTitle = viewModel.fetchTitle()
          //
          //          let (image, title) = await (try fetchImage1, fetchTitle)
          let (image1, image2, image3, image4) = await (
            try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4
          )
          viewModel.images.append(contentsOf: [image1, image2, image3, image4])
        } catch {
          throw error
        }
      }
    }
  }
}

#Preview {
  AsyncLetView()
}
