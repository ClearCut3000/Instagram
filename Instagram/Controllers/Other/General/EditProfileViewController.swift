//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

class EditProfileViewController: UIViewController {

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(didTapCancel))
  }

  //MARK: - Methods
  @objc private func didTapSave() {
    
  }

  @objc private func didTapCancel() {

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
