//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

final class EditProfileViewController: UIViewController {

  //MARK: - Properties
  private var models = [[EditProfileFormModel]]()

  //MARK: - Subview's
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
    return tableView
  }()

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureModels()
    tableView.dataSource = self
    tableView.tableHeaderView = createTableHeaderView()
    view.addSubview(tableView)
    view.backgroundColor = .systemBackground
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
  }

  //MARK: - Layout
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }

  //MARK: - Methods
  private func  configureModels() {
    let sectionOneLabels = ["Name", "Username", "Bio"]
    var sectionOne = [EditProfileFormModel]()
    for label in sectionOneLabels {
      let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
      sectionOne.append(model)
    }
    models.append(sectionOne)

    let sectionTwoLabels = ["Email", "Phone", "Gender"]
    var sectionTwo = [EditProfileFormModel]()
    for label in sectionTwoLabels {
      let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
      sectionTwo.append(model)
    }
    models.append(sectionTwo)
  }

  private func createTableHeaderView() -> UIView {
    let header = UIView(frame: CGRect(x: 0,
                                      y: 0,
                                      width: view.width,
                                      height: view.height/4).integral)
    let size = header.height/1.5
    let profilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/2,
                                                    y: (header.height-size)/2,
                                                    width: size,
                                                    height: size))
    header.addSubview(profilePhotoButton)
    profilePhotoButton.layer.masksToBounds = true
    profilePhotoButton.layer.cornerRadius = size/2.0
    profilePhotoButton.tintColor = .label
    profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
    profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
    profilePhotoButton.layer.borderWidth = 1
    profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
    return header
  }

  //MARK: - Action's
  @objc private func didTapProfilePhotoButton() {

  }

  @objc private func didTapSave() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func didTapCancel() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func didTapChangeProfilePicture() {
    let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
    actionSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { _ in

    }))
    actionSheet.addAction(UIAlertAction(title: "Choose from photolibrary", style: .default, handler: { _ in

    }))
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    actionSheet.popoverPresentationController?.sourceView = view
    actionSheet.popoverPresentationController?.sourceRect = view.bounds
    present(actionSheet, animated: true)
  }
}

//MARK: - UITableViewDataSource
extension EditProfileViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return models.count
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard section == 1 else { return nil }
    return "Private information"
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models[section].count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.section][indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
    cell.configure(with: model)
    cell.delegate = self
    cell.textLabel?.text = model.label
    return cell
  }
}

//MARK: - FormTableViewCellDelegate
extension EditProfileViewController: FormTableViewCellDelegate {
  func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
    print(updatedModel.value ?? "nil")
  }
}

