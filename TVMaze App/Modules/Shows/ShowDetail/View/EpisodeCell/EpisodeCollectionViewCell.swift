//
//  EpisodeCollectionViewCell.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 17/10/21.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell, BaseEpisodeCollectionCell {
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeName: UILabel!
    func setupWith(image: String, name: String) {
        self.layer.cornerRadius = 8
        self.backgroundColor = BaseColorPalette.bgColor.color
        episodeName.setFont(.bodyS)
        episodeImage.contentMode = .scaleAspectFill
        episodeName.text = name
        episodeImage.image = nil
        episodeImage.load(url: image)
    }
}
