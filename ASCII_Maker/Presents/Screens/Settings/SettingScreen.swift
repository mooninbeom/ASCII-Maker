//
//  SettingScreen.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import SwiftUI
import MessageUI



struct SettingScreen: View {
    @State private var isEmailViewPresented: Bool = false
    @State private var isAlertPresented: Bool = false
    
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
                sendEmail()
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
        .sheet(isPresented: $isEmailViewPresented) {
            EmailView()
        }
        .alert(
            "Mail을 사용할 수 없습니다.",
            isPresented: $isAlertPresented,
            actions: {
                Button("확인", role: .cancel) {
                    
                }
            },
            message: {
                Text("Mail 앱 설정이 되어있지 않은 경우 사용이 불가합니다.\n기기 설정에서 Mail 계정을 추가하거나 다른 연락처로 연락해주세요!")
            }
        )
    }
}


extension SettingScreen {
    private func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            isEmailViewPresented.toggle()
        } else {
            self.isAlertPresented.toggle()
        }
    }
}
