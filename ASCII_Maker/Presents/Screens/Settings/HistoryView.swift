//
//  HistoryView.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/17/25.
//

import SwiftUI
import MessageUI



struct HistoryView: View {
    @State private var histories: [HistoryDTO] = []
    
    @Binding var mainViewModel: MainViewModel
    
    private let colorList: [CustomColorModifier.ColorList] = [.text, .primary, .secondary]
    
    var body: some View {
        VStack {
            CustomNavigationBar(type: .history) {
                mainViewModel.screen = .setting
            } trailingButton: { EmptyView() }
            .padding(.top, 30)
            
            ScrollView(.vertical) {
                ForEach(Array(self.histories.enumerated()), id: \.0) { index, history in
                    HistoryCell(
                        history: history,
                        color: colorList[index%3]
                    )
                }
            }
        }
        .koreanFont(size: 30)
        .onAppear {
            histories = fetchHistory()
        }
    }
}


struct HistoryCell: View {
    let history: HistoryDTO
    let color: CustomColorModifier.ColorList
    
    var body: some View {
        VStack {
            Image(uiImage: history.image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
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
    private func fetchHistory() -> [HistoryDTO] {
        let results = CoreDataManager.shared.fetchHistory()
        return results
    }
    
    private func evaluateMailAvailable() -> Bool {
        MFMailComposeViewController.canSendMail()
    }
}
