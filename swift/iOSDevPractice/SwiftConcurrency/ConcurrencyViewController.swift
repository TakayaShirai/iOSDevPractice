import Foundation
import SwiftUI
import UIKit

class ConcurrencyViewController: UIViewController {

  private enum LocalizedString {
    static let doCatchTryThrowsButtonTitle = String(localized: "DoCatchTryThrows")
    static let downloadImagesButtonTitle = String(localized: "Download Images")
    static let asyncAwaitButtonTitle = String(localized: "Async/Await")
    static let taskButtonTitle = String(localized: "Task")
    static let asyncLetButtonTitle = String(localized: "Async Let")
    static let taskGroupButtonTitle = String(localized: "TaskGroup")
    static let continuationsButtonTitle = String(localized: "Continuations")
    static let structClassActorButtonTitle = String(localized: "Struct Class Actor")
    static let actorButtonTitle = String(localized: "Actor Button")
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

  private lazy var asyncLetButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.asyncLetButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToAsyncLetView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var taskGroupButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.taskGroupButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToTaskGroupView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var continuationsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.continuationsButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToContinuationsView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var structClassActorButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.structClassActorButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToStructClassActorView), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  private lazy var actorButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(LocalizedString.actorButtonTitle, for: .normal)
    button.setTitleColor(.blue, for: .normal)
    button.addTarget(self, action: #selector(navigateToActorView), for: .touchUpInside)
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
    view.addSubview(asyncLetButton)
    view.addSubview(taskGroupButton)
    view.addSubview(continuationsButton)
    view.addSubview(structClassActorButton)
    view.addSubview(actorButton)

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

      asyncLetButton.topAnchor.constraint(equalTo: taskButton.bottomAnchor),
      asyncLetButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      taskGroupButton.topAnchor.constraint(equalTo: asyncLetButton.bottomAnchor),
      taskGroupButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      continuationsButton.topAnchor.constraint(equalTo: taskGroupButton.bottomAnchor),
      continuationsButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      structClassActorButton.topAnchor.constraint(equalTo: continuationsButton.bottomAnchor),
      structClassActorButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),

      actorButton.topAnchor.constraint(equalTo: structClassActorButton.bottomAnchor),
      actorButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
    ])
  }

  @objc func navigateToDoCatchTryThrowsView() {
    let hostingController = UIHostingController(rootView: DoCatchTryThrowsView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToDownloadImagesView() {
    let hostingController = UIHostingController(rootView: DownloadImagesWithAsyncView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToAsyncAwaitView() {
    let hostingController = UIHostingController(rootView: AsyncAwaitView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToTaskView() {
    let hostingController = UIHostingController(rootView: TaskHomeView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToAsyncLetView() {
    let hostingController = UIHostingController(rootView: AsyncLetView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToTaskGroupView() {
    let hostingController = UIHostingController(rootView: TaskGroupView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToContinuationsView() {
    let hostingController = UIHostingController(rootView: ContinuationsView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToStructClassActorView() {
    let hostingController = UIHostingController(rootView: StructClassActorView())
    navigationController?.pushViewController(hostingController, animated: true)
  }

  @objc func navigateToActorView() {
    let hostingController = UIHostingController(rootView: ActorView())
    navigationController?.pushViewController(hostingController, animated: true)
  }
}
