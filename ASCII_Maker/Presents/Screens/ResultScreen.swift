//
//  ResultScreen.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/21/25.
//

import SwiftUI


struct ResultScreen: View {
    @Binding var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                type: .result,
                dismiss: {
                    viewModel.isResultScreenPresented = false
                },
                trailingButton: "square.and.arrow.up",
                trailingAction: {
                    
                }
            )
            .padding(.horizontal, 30)
            
            ScrollView([.horizontal, .vertical]) {
                
            }
        }
        .background(Color(hex: "#090B30"))
    }
}
