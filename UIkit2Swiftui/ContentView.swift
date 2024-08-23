//
//  ContentView.swift
//  UIkit2Swiftui
//
//  Created by Satvik Viriyala on 21/05/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var commentManager = CommentManager.shared

    var body: some View {
        TabView {
            Text("Home View")
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            Text("Bookmarks View")
                .tabItem {
                    Label("Bookmarks", systemImage: "book")
                }

            Text("Chat View")
                .tabItem {
                    Label("Chat", systemImage: "message")
                }

            ContentView()
                .tabItem {
                    Label("Explore", systemImage: "globe")
                }
        }
        .environmentObject(commentManager)
    }
}

struct ContentView: View {
    @StateObject private var commentManager = CommentManager.shared
    @State private var isReplying = false
    @State private var showAddPostView = false
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
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HeaderView(onSearch: { searchText in
                        // Handle search action
                    })
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
                            showAddPostView = true // Toggle the modal sheet
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
            AddPostView() // Use a wrapper view to embed in NavigationView
                        .background(Color(red: 0.93, green: 0.93, blue: 1))  // Keep the background color consistent
                }
    }
}

struct Post: Identifiable {
    let id = UUID()
    let content: String
    let userAvatar: Image
    let communityImage: Image
    let userName: String
    let communityName: String
    let timeOfPost: Date
    let hasJoinedCommunity: Bool
    let postIndex: Int
}

// ... Other Views (HeaderView, CommunityNavigationBar, PostView, etc.) ...

#Preview {
    MainView()
}
