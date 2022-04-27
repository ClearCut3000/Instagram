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
  private var tabbedSearchCollectionView: UICollectionView?

  private let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.placeholder = "Search"
    searchBar.backgroundColor = .secondarySystemBackground
    return searchBar
  }()

  private var collectionView: UICollectionView?

  private let dimmedView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    view.isHidden = true
    view.alpha = 0
  }()

  //MARK: - Layout
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView?.frame = view.bounds
    dimmedView.frame = view.bounds
    tabbedSearchCollectionView?.frame = CGRect(x: 0,
                                             y: view.safeAreaInsets.top,
                                             width: view.width,
                                             height: 72)
  }

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureExploreCollection()
    configureSearchBar()
    configureDimmedView()
  }

  //MARK: - UIMethods
  private func configureTabbedSearch() {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: view.width/3, height: 52)
    layout.scrollDirection = .horizontal
    tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    tabbedSearchCollectionView?.isHidden = false
    guard let tabbedSearchCollectionView = tabbedSearchCollectionView else { return }
    tabbedSearchCollectionView.delegate = self
    tabbedSearchCollectionView.dataSource = self
    view.addSubview(tabbedSearchCollectionView)
  }

  private func configureDimmedView() {
    view.addSubview(dimmedView)
    let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
    gesture.numberOfTouchesRequired = 1
    gesture.numberOfTapsRequired = 1
    dimmedView.addGestureRecognizer(gesture)
  }

  private func configureSearchBar() {
    navigationController?.navigationBar.topItem?.titleView = searchBar
    searchBar.delegate = self
  }

  private func configureExploreCollection() {
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
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(didCancelSearch))
    dimmedView.isHidden = false
    UIView.animate(withDuration: 0.2, animations: { self.dimmedView.alpha = 0.4 }) { done in
      if done {
        self.tabbedSearchCollectionView?.isHidden = false
      }
    }
  }

  @objc private func didCancelSearch() {
    searchBar.resignFirstResponder()
    navigationItem.rightBarButtonItem = nil
    self.tabbedSearchCollectionView?.isHidden = true
    UIView.animate(withDuration: 0.2, animations: {
      self.dimmedView.alpha = 0
    }) { done in
      if done {
        self.dimmedView.isHidden = true
      }
    }
  }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == tabbedSearchCollectionView {
      return 0
    }
    return 100
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if collectionView == tabbedSearchCollectionView {
      return UICollectionViewCell()
    }
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
    cell.configure(with: <#T##UserPost#>)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    //    let model = models[indexPath.row]
    let vc = PostViewController(model: nil)
    vc.title = ""
    navigationController?.pushViewController(vc, animated: true)
  }

}
