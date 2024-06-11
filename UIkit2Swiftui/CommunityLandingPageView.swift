//
//  CommunityLandingPageView.swift
//  UIkit2Swiftui
//
//  Created by Satvik Viriyala on 11/06/24.
//

import SwiftUI

struct CommunityLandingPageView: View {
    @Binding var isPresented: Bool
    @State private var showAddPostView = false
    @StateObject private var commentManager = CommentManager.shared
    @State private var isReplying = false
    @State private var posts: [Post] = [
        Post(content: "This is the first long text post that should display appropriately in the scroll view.",
             userAvatar: Image("userAvatar"),
             communityImage: Image("communityIcon"),
             userName: "User",
             communityName: "Community",
             timeOfPost: Date(),
             hasJoinedCommunity: false,
             postIndex: 0),
        Post(content: "This is the first long text post that should display appropriately in the scroll view.",
             userAvatar: Image("userAvatar"),
             communityImage: Image("communityIcon"),
             userName: "User",
             communityName: "Community",
             timeOfPost: Date(),
             hasJoinedCommunity: false,
             postIndex: 0),
        Post(content: "This is the first long text post that should display appropriately in the scroll view.",
             userAvatar: Image("userAvatar"),
             communityImage: Image("communityIcon"),
             userName: "User",
             communityName: "Community",
             timeOfPost: Date(),
             hasJoinedCommunity: false,
             postIndex: 0)
        // Add more posts as needed
    ]
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        CommunityFeedView(isPresented: $isPresented)
                        //.ignoresSafeArea(.container, edges: .top)
                            .padding(.top, 50)
                            .padding(.bottom)
                        
                        ForEach(posts) { post in
                            PostView(userAvatar: post.userAvatar,
                                     communityImage: post.communityImage,
                                     userName: post.userName,
                                     communityName: post.communityName,
                                     timeOfPost: post.timeOfPost,
                                     hasJoinedCommunity: post.hasJoinedCommunity,
                                     content: post.content, isReplying: $isReplying)
                            .environmentObject(commentManager)
                        }
                    }
                    .padding(.bottom)
                    
                }
                .ignoresSafeArea(.container, edges: .top)
                .background(Color(red: 0.93, green: 0.93, blue: 1))
                
                Button(action: {
                    showAddPostView = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .imageScale(.large)
                        .padding()
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .fullScreenCover(isPresented: $showAddPostView) {
                AddPostView()
                    .background(Color(red: 0.93, green: 0.93, blue: 1))
            }
        }
        
    }
    
    struct CommunityLandingPageView_Previews: PreviewProvider {
        @State static var isPresented = true
        
        static var previews: some View {
            CommunityLandingPageView(isPresented: $isPresented)
        }
    }
    
    // ... (Other views: MainView, CommunityFeedView, HeartBurstView, PostView, CommentsPageView, CommentsSubview remain the same) ...
    
    
    struct CommunityFeedView: View {
        @State private var showCommunityOptions = false
        @State private var showJoinButton = true
        @State public var hasJoinedCommunity = false
        @State private var isAnimating = false
        @Binding var isPresented: Bool
        
        var body: some View {
            VStack(alignment: .leading) {
                ZStack(alignment: .topLeading) {
                    Image("HappyPeople")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    HStack {
                        Button(action: {
                            isPresented = false
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title3)
                                .imageScale(.small)
                                .padding()
                                .background(Color.white.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .padding(.top)
                        Spacer()
                        Button(action: {
                            // Handle share button action
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title3)
                                .imageScale(.small)
                                .padding()
                                .background(Color.white.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .padding(.top)
                        Button(action: {
                            showCommunityOptions.toggle()
                        }) {
                            Image(systemName: "ellipsis")
                                .font(.title2)
                                .imageScale(.large)
                                .padding()
                                .background(Color.white.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .padding(.top)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("The happy club")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("1K MEMBERS")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
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
                        }
                        .opacity(showJoinButton ? 1 : 0)
                        .animation(.easeInOut(duration: 0.5), value: showJoinButton)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                .padding(.top)
                
                Text("Join our supportive community dedicated to spreading positivity and inspiration!")
                    .padding(.horizontal)
                    .padding(.vertical)
                    .padding(.bottom)
                    .padding(.top)
            }
            .sheet(isPresented: $showCommunityOptions) {
                CommunityOptionsView(showCommunityOptions: $showCommunityOptions)
            }
            .background(Color(red: 0.93, green: 0.93, blue: 1))
        }
    }
    
    
    
    
    
    struct CommunityOptionsView: View {
        @Binding var showCommunityOptions: Bool
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                VStack {
                    Text("Community")
                        .font(.title2).bold()
                    
                    Button("View Guidelines") {
                        // Handle action
                        showCommunityOptions = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    
                    Button("Report") {
                        // Handle action
                        showCommunityOptions = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    
                    Button("Mute This Community") {
                        // Handle action
                        showCommunityOptions = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                    
                    Button("Block") {
                        // Handle action
                        showCommunityOptions = false
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray5))
                    .cornerRadius(8)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                
                Button(action: {
                    showCommunityOptions = false
                }) {
                    Image(systemName: "xmark")
                        .padding()
                }
            }
            .padding()
        }
    }
}
