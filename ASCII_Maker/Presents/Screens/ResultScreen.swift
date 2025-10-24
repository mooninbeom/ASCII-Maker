//
//  ResultScreen.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/21/25.
//

import SwiftUI


struct ResultScreen: View {
    @State private var isSaveImageCompleteAlertPresented: Bool = false
    @State private var isSaveImageFailureAlertPresented: Bool = false
    
    @Binding var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                type: .result,
                dismiss: {
                    viewModel.isResultScreenPresented = false
                },
                trailingButton: {
                    HStack {
                        Button {
                            NotificationCenter.default.post(name: .saveASCIIImage, object: nil)
                        } label: {
                            Image(systemName: "photo")
                        }
                        
                        ShareLink(item: viewModel.resultText ?? "알 수 없음") {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                }
            )
            .padding(.horizontal, 30)
            
            ZoomableScrollView(text: viewModel.resultText ?? "알 수 없음")
        }
        .background(Color(hex: "#090B30"))
        .overlay {
            if isSaveImageCompleteAlertPresented {
                SaveImageCompleteAlert()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isSaveImageCompleteAlertPresented = false
                        }
                    }
            }
            
            if isSaveImageFailureAlertPresented {
                SaveImageFailureAlert()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isSaveImageFailureAlertPresented = false
                        }
                    }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .saveImageResult)) { result in
            if let isSucceeded = result.object as? Bool {
                if isSucceeded {
                    self.isSaveImageCompleteAlertPresented = true
                } else {
                    self.isSaveImageFailureAlertPresented = true
                }
            }
        }
    }
}

