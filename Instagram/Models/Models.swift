//
//  Models.swift
//  Instagram
//
//  Created by Николай Никитин on 06.04.2022.
//

import Foundation

enum Gender {
  case male, female, other
}

struct User {
  let username: String
  let bio: String
  let name: (first: String, last: String)
  let profilePhoto: URL
  let birthDate: Date
  let gender: Gender
  let counts: UserCount
  let joinDate: Date
}

struct UserCount {
  let follewers: Int
  let following: Int
  let posts: Int
}

public enum UserPostType {
  case photo, video
}

public struct UserPost {
  let postIdentifier: String
  let postType: UserPostType
  let thumbnailImage: URL
  let postUR: URL
  let caption: String?
  let likeCount: [PostLikes]
  let comments: [PostComment]
  let createdDate: Date
  let taggedUsers: [String]
}

struct PostComment {
  let userName: String
  let postIdentifier: String
}

struct CommentLike {
  let username: String
  let commentIdentifier: String
}

struct PostLikes {
  let identifier: String
  let username: String
  let text: String
  let createdDate: Date
  let likes: [CommentLike]
}
