//
//  ZoomableScrollView.swift
//  ASCII_Maker
//
//  Created by 문인범 on 10/21/25.
//

import SwiftUI
import Combine


struct ZoomableScrollView: UIViewControllerRepresentable {
    let text: String
    
    func makeUIViewController(context: Context) -> ZoomableScrollViewController {
        .init(text: text)
    }
    
    func updateUIViewController(_ uiViewController: ZoomableScrollViewController, context: Context) {
        
    }
}



class ZoomableScrollViewController: UIViewController {
    let text: String
    
    let imageSavePublisher = NotificationCenter.default.publisher(for: .saveASCIIImage)
    private var cancellables: Set<AnyCancellable> = []
    
    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bouncesZoom = true
        view.backgroundColor = UIColor(hex: "#090B30")
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "JetBrainsMono-Light", size: 5)
        label.textColor = UIColor(hex: "#EA2264")
        label.numberOfLines = 0
        return label
    }()
    
    
    override func viewDidLoad() {
        setUp()
        binding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.label.layoutIfNeeded()
        let widthScale = scrollView.bounds.size.width / label.bounds.size.width
        let heightScale = scrollView.bounds.size.height / label.bounds.size.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 20
        scrollView.zoomScale = minScale
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.cancellables.forEach { $0.cancel() }
        super.viewDidDisappear(animated)
    }
}



extension ZoomableScrollViewController: UIScrollViewDelegate {
    private func setUp() {
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        label.text = self.text
        scrollView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: scrollView.topAnchor),
            label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
    }
    
    private func binding() {
        self.imageSavePublisher
            .sink { [weak self] _ in
                if let self = self {
                    saveImage(label: self.label)
                }
            }
            .store(in: &self.cancellables)
    }
    
    private func saveImage(label: UILabel) {
        let renderer = UIGraphicsImageRenderer(bounds: label.bounds)
        let image = renderer.image { context in
            label.drawHierarchy(in: label.bounds, afterScreenUpdates: true)
        }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.label
    }
}
