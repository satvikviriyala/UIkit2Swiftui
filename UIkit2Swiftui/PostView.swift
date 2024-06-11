import Foundation
import SwiftUI

struct PostView: View {
    let userAvatar: Image
    let communityImage: Image
    let userName: String
    let communityName: String
    let timeOfPost: Date
    @State public var hasJoinedCommunity: Bool
    let content: String
    @State private var isContentExpanded = false
    @Binding var isReplying: Bool
    @State public var showJoinButton = true
    @State private var isAnimating = false
    @State private var showCommunityLandingPage = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                userAvatar
                    .resizable()
                    .frame(width: 42, height: 42)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )

                VStack(alignment: .leading) {
                    Text(userName)
                        .font(.system(size: 20))
                        .foregroundColor(Color(red: 0.592, green: 0.592, blue: 0.592))

                    Text(communityName)
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 0.592, green: 0.592, blue: 0.592))

                    Text(timeAgoDisplay(timeOfPost: timeOfPost))
                        .font(.system(size: 9))
                        .foregroundColor(Color(red: 0.69, green: 0.69, blue: 0.792))
                }

                Spacer()
            }
            .padding(.leading, 16)
            .padding(.top, 16)

            // "Join" button
            if showJoinButton {
                HStack {
                    Spacer()
                    Button(action: {
                        isAnimating = true
                        withAnimation(.easeInOut(duration: 0.5)) {
                            hasJoinedCommunity.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                showJoinButton = false
                                //showCommunityLandingPage = true // Show the community landing page
                            }
                        }
                    }) {
                        Text(hasJoinedCommunity ? "Joined" : "Join")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 16)
                            .background(isAnimating ? Color.gray : Color(red: 0.478, green: 0.478, blue: 1))
                            .cornerRadius(8)
                    }
                    .padding(.trailing, 16)
                    .contentShape(Rectangle()) // Ensures the button is only clickable within its bounds
                }
                .opacity(showJoinButton ? 1 : 0)
                .animation(.easeInOut(duration: 0.5), value: showJoinButton)
            }

            Text(content)
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.18, green: 0.18, blue: 0.357))
                .lineLimit(isContentExpanded ? nil : 2)
                .padding(.horizontal, 16)
                .padding(.top, 12)

            if !isContentExpanded && content.count > 100 {
                Button("See More") {
                    isContentExpanded = true
                }
                .font(.system(size: 14))
                .foregroundColor(Color(red: 0.48, green: 0.48, blue: 1))
                .padding(.horizontal, 10)
            }
            Divider()
                .padding(.horizontal, 16)
                .padding(.top, 10)

            ReactionsReplyView(comment: Comment(userName: "Placeholder",
                                                 userAvatar: Image("userAvatar"),
                                                 content: "This is a placeholder comment.",
                                                 replies: [],
                                                 parentComment: nil), isReplying: $isReplying)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)

            CommentView(comment: Comment(userName: "Placeholder",
                                         userAvatar: Image("userAvatar"),
                                         content: "This is a placeholder comment.",
                                         replies: [],
                                         parentComment: nil))
                .padding(.leading, 16)
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .onTapGesture {
            showCommunityLandingPage = true
        }
        .contentShape(Rectangle()) // Ensure the tap gesture covers the entire VStack
        .fullScreenCover(isPresented: $showCommunityLandingPage) {
            CommunityLandingPageView(isPresented: $showCommunityLandingPage)
                .background(Color(red: 0.93, green: 0.93, blue: 1))
        }
    }

    func timeAgoDisplay(timeOfPost: Date) -> String {
            let elapsedTime = Date().timeIntervalSince(timeOfPost)
            if elapsedTime < 60 {
                return "Just now"
            } else if elapsedTime < 3600 {
                return "\(Int(elapsedTime / 60))m ago"
            } else if elapsedTime < 86400 {
                return "\(Int(elapsedTime / 3600))h ago"
            } else {
                return "\(Int(elapsedTime / 86400))d ago"
            }
    }
}
