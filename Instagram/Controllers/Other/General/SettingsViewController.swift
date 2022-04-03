//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

struct SettingCellModel {
  let title: String
  let handler: (() -> Void)
}

///ViewController to show user settings
final class SettingsViewController: UIViewController {

  //MARK: - Properties
  private var data = [[SettingCellModel]]()

  //MARK: - Subview's
  private let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return tableView
  }()

  //MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureModels()
    view.backgroundColor = .systemBackground
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
  }

  //MARK: - Layout
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }

  //MARK: - Methods
  private func configureModels() {
    data.append([SettingCellModel(title: "Edit Profile",        handler: { [weak self] in

    }),
                 SettingCellModel(title: "Invite friends",      handler: { [weak self] in

    }),
                 SettingCellModel(title: "Save original posts", handler: { [weak self] in

    })])

    data.append([SettingCellModel(title: "Terms of Service",    handler: { [weak self] in

    }),
                 SettingCellModel(title: "Privacy Policy",      handler: { [weak self] in

    }),
                 SettingCellModel(title: "Help / Feedback",     handler: { [weak self] in

    })])

    data.append([SettingCellModel(title: "Log Out",             handler: { [weak self] in
      self?.didTapLogOut()
    })])
  }

  private func didTapLogOut() {
    let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    actionSheet.addAction(UIAlertAction(title: "log Out", style: .destructive, handler: { _ in
      AuthManager.shared.logOut { success in
        DispatchQueue.main.async {
          if success {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true) {
              self.navigationController?.popToRootViewController(animated: true)
              self.tabBarController?.selectedIndex = 0
            }
          } else {
            fatalError("Couldn't log out user")
          }
        }
      }
    }))
    actionSheet.popoverPresentationController?.sourceView = tableView
    actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
    present(actionSheet, animated: true)
  }
}

//MARK: - UITableViewDelegate & DataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = data[indexPath.section][indexPath.row].title
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    data[indexPath.section][indexPath.row].handler()
  }
}
