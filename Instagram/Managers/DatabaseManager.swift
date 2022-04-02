//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Николай Никитин on 30.03.2022.
//

import FirebaseDatabase

public class DatabaseManager {

  //MARK: - Properties
  static let shared = DatabaseManager()
  private let database = Database.database().reference()

  //MARK: - Public Methods

  /// Chech is username and email is avaliabe
  /// - Parameters:
  ///   - email: String representing email
  ///   - username: String representing username
  ///   - completion: escaping & returns true if chech is passed
  public func canCreateNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {

  }

  /// Inserts new user to database
  /// - Parameters:
  ///   - username: String representing email
  ///   - email: String representing username
  ///   - completion: async callback for result if database entry succeeded
  public func insertNewUser(with username: String, email: String, completion: @escaping (Bool) -> Void) {
    database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
      if error == nil {
        completion(true)
        return
      } else {
        completion(false)
        return
      }
    }
  }

}
