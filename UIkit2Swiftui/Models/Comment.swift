//
//  Comment.swift
//  UIkit2Swiftui
//
//  Created by Satvik Viriyala on 21/05/24.
//

import Foundation
import SwiftUI

class Comment: Identifiable, ObservableObject {
    let id = UUID()
    let userName: String
    let userAvatar: Image
    let content: String
    @Published var replies: [Comment]
    weak var parentComment: Comment?
    
    init(userName: String, userAvatar: Image, content: String, replies: [Comment], parentComment: Comment?) {
        self.userName = userName
        self.userAvatar = userAvatar
        self.content = content
        self.replies = replies
        self.parentComment = parentComment
    }
}
