//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Николай Никитин on 05.04.2022.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
  func didTapGridButtonTab()
  func didTapTaggedButtonTab()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {

  //MARK: - Properties
  static let identifier = "ProfileTabsCollectionReusableView"
  public weak var delegate: ProfileTabsCollectionReusableViewDelegate?

  //MARK: - Subview's
  private let gridButton: UIButton = {
    let button = UIButton()
    button.clipsToBounds = true
    button.tintColor = .systemBlue
    button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
    return button
  }()

  private let taggedButton: UIButton = {
    let button = UIButton()
    button.clipsToBounds = true
    button.tintColor = .lightGray
    button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
    return button
  }()

  //MARK: - init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    addSubview(taggedButton)
    addSubview(gridButton)
    gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
    taggedButton.addTarget(self, action: #selector(didTapTagedButton), for: .touchUpInside)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

    //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    let size = height-16
    let gridButtonX = ((width/2)-size)/2
    taggedButton.frame = CGRect(x: gridButtonX + (width/2),
                                y: 8,
                                width: size,
                                height: size)
    gridButton.frame = CGRect(x: gridButtonX,
                              y: 8,
                              width: size,
                              height: size)
  }

  //MARK: - Methods
  @objc private func didTapGridButton() {
    delegate?.didTapGridButtonTab()
  }

  @objc private func didTapTagedButton() {
    delegate?.didTapTaggedButtonTab()
  }
}
