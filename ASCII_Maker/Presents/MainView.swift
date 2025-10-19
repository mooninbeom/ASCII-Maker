//
//  MainView.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/16/25.
//

import SwiftUI



struct MainView: View {
    @State private var viewModel: MainViewModel = .init()
    
    
    var body: some View {
        ZStack {
            Color.init(hex: "#090B30")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Button {
                    withAnimation {
                        viewModel.screen = viewModel.screen == .main ? .setting : .main
                    }
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 30))
                }
                .customColor(.secondary)
                .opacity(viewModel.isSettingScreenPresented ? 0 : 1)
                
                Image(.mainLogo)
                    .padding(.top, 5)
                
                switch viewModel.screen {
                case .main:
                    MainScreen(viewModel: $viewModel)
                        .padding(.horizontal, 30)
//                        .transition(.push(from: viewModel.isSettingViewPresented ? .leading : .trailing))
                        .transition(.push(from: .trailing))
                    
                case .setting:
                    SettingScreen(viewModel: $viewModel)
                        .padding(.horizontal, 30)

                case .history:
                    EmptyView()
                case .info:
                    EmptyView()
                }   
            }
        }

    }
}



#Preview {
    MainView()
}
