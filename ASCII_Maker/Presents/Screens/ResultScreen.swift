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
    
    let resultText: String
    let dismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                type: .result,
                dismiss: {
                    dismiss()
                },
                trailingButton: {
                    HStack {
                        Button {
                            NotificationCenter.default.post(name: .saveASCIIImage, object: nil)
                        } label: {
                            Image(systemName: "photo")
                        }
                        
                        ShareLink(item: resultText) {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                }
            )
            .padding(.horizontal, 30)
            
            ZoomableScrollView(text: resultText)
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

