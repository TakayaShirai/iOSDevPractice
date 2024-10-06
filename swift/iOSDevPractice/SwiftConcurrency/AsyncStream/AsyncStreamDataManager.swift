import Foundation

class AsyncStreamDataManager {

  /// AsyncStream can publish any type of data back.
  /// asynchronously publishing integers. This stream can either yield values or throw an error upon completion.
  func getAsyncStream() -> AsyncThrowingStream<Int, Error> {
    /// continuation is the object responsible for controlling the stream's data emission.
    AsyncThrowingStream(Int.self) { [weak self] continuation in
      self?.getFakeData(
        newValue: { value in
          /// the stream emits the value using the line below.
          continuation.yield(value)
        },
        onFinish: { error in
          continuation.finish(throwing: error)
        })
    }
  }

  func getFakeData(
    newValue: @escaping (_ value: Int) -> Void,
    onFinish: @escaping (_ error: Error?) -> Void
  ) {
    let items: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    for item in items {
      DispatchQueue.main.asyncAfter(
        deadline: .now() + Double(item),
        execute: {
          newValue(item)
          print("NEW DATA: \(item)")

          if item == items.last {
            onFinish(nil)
          }
        })
    }
  }
}
