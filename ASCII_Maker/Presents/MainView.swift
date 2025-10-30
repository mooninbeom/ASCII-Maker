//
//  MainView.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/16/25.
//

import SwiftUI
import PhotosUI


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
                        .photosPicker(
                            isPresented: $viewModel.isPhotosPickerPresented,
                            selection: $viewModel.photosPickerItem
                        )
                    
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
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(Color(hex: "#EA2264"))
            }
            
            if viewModel.isASCIIInfomationPresented {
                ZStack {
                    Color.gray.opacity(0.7)
                        .ignoresSafeArea()
                        .onTapGesture {
                            viewModel.isASCIIInfomationPresented.toggle()
                        }
                    
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
                        .onTapGesture {
                            self.viewModel.isImageGuidePresented = false
                        }
                    
                    ImageGuideView { noMoreGuide in
                        if noMoreGuide {
                            UserDefaults.noMoreGuide = true
                        }
                        
                        self.viewModel.backgroundRemovedImage = nil
                        self.viewModel.isPhotosPickerPresented.toggle()
                        self.viewModel.isImageGuidePresented = false
                    }
                    .padding(20)
                }
            }
            
            if viewModel.isRemoveBackgroundFailureAlertPresented {
                RemoveBackgroundFailureAlert()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            viewModel.isRemoveBackgroundFailureAlertPresented = false
                        }
                    }
            }
        }
    }
}



#Preview {
    MainView()
}
