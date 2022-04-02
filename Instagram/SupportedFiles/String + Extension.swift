//
//  String + Extension.swift
//  Instagram
//
//  Created by Николай Никитин on 02.04.2022.
//

import Foundation
extension String {
  func safeDatabaseKey() -> String {
    return self.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_")
  }
}
