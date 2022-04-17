//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 03.04.2022.
//

import AVFoundation
import SDWebImage
import UIKit

/// Cell for primary post cintent
final class IGFeedPostTableViewCell: UITableViewCell {

  //MARK: - Properties
  static let identifier = "IGFeedPostTableViewCell"
  private var player: AVPlayer?
  private var playerLayer = AVPlayerLayer()

  //MARK: - Subview's
  private let postImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = nil
    imageView.clipsToBounds = true
    return imageView
  }()

  //MARK: - Init's
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.layer.addSublayer(playerLayer)
    contentView.addSubview(postImageView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer.frame = contentView.bounds
    postImageView.frame = contentView.bounds

  }

  //MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    postImageView.image = nil
  }

  public func configure(with post: UserPost) {
    switch post.postType {
    case .photo:
      postImageView.sd_setImage(with: post.postURL, completed: nil)
    case .video:
      player = AVPlayer(url: post.postURL)
      playerLayer.player = player
      playerLayer.player?.volume = 0
      playerLayer.player?.play()
    }
  }

}
