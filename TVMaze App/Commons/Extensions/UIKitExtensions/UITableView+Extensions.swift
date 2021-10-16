//
//  UITableView+Extensions.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

extension UITableView {
    func register(nib name: String, bundle: Bundle = .main) {
        register(UINib(nibName: name, bundle: bundle),
                 forCellReuseIdentifier: name)
    }
}
