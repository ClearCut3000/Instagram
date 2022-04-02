//
//  AuthManager.swift
//  Instagram
//
//  Created by Николай Никитин on 30.03.2022.
//

import FirebaseAuth

public class AuthManager {

  //MARK: - Properties
  static let shared = AuthManager()

  //MARK: - Methods
  public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
    DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
      if canCreate {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
          guard error == nil, result != nil else {
            print("FirebaseAuth couldn't create account. Auth result is \(String(describing: result))")
            print("FirebaseAuthAuth couldn't create account. Auth error is \(String(describing: error))")
            completion(false)
            return
          }
          DatabaseManager.shared.insertNewUser(with: username, email: email) { success in
            if success {
              completion(true)
              return
            } else {
              completion(false)
              return
            }
          }
        }
      } else {
        completion(false)
      }
    }
  }

  public func loginUser(userName: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
    if let email = email {
      Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        guard authResult != nil, error == nil else {
          print("authResult is \(String(describing: authResult))")
          print("autError is \(String(describing: error))")
          completion(false)
          return
        }
        completion(true)
      }
    } else if let userName = userName {
      print(userName)
    }
  }
}
