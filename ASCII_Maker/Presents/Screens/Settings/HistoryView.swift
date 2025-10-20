//
//  HistoryView.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import SwiftUI
import MessageUI



struct HistoryView: View {
    @Binding var mainViewModel: MainViewModel
    
    
    var body: some View {
        VStack {
            CustomNavigationBar(type: .history) {
                mainViewModel.screen = .setting
            }
            .padding(.top, 30)
            
            ScrollView(.vertical) {
                HistoryCell(color: .text)
                HistoryCell(color: .primary)
                HistoryCell(color: .secondary)
            }
        }
        .koreanFont(size: 30)
    }
}


struct HistoryCell: View {
    let color: CustomColorModifier.ColorList
    
    var body: some View {
        VStack {
            Image(.doro)
            
            Path { path in
                let width = UIScreen.main.bounds.width
                
                
                path.move(to: .init(x: 45, y: 0))
                path.addLine(to: .init(x: width - 105, y: 0.0))
            }
            .stroke(style: .init(lineWidth: 2, dash: [10, 4]))
            .customColor(color)
        }
        
    }
}


#Preview {
    HistoryView(mainViewModel: .constant(MainViewModel()))
}




extension HistoryView {
    private func sendMail() {
        
    }
    
    
    
    private func evaluateMailAvailable() -> Bool {
        MFMailComposeViewController.canSendMail()
    }
}
