import Foundation
import SwiftUI
import UIKit

class ConcurrencyViewController: UIViewController {

  private enum LocalizedString {
    static let doCatchTryThrowsButtonTitle = String(localized: "DoCatchTryThrows")
    static let downloadImagesButtonTitle = String(localized: "Download Images")
    static let asyncAwaitButtonTitle = String(localized: "Async/Await")
    static let taskButtonTitle = String(localized: "Task")
  }

  private lazy var doCatchTryThrowsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.doCatchTryThrowsButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToDoCatchTryThrowsView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var downloadImageButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.downloadImagesButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToDownloadImagesView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var asyncAwaitButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.asyncAwaitButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToAsyncAwaitView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var taskButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.taskButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToTaskView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubViews()
  }

  private func setUpSubViews() {
    view.addSubview(doCatchTryThrowsButton)
    view.addSubview(downloadImageButton)
    view.addSubview(asyncAwaitButton)
    view.addSubview(taskButton)

    view.backgroundColor = .systemBackground

    let layoutGuide = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      doCatchTryThrowsButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      doCatchTryThrowsButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      downloadImageButton.topAnchor.constraint(equalTo: doCatchTryThrowsButton.bottomAnchor),
      downloadImageButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      asyncAwaitButton.topAnchor.constraint(equalTo: downloadImageButton.bottomAnchor),
      asyncAwaitButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      taskButton.topAnchor.constraint(equalTo: asyncAwaitButton.bottomAnchor),
      taskButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
    ])
  }

  @objc func navigateToDoCatchTryThrowsView() {
    let doCatchTryThrowsViewController = UIHostingController(rootView: DoCatchTryThrowsView())
    navigationController?.pushViewController(doCatchTryThrowsViewController, animated: true)
  }

  @objc func navigateToDownloadImagesView() {
    let downloadImagesWithAsyncView = UIHostingController(rootView: DownloadImagesWithAsyncView())
    navigationController?.pushViewController(downloadImagesWithAsyncView, animated: true)
  }

  @objc func navigateToAsyncAwaitView() {
    let asyncAwaitView = UIHostingController(rootView: AsyncAwaitView())
    navigationController?.pushViewController(asyncAwaitView, animated: true)
  }

  @objc func navigateToTaskView() {
    let taskHomeView = UIHostingController(rootView: TaskHomeView())
    navigationController?.pushViewController(taskHomeView, animated: true)
  }
}
