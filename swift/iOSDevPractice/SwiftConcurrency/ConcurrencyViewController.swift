import Foundation
import UIKit
import SwiftUI

class ConcurrencyViewController: UIViewController {
  
  private enum LocalizedString {
    static let doCatchTryThrowsButtonTitle = String(localized: "DoCatchTryThrows")
    static let downloadImagesButtonTitle = String(localized: "Download Images")
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpSubViews()
  }
  
  private func setUpSubViews() {
    view.addSubview(doCatchTryThrowsButton)
    view.addSubview(downloadImageButton)
    
    view.backgroundColor = .systemBackground
    
    let layoutGuide = view.safeAreaLayoutGuide
    
    NSLayoutConstraint.activate([
      doCatchTryThrowsButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
      doCatchTryThrowsButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
      
      downloadImageButton.topAnchor.constraint(equalTo: doCatchTryThrowsButton.bottomAnchor),
      downloadImageButton.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor)
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
}
