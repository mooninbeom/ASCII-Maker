//
//  ResultScreen.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/21/25.
//

import SwiftUI


struct ResultScreen: View {
    @State private var isColorPickerPresented: Bool = false
    @State private var isSaveImageCompleteAlertPresented: Bool = false
    @State private var isSaveImageFailureAlertPresented: Bool = false
    
    @State private var color: UIColor = UIColor(hex: "#EA2264")
    
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
                    Menu {
                        Button {
                            isColorPickerPresented.toggle()
                        } label: {
                            HStack {
                                Text("컬러 선택")
                                
                                Image(systemName: "circle.circle.fill")
                            }
                        }
                        
                        Button {
                            NotificationCenter.default.post(name: .saveASCIIImage, object: nil)
                        } label: {
                            HStack {
                                Text("앨범에 저장")
                                Image(systemName: "photo")
                            }
                        }
                        
                        ShareLink(item: resultText) {
                            HStack {
                                Text("공유")
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            )
            .padding(.horizontal, 30)
            
            ZoomableScrollView(text: resultText, color: $color)
        }
        .background(Color(hex: "#090B30"))
        .sheet(isPresented: $isColorPickerPresented) {
            CustomColorPicker(title: "문자 컬러") { uiColor in
                self.color = uiColor
            }
            .padding(.top, 8)
            .background(.white)
            .interactiveDismissDisabled(false)
            .presentationDetents([.height(640)])
        }
        .overlay {
            if isSaveImageCompleteAlertPresented {
                CustomAlertView(
                    title: "저장 완료!",
                    bodyText: "앨범에 저장이 완료되었습니다.",
                ) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isSaveImageCompleteAlertPresented = false
                    }
                }
            }
            
            if isSaveImageFailureAlertPresented {
                CustomAlertView(
                    title: "저장 실패!",
                    bodyText:
                """
                저장에 실패했습니다.
                앨범 사용 권한을 확인해주세요.
                """
                ) {
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

