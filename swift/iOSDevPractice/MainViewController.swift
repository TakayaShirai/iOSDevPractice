import Foundation
import SwiftData
import SwiftUI
import UIKit

class MainViewController: UIViewController {
  private enum LocalizedString {
    static let oBButtonTitle = String(localized: "Observable Object")
    static let concurrencyButtonTitle = String(localized: "Concurrency")
    static let swiftDataButtonTitle = String(localized: "SwiftData")
  }

  private lazy var oBButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.oBButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToOBView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var concurrencyButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.concurrencyButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToConcurrencyView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var swiftDataButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.swiftDataButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToSwiftDataView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubviews()
  }

  private func setUpSubviews() {
    view.addSubview(oBButton)
    view.addSubview(concurrencyButton)
    view.addSubview(swiftDataButton)

    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      oBButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      oBButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      concurrencyButton.topAnchor.constraint(equalTo: oBButton.bottomAnchor),
      concurrencyButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      swiftDataButton.topAnchor.constraint(equalTo: concurrencyButton.bottomAnchor),
      swiftDataButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
    ])
  }

  @objc func navigateToOBView() {
    let oBViewController = OBViewController()
    navigationController?.pushViewController(oBViewController, animated: true)
  }

  @objc func navigateToConcurrencyView() {
    let concurrencyViewController = ConcurrencyViewController()
    navigationController?.pushViewController(concurrencyViewController, animated: true)
  }

  @objc func navigateToSwiftDataView() {
    let swiftDataViewController = UIHostingController(
      rootView: NavigationStack {
        SwiftDataPracticeView().modelContainer(for: [Movie.self, Actor.self, Review.self])
      }
    )
    swiftDataViewController.modalPresentationStyle = .fullScreen
    self.present(swiftDataViewController, animated: true)
  }
}
