//
//  UILoadingView.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import UIKit

class UILoadingView: UIView {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
    }
    
    func setupSubViews() {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        let view = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.startAnimating()
        view.color = BaseColorPalette.tintColor.color
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(blurView, at: 0)
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
