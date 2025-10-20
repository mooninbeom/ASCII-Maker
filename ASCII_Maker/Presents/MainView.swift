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
                    viewModel.screen = viewModel.screen == .main ? .setting : .main
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
                    
                case .setting:
                    SettingScreen(viewModel: $viewModel)
                        .padding(.horizontal, 30)

                case .history:
                    HistoryView(mainViewModel: $viewModel)
                        .padding(.horizontal, 30)
                case .info:
                    DeveloperInfoScreen(mainViewModel: $viewModel)
                        .padding(.horizontal, 30)
                }
            }
        }
        .overlay {
            if viewModel.isASCIIInfomationPresented {
                ZStack {
                    Color.gray.opacity(0.7)
                        .ignoresSafeArea()
                    
                    ArtInfoView {
                        viewModel.isASCIIInfomationPresented.toggle()
                    }
                    .padding(20)
                }
            }
            
            if viewModel.isImageGuidePresented {
                ZStack {
                    Color.gray.opacity(0.5)
                        .ignoresSafeArea()
                    
                    ImageGuideView {
                        viewModel.isImageGuidePresented.toggle()
                    }
                    .padding(20)
                }
            }
        }
    }
}



#Preview {
    MainView()
}
