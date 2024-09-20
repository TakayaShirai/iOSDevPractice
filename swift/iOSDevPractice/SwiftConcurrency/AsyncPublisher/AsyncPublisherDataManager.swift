import Foundation

class AsyncPublisherDataManager {

  @Published var myData: [String] = []

  func addData() async {
    myData.append("Apple")
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    myData.append("Banana")
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    myData.append("Orange")
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    myData.append("Watermelon")
  }

}
