//
//  AddPostView.swift
//  UIkit2Swiftui
//
//  Created by Satvik Viriyala on 22/05/24.
//

import Foundation
import SwiftUI

struct AddPostView: View {
    @State private var isPostAnonymous = false
    @Environment(\.dismiss) var dismiss
    @State private var userThoughts = ""
    @State private var textHeight: CGFloat = 200
    @State private var minHeight: CGFloat = 100
    //@State private var selectedCommunity = "Select A Community"
    @State private var searchText = ""
    @State private var filteredCommunities: [String] = []
    @State private var isCommunityPopupShown = false
    @State private var selectedTags: [String] = []
    @State private var isTagPopupShown = false
    @State private var maxTagsAllowed = 5 // Maximum tags allowed
    @State private var selectedCommunity: String = "Select A Community" // Store the selected community
    
    let allCommunities = ["Community A", "Community B", "Community C", "Community D", "Community E", "Community F", "Community G", "Community H"]

    let communityOptions = ["Community 1", "Community 2", "Community 3", "Community 4", "Community 5"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Posts")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .pink]), startPoint: .leading, endPoint: .trailing))
                    HStack {
                        Image("post1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                            .overlay(
                                Text("1")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(10),
                                alignment: .bottomTrailing
                            )
                        
                        Spacer()
                        
                        Image("post2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                            .overlay(
                                Text("2")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(10),
                                alignment: .bottomTrailing
                            )
                        
                        Spacer()
                        
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .frame(width: 100, height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    }
                    .padding()
                    
                    Text("Share Your Thoughts")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .padding()

                                    ZStack(alignment: .topLeading) {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white)
                                            .frame(height: 150) // Adjust height as needed

                                        TextEditor(text: $userThoughts) // Using TextEditor for multiline
                                            //.padding()
                                            .frame(height: 130)
                                            .padding(.horizontal, 16)
                                            .padding(.top, 12)
                                            .foregroundColor(.gray)
                                            .background(Color.clear)
                                    }
                                    .padding(.horizontal)
                                    .padding(.bottom)

                    Text("Share")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()

                    VStack(alignment: .leading) {
                                            ZStack(alignment: .leading) {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(Color(red: 0.93, green: 0.93, blue: 1))
                                                    .frame(height: 50)

                                                HStack {
                                                    Text(selectedCommunity) // Display selected community
                                                        .padding(.leading, 16)
                                                        .foregroundColor(.gray)
                                                    Spacer()
                                                    Image(systemName: "chevron.down")
                                                        .padding(.trailing, 16)
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                            .onTapGesture {
                                                isCommunityPopupShown = true
                                            }
                                            .padding(.horizontal)
                                            .padding(.bottom)
                                        }
                                        .sheet(isPresented: $isCommunityPopupShown) {
                                            CommunityPopupView(isPresented: $isCommunityPopupShown, selectedCommunity: $selectedCommunity) // Pass the binding
                                        }
                    // Tag Other Communities section
                    VStack(alignment: .leading) {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.93, green: 0.93, blue: 1))
                                .frame(height: 50)

                            HStack {
                                if selectedTags.isEmpty {
                                    Text("Other Communities")
                                        .padding(.leading, 16)
                                        .foregroundColor(.gray)
                                } else {
                                    VStack {
                                        ForEach(selectedTags, id: \.self) { tag in
                                            TagButton(tag: tag, selectedTags: $selectedTags)
                                        }
                                    }
                                    .padding(.leading, 16)
                                }
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .padding(.trailing, 16)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onTapGesture {
                            isTagPopupShown = true
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .sheet(isPresented: $isTagPopupShown) {
                        TagPopupView(isPresented: $isTagPopupShown, selectedTags: $selectedTags, maxTagsAllowed: maxTagsAllowed)
                    }

                    // Error message if max tags reached
                    if selectedTags.count == maxTagsAllowed {
                        Text("Oops, can't select more. \(maxTagsAllowed)/\(maxTagsAllowed) tags selected!")
                            .foregroundColor(.red)
                            .padding()
                    }
                    HStack {
                        Text("Post Anonymously")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Toggle(isOn: $isPostAnonymous) {
                            Text("")
                        }
                        .padding()
                    }
                    
                    Button("Post") {
                        // Handle post action here
                    }
                    .padding()
                    .padding(.horizontal)
                    .frame(maxWidth:355)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                }
            }
            .navigationTitle("Post")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                dismiss() // Call dismiss to close the sheet
            }) {
                Image(systemName: "chevron.left") // Or use a different back button image
            })
            .background(Color(red: 0.93, green: 0.93, blue: 1))
        }
            
        }
    
}



