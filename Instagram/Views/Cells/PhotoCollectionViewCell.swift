//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Николай Никитин on 05.04.2022.
//

import SDWebImage
import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

  //MARK: - Properties
  static let identifier = "PhotoCollectionViewCell"

  //MARK: - Subview's
  private let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()

  //MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .secondarySystemBackground
    contentView.addSubview(photoImageView)
    contentView.clipsToBounds = true
    accessibilityLabel = "User post image"
    accessibilityHint = "Double-tap to open post"
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    photoImageView.frame = contentView.bounds
  }

  //MARK: - Methods
  override func prepareForReuse() {
    super.prepareForReuse()
    photoImageView.image = nil
  }

  public func configure(with model: UserPost) {
    let url = model.thumbnailImage
    photoImageView.sd_setImage(with: url, completed: nil)
  }

  public func configure(with imageName: String) {
    photoImageView.image = UIImage(named: imageName)
  }
}
