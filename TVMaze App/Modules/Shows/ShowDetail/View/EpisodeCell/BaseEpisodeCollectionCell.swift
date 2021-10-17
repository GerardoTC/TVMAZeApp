//
//  BaseEpisodeCollectionCell.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 17/10/21.
//

import UIKit

protocol BaseEpisodeCollectionCell: UICollectionViewCell {
    func setupWith(image: String, name: String)
}