extension String {
    func heightOfText(font: UIFont, width: CGFloat) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return boundingBox.height
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView()
    }
}

struct CommunityPopupView: View {
    @Binding var isPresented: Bool
    @Binding var selectedCommunity: String
    @Environment(\.dismiss) var dismiss // Add this for dismissing the sheet
       
    @State private var searchText = ""

    let allCommunities = [
        "Dealing with Anxiety",
        "Relationship Issues",
        "Exploring Personal Identity",
        "Financial Concerns",
        "Career Advice",
        "Coping with Empty Nest Syndrome",
        "Sleep-related Concerns",
        "Exploring Personal Identity",
        "Financial Concerns",
        "Academic Stress"
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Title Bar (with gradient)
                ZStack(alignment: .leading) {
                    Color(red: 0.93, green: 0.93, blue: 1) // Light gray background
                    HStack {
                        Button(action: {
                            isPresented = false
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("Communities")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .pink]), startPoint: .leading, endPoint: .trailing))
                            .padding(.leading, -265)
                    }
                    .padding(.horizontal)
                }
                .frame(height: 50)

                // Search Bar
                TextField("Search", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Community List
                List {
                    ForEach(filteredCommunities, id: \.self) { community in
                        HStack {
                            Text(community)
                            Spacer()
                            Image(systemName: "circle.fill")
                                .foregroundColor(selectedCommunity == community ? .blue : .gray)
                                .onTapGesture {
                                    selectedCommunity = community
                                }
                        }
                    }
                }
                .listStyle(.plain) // Remove list separators
                .padding(.horizontal)

                // Done Button
                Button("Done") {
                    dismiss()
                    // Handle selected community
                    //print("Selected Community: \(selectedCommunity ?? "None")")
                }
                .padding()
                .padding(.horizontal)
                .frame(maxWidth:355)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            }
            .navigationTitle("")
            .navigationBarHidden(true) // Hide the default navigation bar
            .background(Color(red: 0.93, green: 0.93, blue: 1)) // Light gray background for the whole view
        }
    }

    var filteredCommunities: [String] {
        if searchText.isEmpty {
            return allCommunities
        } else {
            return allCommunities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
// Tag Button View (for the selected tags display)
struct TagButton: View {
    let tag: String
    @Binding var selectedTags: [String]

    var body: some View {
        Button(action: {
            if let index = selectedTags.firstIndex(of: tag) {
                selectedTags.remove(at: index)
            }
        }) {
            HStack {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                Text(tag)
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer() // Push the "xmark" to the left
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 12)
            .background(Color.blue.opacity(0.7))
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 4)
    }
}

// Popup View
struct TagPopupView: View {
    @Binding var isPresented: Bool
    @Binding var selectedTags: [String]
    @Environment(\.dismiss) var dismiss 
    let maxTagsAllowed: Int

    @State private var searchText = ""

    let allCommunities = [
        "Dealing with Anxiety",
        "Relationship Issues",
        "Exploring Personal Identity",
        "Financial Concerns",
        "Career Advice",
        "Empty Nest Syndrome",
        "Sleep-related Concerns",
        // ... add more communities
    ]

    var body: some View {
        NavigationView {
            VStack {
                // ... your existing title bar code ...

                // Search Bar
                TextField("Search", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Community List
                List {
                    ForEach(filteredCommunities, id: \.self) { community in
                        HStack {
                            Text(community)
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(selectedTags.contains(community) ? .blue : .gray)
                                .onTapGesture {
                                    if selectedTags.contains(community) {
                                        if let index = selectedTags.firstIndex(of: community) {
                                            selectedTags.remove(at: index)
                                        }
                                    } else {
                                        if selectedTags.count < maxTagsAllowed {
                                            selectedTags.append(community)
                                        }
                                    }
                                }
                        }
                    }
                }
                .listStyle(.plain) // Remove list separators
                .padding(.horizontal)

                // Done Button
                Button("Done") {
                    dismiss()
                }
                .padding()
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .background(Color(red: 0.93, green: 0.93, blue: 1))
        }
    }

    var filteredCommunities: [String] {
        if searchText.isEmpty {
            return allCommunities
        } else {
            return allCommunities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
