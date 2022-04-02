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
