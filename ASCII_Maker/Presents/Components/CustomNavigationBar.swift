//
//  CustomNavigationBar.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/20/25.
//

import SwiftUI


struct CustomNavigationBar: View {
    let type: NavigationList
    
    let dismiss: () -> Void
    
    let trailingButton: String?
    let trailingAction: (() -> Void)?
    
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Spacer()
                
                Text(type.navigationTitle)
                    .koreanFont(size: 30)
                    .customColor(type.navigationColor)
                
                Spacer()
                
            }
            .overlay(alignment: .leading) {
                Button("<<<") {
                    dismiss()
                }
                .koreanFont(size: 30)
                .customColor(type.navigationColor)
            }
            .overlay(alignment: .trailing) {
                if let trailingButton = trailingButton,
                   let trailingAction = trailingAction
                {
                    Button {
                        trailingAction()
                    } label: {
                        Image(systemName: trailingButton)
                            .font(.system(size: 30))
                            .customColor(type.navigationColor)
                    }
                }
            }
            
            Path { path in
                let width = UIScreen.main.bounds.width
                
                
                path.move(to: .init(x: 0, y: 0))
                path.addLine(to: .init(x: width - 60, y: 0.0))
            }
            .stroke(style: .init(lineWidth: 2, dash: [10, 4]))
            .customColor(type.navigationColor)
            .frame(height: 2)
        }
    }
    
    init(
        type: NavigationList,
        dismiss: @escaping () -> Void,
        trailingButton: String? = nil,
        trailingAction: (() -> Void)? = nil
    ) {
        self.type = type
        self.dismiss = dismiss
        self.trailingButton = trailingButton
        self.trailingAction = trailingAction
    }
    
    
    enum NavigationList {
        case setting
        case history
        case developerInfo
        case result
        
        public var navigationTitle: String {
            switch self {
            case .setting: "설정"
            case .history: "히스토리"
            case .developerInfo: "개발자 정보"
            case .result: "결과"
            }
        }
        
        public var navigationColor: CustomColorModifier.ColorList {
            switch self {
            case .setting, .developerInfo: .secondary
            case .history: .text
            case .result: .primary
            }
        }
    }
}
