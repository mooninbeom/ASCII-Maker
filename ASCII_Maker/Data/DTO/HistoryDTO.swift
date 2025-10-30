//
//  HistoryDTO.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/29/25.
//

import UIKit



struct HistoryDTO: Identifiable {
    public let id: UUID
    public let image: UIImage
    public let pixels: String
    public let result: String
    public let timestamp: Date
}
