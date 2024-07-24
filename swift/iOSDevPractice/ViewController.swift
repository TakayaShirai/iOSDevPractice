import UIKit
import SwiftUI

class ViewController: UIViewController {
  
  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: ContentView())
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    controller.view.invalidateIntrinsicContentSize()
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubview()
  }

  func setUpSubview() {
    view.addSubview(hostingController.view)
    
    view.backgroundColor = .systemBackground
    
    let layoutGuide = view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
    ])
    
    navigationItem.title = "Hello"
  }
}

struct ContentView: View {
  var body: some View {
    VStack {
      Spacer()
      Text("Hello, World!")
      Spacer()
    }
  }
}

#Preview {
  ContentView()
}
