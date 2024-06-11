//
//  ReactionsReplyView.swift
//  UIkit2Swiftui
//
//  Created by Satvik Viriyala on 21/05/24.
//

import Foundation
import SwiftUI

struct ReactionsReplyView: View {
    @ObservedObject var comment: Comment
    @Binding var isReplying: Bool
    @EnvironmentObject var commentManager: CommentManager
    @State private var showEmojiPicker = false
    @State private var selectedEmoji: String? = nil
    @State private var emojiCounts: [String: Int] = [:]
    @State private var hasReacted = false // Track if the user has reacted
    
    let emojiOptions: [(emoji: String, description: String)] = [
            ("❤️", ""),
            ("🌟", ""),
            ("🫂", ""),
            ("😢", ""),
            ("👏", "") // Add your emojis and descriptions
        ]
    var body: some View {
        HStack {
            ZStack {
                            Button(action: {
                                if !hasReacted {
                                    showEmojiPicker.toggle()
                                }
                            }) {
                                HStack {
                                    if let emoji = selectedEmoji {
                                        Text(emoji)
                                            .font(.system(size: 16))
                                    } else {
                                        Image(systemName: "heart")
                                            .foregroundColor(.red)
                                    }
                                    Text(totalReactionsCount())
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .background(Color.white)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(selectedEmoji != nil ? Color.clear : Color(red: 0.48, green: 0.48, blue: 1), lineWidth: 1)
                                )
                            }

                            // Transparent Overlay for Long Press
                            if hasReacted {
                                Color.clear
                                    .contentShape(Rectangle())
                                    .onTapGesture { }
                                    .onLongPressGesture(minimumDuration: 0.5) {
                                        showEmojiPicker = true
                                    }
                            }
                        }
                        .contentShape(Rectangle())

                        // Inline Emoji Picker
                        if showEmojiPicker {
                            HStack {
                                ForEach(emojiOptions, id: \.emoji) { option in
                                    Button(action: {
                                        // Update reaction count only if changing to a different emoji
                                        if selectedEmoji != option.emoji {
                                            if let previousEmoji = selectedEmoji {
                                                emojiCounts[previousEmoji]? -= 1
                                            }
                                            emojiCounts[option.emoji, default: 0] += 1
                                        }

                                        selectedEmoji = option.emoji
                                        showEmojiPicker = false
                                    }) {
                                        Text(option.emoji)
                                            .font(.system(size: 20))
                                            .frame(width: 30, height: 30)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                            .shadow(color: .black.opacity(0.2), radius: 1, x: 0, y: 1)
                                    }
                                }
                            }
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                            .transition(.scale)
                        }
            if showTopTwoEmojis() {
                HStack {
                    ForEach(topTwoEmojis(), id: \.0) { (emoji, count) in
                        HStack {
                            Text(emoji)
                            Text("\(count)")
                        }
                    }
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(red: 0.69, green: 0.69, blue: 0.79), lineWidth: 1)
                )
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(comment.replies.count) Replies")
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 0.69, green: 0.69, blue: 0.792))
                    .onTapGesture {
                        // Handle tap on "Replies"
                        isReplying = true
                    }
                
                Button(action: {
                    // Handle tap on reply button
                    isReplying = true
                }) {
                    Image("Share") // Assuming this is your reply image
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding(.horizontal, 10)
    }

    private func totalReactionsCount() -> String {
        return "\(emojiCounts.values.reduce(0, +))"
    }

    private func topTwoEmojis() -> [(String, Int)] {
        return emojiCounts.sorted { $0.value > $1.value }.prefix(2).map { ($0.key, $0.value) }
    }

    private func showTopTwoEmojis() -> Bool {
        return emojiCounts.count >= 2
    }
}
