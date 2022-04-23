//
//  IGFeedPostHeaderTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 03.04.2022.
//

import SDWebImage
import UIKit

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
  func didTabMoreButton()
}

class IGFeedPostHeaderTableViewCell: UITableViewCell {

  //MARK: - Properties
  static let identifier = "IGFeedPostActionsTableViewCell"
  weak var delegate: IGFeedPostHeaderTableViewCellDelegate?

  //MARK: - Subview's
  private let profilePhoto: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  private let usernameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.numberOfLines = 1
    label.font = .systemFont(ofSize: 18, weight: .medium)
    return label
  }()

  private let moreButton: UIButton = {
    let button = UIButton()
    button.tintColor = .label
    button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
    return button
  }()

  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(profilePhoto)
    contentView.addSubview(usernameLabel)
    contentView.addSubview(moreButton)
    moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    let size                         = contentView.height - 4
    profilePhoto.frame               = CGRect(x: 2,
                                              y: 2,
                                              width: size,
                                              height: size)
    profilePhoto.layer.cornerRadius  = size/2
    moreButton.frame                 = CGRect(x: contentView.width-size,
                                              y: 2,
                                              width: size,
                                              height: size)
    usernameLabel.frame              = CGRect(x: profilePhoto.right+10,
                                              y: 2,
                                              width: contentView.width-(size*2)-15,
                                              height: contentView.height-3)
  }

  //MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    usernameLabel.text = nil
    profilePhoto.image = nil
  }

  public func configure(with model: User) {
    usernameLabel.text = model.username
    profilePhoto.sd_setImage(with: model.profilePhoto, completed: nil)
  }

  //MARK: - Actions
  @objc private func didTapButton() {
    delegate?.didTabMoreButton()
  }
}
