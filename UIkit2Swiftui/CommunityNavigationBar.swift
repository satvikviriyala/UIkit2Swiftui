//
//  CommunityNavigationBar.swift
//  UIkit2Swiftui
//
//  Created by Satvik Viriyala on 21/05/24.
//

import Foundation
import SwiftUI

struct CommunityNavigationBar: View {
    var body: some View {
        HStack {
            Spacer()
            ForEach(["home_svg", "journal_svg", "mychambers_svg", "world_svg"], id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            Spacer()
        }
        .padding()
        .background(Color(red: 0.973, green: 0.973, blue: 1))
    }
}
