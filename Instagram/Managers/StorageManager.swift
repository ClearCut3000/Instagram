//
//  StorageManager.swift
//  Instagram
//
//  Created by Николай Никитин on 30.03.2022.
//
import FirebaseStorage
import Foundation

public class StorageManager {

  //MARK: - Properties
  static let shared = StorageManager()

  private let bucket = Storage.storage().reference()

  public enum IGStorageManagerError: Error {
    case failedToDownload
  }

  //MARK: - Methods
  public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {

  }

  public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
    bucket.child(reference).downloadURL { url, error in
      guard let url = url, error == nil else {
        completion(.failure(.failedToDownload))
        return
      }
      completion(.success(url))
    }
  }
}
