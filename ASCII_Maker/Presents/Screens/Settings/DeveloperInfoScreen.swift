//
//  DeveloperInfoScreen.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/20/25.
//

import SwiftUI


struct DeveloperInfoScreen: View {
    @Binding var mainViewModel: MainViewModel
    
    var body: some View {
        VStack {
            CustomNavigationBar(type: .developerInfo) {
                mainViewModel.screen = .setting
            } trailingButton: { EmptyView() }
            
            Spacer()
            
            Image(.memoji)
                .resizable()
                .frame(width: 153, height: 153)
            
            Text("Mooni(문인범)")
                .koreanFont(size: 30)
                .customColor(.primary)
            Text("지구 최고의 iOS 개발자가 되기 위해\n노력중인 남자")
                .koreanFont(size: 15)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading) {
                Button {
                    
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "envelope")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                        Text(verbatim: "dlsqja567@naver.com")
                            .englishFont(size: 16)
                    }
                }
                
                Link(destination: URL(string: "https://github.com/mooninbeom")!) {
                    HStack(spacing: 5) {
                        Image(.github)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("@mooninbeom")
                            .englishFont(size: 16)
                    }
                }
                .offset(x: 2)
                
                Link(destination: URL(string: "https://www.linkedin.com/in/인범-문-94ba63298")!) {
                    HStack(spacing: 5) {
                        Image(.linkedIn)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("@문인범")
                            .englishFont(size: 16)
                    }
                }
                .offset(x: 2)
            }
            .padding(.top, 5)
            
            Spacer()
        }
        .padding(.top, 30)
    }
}
