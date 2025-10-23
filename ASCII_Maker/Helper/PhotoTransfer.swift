//
//  PhotoTransfer.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/20/25.
//

import SwiftUI


struct PhotoTransfer: Transferable {
    let image: UIImage
    
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let image = UIImage(data: data) else {
                throw NSError(domain: "Invalid image", code: 0)
            }
            return Self(image: image)
        }
    }
}
