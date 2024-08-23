//
//  OptionsView.swift
//  UIkit2Swiftui
//
//  Created by Satvik Viriyala on 21/05/24.
//

import Foundation
import SwiftUI

struct OptionsView: View {
    @Environment(\.presentationMode) var presentationMode
    var reportAction: () -> Void
    var blockAction: () -> Void

    var body: some View {
        VStack {
            Button("Report") {
                reportAction()
                presentationMode.wrappedValue.dismiss()
            }
            Button("Block") {
                blockAction()
                presentationMode.wrappedValue.dismiss()
            }
            // Add other options here
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }
}
