//
//  MainScreen.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import SwiftUI


struct MainScreen: View {
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
                
            } label: {
                VStack {
                    Text("이미지 선택하기")
                        .koreanFont(size: 15)
                    
                    Image(systemName: "photo")
                        .font(.system(size: 100))
                }
            }
            .foregroundStyle(.white)
            .padding(.top, 50)
            
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("변환 품질")
                        .koreanFont(size: 25)
                        .customColor(.text)
                        .padding(.bottom, 10)
                    
                    ForEach(MainViewModel.QualityList.allCases) { quality in
                        QualityListCell(
                            currentQuality: $viewModel.quality,
                            qualityList: quality
                        ) { quality in
                            viewModel.quality = quality
                        }
                        .padding(.bottom, 15)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 80)
            
            Spacer()
            
            Button {
                viewModel.isImageGuidePresented.toggle()
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 80)
                        .customColor(.primary)
                    
                    
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
        }
    }
}


private struct QualityListCell: View {
    @Binding var currentQuality: MainViewModel.QualityList
    
    let qualityList: MainViewModel.QualityList
    
    let action: (MainViewModel.QualityList) -> Void
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 20, height: 20)
                .foregroundStyle(.white)
                .overlay {
                    if currentQuality == qualityList {
                        Circle()
                            .frame(width: 14, height: 14)
                            .customColor(.primary)
                    }
                }
            
            Text(qualityList.text)
                .koreanFont(size: 14)
                .foregroundStyle(.white)
        }
        .onTapGesture {
            action(self.qualityList)
        }
    }
}
