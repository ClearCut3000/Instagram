//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Николай Никитин on 05.04.2022.
//

import UIKit

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {

  //MARK: - Properties
  static let identifier = "ProfileInfoHeaderCollectionReusableView"

  //MARK: - Subview's
  private let profilePhotoImageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()

  private let postsButton: UIButton = {
    let button = UIButton()
    return button
  }()

  private let followingButton: UIButton = {
    let button = UIButton()
    return button
  }()

  private let followersButton: UIButton = {
    let button = UIButton()
    return button
  }()

  private let editProfileButton: UIButton = {
    let button = UIButton()
    return button
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  private let bioLabel: UILabel = {
    let label = UILabel()
    return label
  }()

  //MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviews()
    backgroundColor = .systemBlue
    clipsToBounds = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()

  }

  //MARK: - Methods
  private func addSubviews() {
    addSubview(profilePhotoImageView)
    addSubview(postsButton)
    addSubview(followingButton)
    addSubview(followersButton)
    addSubview(editProfileButton)
    addSubview(nameLabel)
    addSubview(bioLabel)
  }
} 
