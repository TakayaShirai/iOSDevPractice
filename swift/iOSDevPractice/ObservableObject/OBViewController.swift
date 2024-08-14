import Combine
import SwiftUI
import UIKit

class OBViewController: UIViewController {

  private var viewObserver = OBViewObserver()
  private var cancellables: Set<AnyCancellable> = []

  private lazy var hostingController: UIHostingController = {
    let controller = UIHostingController(rootView: ParentView(viewObserver: viewObserver))
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(controller)
    controller.didMove(toParent: self)
    return controller
  }()

  private lazy var incrementButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("UIKit Increment", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(increment), for: .touchUpInside)
    return button
  }()

  private lazy var countText: UILabel = {
    var text = UILabel()
    text.translatesAutoresizingMaskIntoConstraints = false
    text.textColor = .black
    text.text = "Undefined"
    return text
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
    countTextUpdate()
  }

  private func setUpSubviews() {
    view.addSubview(incrementButton)
    view.addSubview(countText)
    view.addSubview(hostingController.view)

    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      incrementButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 20),
      incrementButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      countText.topAnchor.constraint(equalTo: incrementButton.bottomAnchor),
      countText.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      hostingController.view.topAnchor.constraint(equalTo: countText.bottomAnchor, constant: 100),
      hostingController.view.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),

    ])
  }

  @objc
  private func increment() {
    viewObserver.count += 1
  }

  private func countTextUpdate() {
    viewObserver.$count
      .sink { self.countText.text = String("UIKit count: \($0)") }
      .store(in: &cancellables)
  }
}

struct ParentView: View {

  @ObservedObject var viewObserver: OBViewObserver

  var body: some View {
    VStack {
      Divider()

      Text("Parent Count: \(viewObserver.count)")

      Button(
        action: {
          viewObserver.count += 1
        },
        label: {
          Text("Parent Increment")
        }
      )
      .padding()

      Button(
        action: {
          viewObserver.count = 0
        },
        label: {
          Text("Count Reset")
        })

      Divider()

      ChildAView(viewObserver: viewObserver)

      Divider()

      ChildBView(viewObserver: viewObserver)

      Divider()
    }
  }
}

struct ChildAView: View {

  @ObservedObject var viewObserver: OBViewObserver

  var body: some View {
    VStack {
      Text("ChildA Count: \(viewObserver.count)")

      Button(
        action: {
          viewObserver.count += 1
        },
        label: {
          Text("ChildA Increment")
        }
      )
      .padding()
    }
  }
}

struct ChildBView: View {

  @ObservedObject var viewObserver: OBViewObserver

  var body: some View {
    VStack {
      Text("ChildB Count: \(viewObserver.count)")

      Button(
        action: {
          viewObserver.count += 1
        },
        label: {
          Text("ChildB Increment")
        }
      )
      .padding()
    }
  }
}

#Preview {
  ParentView(viewObserver: OBViewObserver())
}
