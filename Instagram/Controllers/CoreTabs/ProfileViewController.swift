//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

/// Profile view controller
final class ProfileViewController: UIViewController {

  //MARK: - Properties
  private var collectionView: UICollectionView?

  //MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavigationBar()
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.itemSize = CGSize(width: view.width/3, height: view.width/3)
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    guard let collectionView = collectionView else { return }
    view.addSubview(collectionView)
  }

  //MARK: - Layout
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView?.frame = view.bounds
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

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
  }
}
