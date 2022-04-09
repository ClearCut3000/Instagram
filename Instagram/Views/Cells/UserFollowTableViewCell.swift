//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 09.04.2022.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
  func didTapFollowUnfollowButton(model: String)
}


class UserFollowTableViewCell: UITableViewCell {

//MARK: - Properties
  static let identifier = "UserFollowTableViewCell"
  weak var delegate: UserFollowTableViewCellDelegate?

  //MARK: - Subview's
  private let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 17, weight: .semibold)
    return label
  }()

  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 16, weight: .regular)
    return label
  }()

  private let followButton: UIButton = {
    let button = UIButton()
    return button
  }()

  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.clipsToBounds = true
    contentView.addSubview(profileImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(usernameLabel)
    contentView.addSubview(followButton)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()

  }

  //MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    profileImageView.image = nil
    nameLabel.text = nil
    usernameLabel.text = nil
    followButton.setTitle(nil, for: .normal)
    followButton.layer.borderWidth = 0
    followButton.backgroundColor = nil
  }

  public func configure(with model:  String) {

  }
}
