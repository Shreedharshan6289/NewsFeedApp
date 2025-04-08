//
//  ActivityIndicator.swift
//  QuixxiWeather
//
//  Created by Apple on 05/02/25.
//

import Foundation
import UIKit
import ImageIO

class GIFLoaderView: UIView {
    
    static let shared = GIFLoaderView() // Singleton instance
    
    let imageView = UIImageView()
    let messageLabel = UILabel()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        loadGif(name: "loader")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        messageLabel.textColor = .white
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func start(message: String? = nil) {
        messageLabel.text = message
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            keyWindow.addSubview(self)
        }
    }
    
    func stop() {
        removeFromSuperview()
    }
    
    func loadGif(name: String) {
        guard let asset = NSDataAsset(name: name) else { return }
        guard let source = CGImageSourceCreateWithData(asset.data as CFData, nil) else { return }
        
        var images: [UIImage] = []
        let frameCount = CGImageSourceGetCount(source)
        
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
        }
        
        imageView.animationImages = images
        imageView.animationDuration = Double(images.count) / 10.0
        imageView.startAnimating()
    }
}
