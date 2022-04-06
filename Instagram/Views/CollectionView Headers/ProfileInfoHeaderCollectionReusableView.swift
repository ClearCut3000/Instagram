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

  //MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBlue
    clipsToBounds = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
} 
