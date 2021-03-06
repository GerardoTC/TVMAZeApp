//
//  UIImageView+extensions.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

extension UIImageView {
    func load(url: String, errorClosure: ((Error?) -> Void)? = nil) {
        guard let url = URL(string: url) else {
            errorClosure?(nil)
            return
        }
        DispatchQueue(label: "ImageLoaderQueue").async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.alpha = 0
                        UIView.animate(withDuration: 0.3) {
                            self?.image = image
                            self?.alpha = 1
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    errorClosure?(error)
                }
            }
        }
    }
}
