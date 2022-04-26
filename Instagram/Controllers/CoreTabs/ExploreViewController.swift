//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Николай Никитин on 28.03.2022.
//

import UIKit

class ExploreViewController: UIViewController {

  //MARK: - Properties
  let models = [UserPost]()

  //MARK: - Subview's
  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Search"
    searchBar.backgroundColor = .secondarySystemBackground
    return searchBar
  }()

  private var collectionView: UICollectionView?

  //MARK: - Layout
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView?.frame = view.bounds
  }

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.topItem?.titleView = searchBar
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.itemSize = CGSize(width: (view.width - 4)/3, height: (view.width - 4)/3)
    layout.minimumLineSpacing = 1
    layout.minimumInteritemSpacing = 1
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    collectionView?.delegate = self
    collectionView?.dataSource = self
    guard let collectionView = collectionView else { return }
    view.addSubview(collectionView)
    searchBar.delegate = self
  }
}

//MARK: - UISearchBarDelegate
extension ExploreViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    didCancelSearch()
    guard let text = searchBar.text, !text.isEmpty else { return }
    query(text)
  }

  private func query(_ text: String) {

  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSearch))
  }

  @objc private func didCancelSearch() {
    searchBar.resignFirstResponder()
    navigationItem.rightBarButtonItem = nil
  }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
    cell.configure(with: <#T##UserPost#>)
    return cell
  }


}
