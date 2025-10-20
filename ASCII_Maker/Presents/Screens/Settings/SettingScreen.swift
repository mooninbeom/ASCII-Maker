//
//  SettingScreen.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import SwiftUI



struct SettingScreen: View {
    @Binding var viewModel: MainViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            VStack(spacing: 5) {
                HStack {
                    Spacer()
                    
                    Text("설정")
                        .koreanFont(size: 30)
                        .customColor(.secondary)
                    
                    Spacer()
                    
                }
                .overlay(alignment: .leading) {
                    Button("<<<") {
                        self.viewModel.screen = .main
                        self.viewModel.isSettingScreenPresented = false
                    }
                    .koreanFont(size: 30)
                    .customColor(.secondary)
                }
                
                Path { path in
                    let width = UIScreen.main.bounds.width
                    
                    
                    path.move(to: .init(x: 0, y: 0))
                    path.addLine(to: .init(x: width - 60, y: 0.0))
                }
                .stroke(style: .init(lineWidth: 2, dash: [10, 4]))
                .customColor(.secondary)
                .frame(height: 2)
                .background(.white)
            }
            
            Text("히스토리 >")
                .customColor(.text)
            Text("문의하기 >")
                .customColor(.primary)
            Text("개발자 정보 >")
                .customColor(.secondary)
            
            Spacer()
        }
        .onAppear {
            self.viewModel.isSettingScreenPresented = true
        }
        .koreanFont(size: 30)
        .padding(.top, 30)
    }
}
