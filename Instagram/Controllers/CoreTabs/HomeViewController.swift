//
//  HomeViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    handleNotAuthenticated()
  }

  private func handleNotAuthenticated() {
    if Auth.auth().currentUser == nil {
      let loginVC = LoginViewController()
      loginVC.modalPresentationStyle = .fullScreen
      present(loginVC, animated: true)
    }
  }


}

