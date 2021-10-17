//
//  BaseShowCell.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

protocol BaseShowCell: UITableViewCell {
    func setupWith(model: BaseShowInfoModel)
}
