//
//  VerticalDivider.swift
//  UIkit2Swiftui
//
//  Created by Satvik Viriyala on 21/05/24.
//

import Foundation
import SwiftUI

struct VerticalDivider: View {
    var height: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(Color(red: 0.64, green: 0.64, blue: 1))
            .frame(width: 1, height: height)
    }
}
