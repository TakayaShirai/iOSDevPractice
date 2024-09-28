import Foundation

final class StrongWeakReferencesViewModel: ObservableObject {
  @Published var data: String = "Some title!"
  let dataService = StrongSelfDataService()

  // Task<Success, Failiure>
  private var someTask: Task<Void, Never>? = nil
  private var myTasks: [Task<Void, Never>] = []

  func cancelTasks() {
    /// When we cancel the task, it's gonna remove all of the references inside of it.
    someTask?.cancel()
    someTask = nil

    myTasks.forEach({ $0.cancel() })
    myTasks = []
  }

  /// This implies a strong reference.
  func updateData() {
    Task {
      data = await dataService.getData()
    }
  }

  /// This isa strong reference.
  func updateDate2() {
    Task {
      self.data = await dataService.getData()
    }
  }

  /// This is a strong reference.
  func updateDate3() {
    Task { [self] in
      self.data = await self.dataService.getData()
    }
  }

  /// This is a weak reference.
  func updateDate4() {
    Task { [weak self] in
      guard let data = await self?.dataService.getData() else { return }
      self?.data = data
    }
  }

  /// We don't need to manage weak/strong. We can manage the Task.
  func updateDate5() {
    someTask = Task {
      self.data = await self.dataService.getData()
    }
  }

  func updateDate6() {
    let task1 = Task {
      self.data = await self.dataService.getData()
    }

    myTasks.append(task1)

    let task2 = Task {
      self.data = await self.dataService.getData()
    }

    myTasks.append(task2)
  }

  /// We purposely do not cancel tasks to keep strong references.
  func updateDate7() {
    Task {
      self.data = await self.dataService.getData()
    }

    Task.detached {
      self.data = await self.dataService.getData()
    }
  }
}
