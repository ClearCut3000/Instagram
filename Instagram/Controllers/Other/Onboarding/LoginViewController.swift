//
//  LoginViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {

  //MARK: - Properties
  struct Constants {
    static let cornerRadius: CGFloat = 8.0
  }

  //MARK: - Subview's
  private let usernameEmailField: UITextField = {
    let field = UITextField()
    field.placeholder = "Username or e-mail..."
    field.returnKeyType = .next
    field.leftViewMode = .always
    field.leftView = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: 10,
                                          height: 0))
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    field.layer.masksToBounds = true
    field.layer.cornerRadius = Constants.cornerRadius
    field.layer.borderWidth = 1.0
    field.layer.borderColor = UIColor.secondaryLabel.cgColor
    field.backgroundColor = .secondarySystemBackground
    return field
  }()

  private let passwordField: UITextField = {
    let field = UITextField()
    field.isSecureTextEntry = true
    field.placeholder = "Password..."
    field.returnKeyType = .continue
    field.leftViewMode = .always
    field.leftView = UIView(frame: CGRect(x: 0,
                                          y: 0,
                                          width: 10,
                                          height: 0))
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    field.layer.masksToBounds = true
    field.layer.cornerRadius = Constants.cornerRadius
    field.layer.borderWidth = 1.0
    field.layer.borderColor = UIColor.secondaryLabel.cgColor
    field.backgroundColor = .secondarySystemBackground
    return field
  }()

  private let loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("Log in", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.layer.masksToBounds = true
    button.layer.cornerRadius = Constants.cornerRadius
    button.backgroundColor = .systemBlue
    return button
  }()

  private let termsButton: UIButton = {
    let button = UIButton()
    button.setTitle("Terms of Service", for: .normal)
    button.setTitleColor(.secondaryLabel, for: .normal)
    return button
  }()

  private let privacyButton: UIButton = {
    let button = UIButton()
    button.setTitle("Privacy policy", for: .normal)
    button.setTitleColor(.secondaryLabel, for: .normal)
    return button
  }()

  private let createAccountButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.label, for: .normal)
    button.setTitle("Create an account", for: .normal)
    return button
  }()

  private let headerView: UIView = {
    let header = UIView()
    header.clipsToBounds = true
    let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
    header.addSubview(backgroundImageView)
    return header
  }()

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
    termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
    privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
    addSubviews()
    usernameEmailField.delegate = self
    passwordField.delegate = self
    view.backgroundColor = .systemBackground

  }

  //MARK: - Layout
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    headerView.frame             = CGRect(x: 0,
                                          y: 0.0,
                                          width: view.width,
                                          height: view.height/3.0)
    usernameEmailField.frame    = CGRect(x: 25,
                                         y: headerView.bottom + 40,
                                         width: view.width - 50,
                                         height: 52.0)
    passwordField.frame         = CGRect(x: 25,
                                         y: usernameEmailField.bottom + 10,
                                         width: view.width - 50,
                                         height: 52)
    loginButton.frame           = CGRect(x: 25,
                                         y: passwordField.bottom + 10,
                                         width: view.width - 50,
                                         height: 52)
    createAccountButton.frame   = CGRect(x: 25,
                                         y: loginButton.bottom + 10,
                                         width: view.width - 50,
                                         height: 52)
    termsButton.frame           = CGRect(x: 10,
                                         y: view.height - view.safeAreaInsets.bottom-100,
                                         width: view.width - 20,
                                         height: 50)
    privacyButton.frame         = CGRect(x: 10,
                                         y: view.height - view.safeAreaInsets.bottom-50,
                                         width: view.width - 20,
                                         height: 50)
    configureHeaderView()
  }

  //MARK: - Method's
  private func configureHeaderView() {
    guard headerView.subviews.count == 1 else { return }
    guard let backgroundView = headerView.subviews.first else { return }
    backgroundView.frame = headerView.bounds
    let textImageView = UIImageView(image: UIImage(named: "text"))
    headerView.addSubview(textImageView)
    textImageView.contentMode = .scaleAspectFit
    textImageView.frame = CGRect(x: headerView.width/4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width / 2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
  }

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
    passwordField.resignFirstResponder()
    usernameEmailField.resignFirstResponder()
    guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
          let password = passwordField.text, !password.isEmpty,
          password.count >= 8 else { return }
    var userName: String?
    var email: String?
    if usernameEmail.contains("@"), usernameEmail.contains(".") {
      email = usernameEmail
    } else {
      userName = usernameEmail
    }
    AuthManager.shared.loginUser(userName: userName, email: email, password: password) { success in
      DispatchQueue.main.async {
        if success {
          self.dismiss(animated: true, completion: nil)
        } else {
          let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in!", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
          self.present(alert, animated: true)
        }
      }
    }
  }

  @objc private func didTapTermsButton() {
    guard let url = URL(string: "https://help.instagram.com/581066165581870") else { return }
    let vc = SFSafariViewController(url: url)
    present(vc, animated: true)
  }

  @objc private func didTapPrivacyButton() {
    guard let url = URL(string: "https://help.instagram.com/519522125107875/?maybe_redirect_pol=0") else { return }
    let vc = SFSafariViewController(url: url)
    present(vc, animated: true)
  }

  @objc private func didTapCreateAccountButton() {
    let vc = RegistrationViewController()
    vc.title = "Create Account"
    present(UINavigationController(rootViewController: vc), animated: true)
  }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == usernameEmailField {
      passwordField.becomeFirstResponder()
    } else if textField == passwordField {
      didTapLoginButton()
    }
    return true
  }
}
