//
//  CommentView.swift
//  UIkit2Swiftui
//
//  Created by Satvik Viriyala on 21/05/24.
//

import Foundation
import SwiftUI

struct CommentView: View {
    @ObservedObject var comment: Comment
    @State private var isExpanded = false
    @State private var isReplying = false
    @State private var replyText = ""
    @EnvironmentObject var commentManager: CommentManager
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                comment.userAvatar
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("@\(comment.userName)")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.592, green: 0.592, blue: 0.592))
                    
                    Text(comment.content)
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.357))
                        .lineLimit(isExpanded ? nil : 2)
                    
                    if !isExpanded && comment.content.count > 100 { // Adjust limit as needed
                        Button("See More") {
                            isExpanded = true
                        }
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.48, green: 0.48, blue: 1))
                    }
                }
            }
            
            if !comment.replies.isEmpty {
                HStack {
                    Text("\(comment.replies.count) Comments")
                        .font(.system(size: 17))
                        .foregroundColor(Color(red: 0.69, green: 0.69, blue: 0.792))
                        .onTapGesture {
                            // Handle tap on comments count
                        }
                    Spacer()
                }
                .padding(.top, 5)
            }
            
            ReactionsReplyView(comment: comment, isReplying: $isReplying)
                .environmentObject(commentManager)
            
            if isReplying {
                HStack {
                    TextField("Write a reply...", text: $replyText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Send") {
                        sendReply()
                    }
                }
                .padding(.leading, 50) // Indent reply field
            }
            
            if !comment.replies.isEmpty {
                ForEach(comment.replies) { reply in
                    CommentView(comment: reply)
                        .padding(.leading, 20) // Indent replies
                }
            }
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
    }

    private func sendReply() {
        let newReply = Comment(userName: "You",
                              userAvatar: Image("userAvatar"),
                              content: replyText,
                              replies: [],
                              parentComment: comment)
        comment.replies.append(newReply)
        replyText = ""
        isReplying = false
    }
}

