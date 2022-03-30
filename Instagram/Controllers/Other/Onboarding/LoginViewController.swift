//
//  LoginViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

class LoginViewController: UIViewController {

  //MARK: - Subview's
  private let usernameEmailField: UITextField = {
    let field = UITextField()
    return field
  }()

  private let passwordField: UITextField = {
    let field = UITextField()
    field.isSecureTextEntry = true
    return field
  }()

  private let loginButton: UIButton = {
    let button = UIButton()
    return button
  }()

  private let termsButton: UIButton = {
    let button = UIButton()
    return button
  }()

  private let privacyButton: UIButton = {
    let button = UIButton()
    return button
  }()

  private let createAccountButton: UIButton = {
    let button = UIButton()
    return button
  }()

  private let headerView: UIView = {
    let header = UIView()
    return header
  }()

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    view.backgroundColor = .systemBackground
  }

  //MARK: - Layout
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

  }

  //MARK: - Method's
  private func addSubviews() {
    view.addSubview(usernameEmailField)
    view.addSubview(passwordField)
    view.addSubview(loginButton)
    view.addSubview(termsButton)
    view.addSubview(privacyButton)
    view.addSubview(headerView)
    view.addSubview(createAccountButton)
  }

  @objc private func didTapLoginButton() {

  }

  @objc private func didTapTermsButton() {

  }

  @objc private func didTapPrivacyButton() {

  }

  @objc private func didTapCreateAccountButton() {

  }
}
