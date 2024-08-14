import Foundation

class AsyncAwaitViewModel: ObservableObject {
  @Published var dataArray: [String] = []
  
  func addTitle1() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.dataArray.append("Title1: \(Thread())")
    }
  }
  
  func addTitle2() {
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
      let title = "Title2: \(Thread())"
      
      DispatchQueue.main.async {
        self.dataArray.append(title)
        
        let title3 = "Title3: \(Thread())"
        self.dataArray.append(title3)
      }
    }
  }
  
  func addAuthor1() async {
    let author1 = "Author1: \(Thread())"
    await MainActor.run {
      self.dataArray.append(author1)
    }
    
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    
    let author2 = "Author2: \(Thread())"
    await MainActor.run(body: {
      self.dataArray.append(author2)
      
      let author3 = "Author3: \(Thread())"
      self.dataArray.append(author3)
    })
    
    await addSomething()
  }
  
  func addSomething() async {
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    
    let something1 = "Something1: \(Thread())"
    await MainActor.run(body: {
      self.dataArray.append(something1)
      
      let something2 = "Something2: \(Thread())"
      self.dataArray.append(something2)
    })
  }
}
