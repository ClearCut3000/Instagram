//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

  //MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavigationBar()
  }

  //MARK: - Methods
  private func configureNavigationBar() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettingsButton))
  }

  @objc private func didTapSettingsButton() {
    let vc = SettingsViewController()
    vc.title = "Settings"
    navigationController?.pushViewController(vc, animated: true)
  }

}
