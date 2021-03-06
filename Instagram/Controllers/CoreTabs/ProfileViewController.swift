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
  private var userPosts = [UserPost]()

  //MARK: - Subview's
  private var collectionView: UICollectionView?

  //MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavigationBar()
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 1
    layout.minimumInteritemSpacing = 1
    layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    let size = (view.width-4)/3
    layout.itemSize = CGSize(width: size, height: size)
    //Cell
    collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    //Headers
    collectionView?.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
    collectionView?.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
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
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 2
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if section == 0 { return 30 }
    return 30
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let model = userPosts[indexPath.row]
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
    cell.configure(with: model)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    //get the model and open post controller
    let model = userPosts[indexPath.row]
    let vc = PostViewController(model: nil)
    vc.title = "Post"
    vc.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(vc, animated: true)

  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
    if indexPath.section == 1 {
      let tabControlHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
      tabControlHeader.delegate = self
      return tabControlHeader
    }
    let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
    profileHeader.delegate = self
    return profileHeader
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    if section == 0 {
      return CGSize(width: collectionView.width, height: collectionView.height/3)
    }
    return CGSize(width: collectionView.width, height: 65)
  }
}

//MARK: - ProfileInfoHeaderCollectionReusableViewDelegate
extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
  func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
    //scrools to the posts
    collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
  }

  func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
    //opens up list controller with user's followers
    var mockData = [UserRelationship]()
    for x in 0..<10 {
      mockData.append(UserRelationship(username: "", name: "", type: x % 2 == 0 ? .followong : .not_following))
    }
    let vc = ListViewController(data: mockData)
    vc.title = "Followers"
    vc.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(vc, animated: true)
  }

  func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
    //opens up list controller with who is the user following
    var mockData = [UserRelationship]()
    for x in 0..<10 {
      mockData.append(UserRelationship(username: "", name: "", type: x % 2 == 0 ? .followong : .not_following))
    }
    let vc = ListViewController(data: mockData)
    vc.title = "Following"
    vc.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(vc, animated: true)
  }

  func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
    //opens controller for editing profile
    let vc = EditProfileViewController()
    vc.title = "Edit Profile"
    present(UINavigationController(rootViewController: vc), animated: true)
  }
}

//MARK: - ProfileTabsCollectionReusableViewDelegate
extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
  func didTapGridButtonTab() {
    
  }

  func didTapTaggedButtonTab() {

  }


}
