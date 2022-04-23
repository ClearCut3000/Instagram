//
//  IGFeedPostActionsTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 03.04.2022.
//

import UIKit

protocol IGFeedPostActionsTableViewCellDelegate: AnyObject {
  func didTapLikeButton()
  func didtapCommentButton()
  func  didTapSendButton()
}

class IGFeedPostActionsTableViewCell: UITableViewCell {

  //MARK: - Properties
  static let identifier = "IGFeedPostActionsTableViewCell"
  weak var delegate: IGFeedPostActionsTableViewCellDelegate?

  //MARK: - Subview's
  private let likeButton: UIButton = {
    let button = UIButton()
    let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
    let image = UIImage(systemName: "heart", withConfiguration: config)
    button.setImage(image, for: .normal)
    button.tintColor = .label
    return button
  }()

  private let sendButton: UIButton = {
    let button = UIButton()
    let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
    let image = UIImage(systemName: "paperplane", withConfiguration: config)
    button.setImage(image, for: .normal)
    button.tintColor = .label
    return button
  }()

  private let commentButton: UIButton = {
    let button = UIButton()
    let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
    let image = UIImage(systemName: "message", withConfiguration: config)
    button.setImage(image, for: .normal)
    button.tintColor = .label
    return button
  }()

  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(likeButton)
    contentView.addSubview(commentButton)
    contentView.addSubview(sendButton)
    likeButton.addTarget(self, action: #selector(didTApLikeButton), for: .touchUpInside)
    commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
    sendButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    let buttonSize = contentView.height - 10
    let buttons = [likeButton, commentButton, sendButton]

    for x in 0..<buttons.count {
      let button = buttons[x]
      button.frame = CGRect(x: (CGFloat(x)*buttonSize) + (10 * CGFloat(x+1)), y: 5, width: buttonSize, height: buttonSize)
    }
  }

  //MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
  }

  public func configure(with post: UserPost) {

  }

  //MARK: - Actions
  @objc private func didTApLikeButton() {
    delegate?.didTapLikeButton()
  }

  @objc private func didTapCommentButton() {
    delegate?.didtapCommentButton()
  }

  @objc private func didTapSendButton() {
    didTapSendButton()
  }
}
