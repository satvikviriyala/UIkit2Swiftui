//
//  HeaderView.swift
//  UIkit2Swiftui
//
//  Created by Satvik Viriyala on 21/05/24.
//

import SwiftUI

struct HeaderView: View {
    @State private var searchText = ""
    var onSearch: ((String) -> Void)?

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                Image("CommunityLinearBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 40)
                    .edgesIgnoringSafeArea(.all)
                    .padding(.leading, -220)
                    .padding(.top, 20)
                
                HStack(alignment: .top) {
                    Image("CommunityLinear")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 40) // Adjust width as needed
                        .padding(.leading, 17)
                        .padding(.top, 20)

                    Spacer()

                    Image("profile_pic")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 37, height: 37)
                        .clipShape(Circle())
                        .padding(.trailing, 17)
                        .padding(.top, 24)
                }
            }

            Color.gray.opacity(0.6) // Separator line
                .frame(height: 1.5)
                .padding(.horizontal, 19)
                .padding(.top, 18)

            HStack {
                TextField("Find More Categories", text: $searchText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .padding(.bottom, 20)
                
                Button(action: {
                    onSearch?(searchText)
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.gray.opacity(0.5))
                        .clipShape(Circle())
                        .padding(.trailing, 19)
                }
            }
        }
        .background(Color(red: 0.93, green: 0.93, blue: 1))
    }
}

#Preview {
    HeaderView()
}
