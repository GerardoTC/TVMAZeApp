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
        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.33) {
                            self?.image = image
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
