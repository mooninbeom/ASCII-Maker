//
//  EmailView.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/20/25.
//

import SwiftUI
import MessageUI


struct EmailView: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        let body =
            """
            <html>
            <body>
            <h1>문의 내용을 작성해주세요!</h1>
            <br>
            <br>
            <p>=============<br>
            기기 : \(UIDevice.current.modelName)<br>
            OS : \(UIDevice.current.systemVersion)<br>
            앱 버전 : \(Bundle.main.appVersion)<br>
            빌드 넘버 : \(Bundle.main.buildNumber)<br>
            =============</p>
            </body>
            </html>
            """
        
        vc.setToRecipients(["dlsqja567@naver.com"])
        vc.setSubject("[ASCII:llustrator] 문의 메일")
        vc.setMessageBody(body, isHTML: true)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        .init(parent: self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: EmailView
        
        init(parent: EmailView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: (any Error)?) {
            self.parent.dismiss()
        }
    }
}
