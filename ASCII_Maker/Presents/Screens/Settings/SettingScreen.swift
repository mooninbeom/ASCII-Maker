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
            CustomNavigationBar(type: .setting) {
                self.viewModel.screen = .main
                self.viewModel.isSettingScreenPresented = false
            }
            
            Button {
                self.viewModel.screen = .history
            } label: {
                Text("히스토리 >")
                    .customColor(.text)
            }
            
            Button {
                
            } label: {
                Text("문의하기 >")
                    .customColor(.primary)
            }

            Button {
                self.viewModel.screen = .info
            } label: {
                Text("개발자 정보 >")
                    .customColor(.secondary)
            }
            
            Spacer()
        }
        .onAppear {
            self.viewModel.isSettingScreenPresented = true
        }
        .koreanFont(size: 30)
        .padding(.top, 30)
    }
}
