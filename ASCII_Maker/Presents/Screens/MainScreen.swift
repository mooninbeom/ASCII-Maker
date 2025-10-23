//
//  MainScreen.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import SwiftUI


struct MainScreen: View {
    @State private var isPopoverPresented: Bool = false
    
    @Binding var viewModel: MainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text("내 이미지를 손쉽게 ASCII ART로!")
                .koreanFont(size: 15)
                .customColor(.secondary)
                .padding(.top, 20)
            
            HStack(alignment: .top, spacing: 0) {
                Text("ASCII ART란?")
                    .koreanFont(size: 15)
                    .customColor(.secondary)
                
                Button {
                    viewModel.isASCIIInfomationPresented.toggle()
                } label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 10))
                }
                .foregroundStyle(.gray)
            }
            .padding(.top, 5)
            
            
            Button {
                if UserDefaults.noMoreGuide {
                    viewModel.isPhotosPickerPresented.toggle()
                } else {
                    viewModel.isImageGuidePresented.toggle()
                }
            } label: {
                if let uiImage = viewModel.currentImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    
                } else {
                    VStack {
                        Text("이미지 선택하기")
                            .koreanFont(size: 15)
                        
                        Image(systemName: "photo")
                            .font(.system(size: 100))
                    }
                }
            }
            .foregroundStyle(.white)
            .padding(.top, 50)
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Group {
                        Text("변환 품질")
                            .koreanFont(size: 25)
                            .customColor(.text)
                        
                        if let currentPixels = viewModel.currentPixels {
                            HStack(alignment: .center, spacing: 0) {
                                Text("현재 픽셀 수: \(currentPixels.0) x \(currentPixels.1)px")
                                    .koreanFont(size: 14)
                                    .foregroundStyle(.white)
                                
                                if currentPixels.0 > 500 || currentPixels.1 > 500 {
                                    Button {
                                        self.isPopoverPresented.toggle()
                                    } label: {
                                        Image(systemName: "exclamationmark.circle")
                                            .font(.system(size: 15))
                                    }
                                    .customColor(.primary)
                                    .popover(isPresented: self.$isPopoverPresented) {
                                        Text("현재 이미지가 너무 커 원본 변환 시 500 x 500px로 조절 됩니다.")
                                            .koreanFont(size: 14)
                                            .customColor(.secondary)
                                            .presentationCompactAdaptation(.popover)
                                            .presentationBackground(Color(hex: "#0D1164"))
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 10)
                    
                    qualityButton
                }
                
                Spacer()
            }
            .padding(.top, 80)
            
            Spacer()
            
            Button {
                viewModel.convertButtonTapped()
            } label: {
                ZStack {
                    if viewModel.transferButtonDisabled {
                        Rectangle()
                            .frame(height: 80)
                            .foregroundStyle(.gray)
                    } else {
                        Rectangle()
                            .frame(height: 80)
                            .customColor(.primary)
                    }
                    
                    HStack(spacing: 20) {
                        Image(systemName: "photo")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                        
                        Image(systemName: "arrowshape.right.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                        
                        Image(systemName: "text.quote")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)

                    }
                }
            }
            .disabled(viewModel.transferButtonDisabled)
        }
        .fullScreenCover(isPresented: $viewModel.isResultScreenPresented) {
            ResultScreen(viewModel: $viewModel)
        }
    }
    
    
    public var qualityButton: some View {
        Group {
            QualityListCell(
                currentQuality: $viewModel.quality,
                disabled: $viewModel.originalButton,
                qualityList: .original
            ) { quality in
                viewModel.quality = quality
            }
            .padding(.bottom, 15)
            
            QualityListCell(
                currentQuality: $viewModel.quality,
                disabled: $viewModel.highButton,
                qualityList: .high
            ) { quality in
                viewModel.quality = quality
            }
            .padding(.bottom, 15)
            
            QualityListCell(
                currentQuality: $viewModel.quality,
                disabled: $viewModel.mediumButton,
                qualityList: .medium
            ) { quality in
                viewModel.quality = quality
            }
            .padding(.bottom, 15)
            
            QualityListCell(
                currentQuality: $viewModel.quality,
                disabled: $viewModel.lowButton,
                qualityList: .low
            ) { quality in
                viewModel.quality = quality
            }
            .padding(.bottom, 15)
        }
    }
}


private struct QualityListCell: View {
    @Binding var currentQuality: MainViewModel.QualityList?
    @Binding var disabled: Bool
    
    let qualityList: MainViewModel.QualityList
    
    let action: (MainViewModel.QualityList) -> Void
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(disabled ? .gray : .white)
                .overlay {
                    if currentQuality == qualityList {
                        Circle()
                            .frame(width: 14, height: 14)
                            .customColor(disabled ? .background : .primary)
                    }
                }
            
            Text(qualityList.text)
                .koreanFont(size: 14)
                .foregroundStyle(.white)
        }
        .onTapGesture {
            action(self.qualityList)
        }
        .disabled(disabled)
    }
}
