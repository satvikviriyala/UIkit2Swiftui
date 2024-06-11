//
//  CommentManager.swift
//  UIkit2Swiftui
//
//  Created by Satvik Viriyala on 21/05/24.
//

import Foundation
import SwiftUI

class CommentManager: ObservableObject {
    static let shared = CommentManager()
    
    @Published private(set) var comments: [Int: [Comment]] = [:]
    
    private init() {}
    
    func getComments(for postIndex: Int) -> [Comment] {
        return comments[postIndex] ?? []
    }
    
    func addComment(_ comment: Comment, for postIndex: Int) {
        if comments[postIndex] == nil {
            comments[postIndex] = []
        }
        comments[postIndex]?.append(comment)
    }
    
    func updateComments(_ newComments: [Comment], for postIndex: Int) {
        comments[postIndex] = newComments
    }
}
