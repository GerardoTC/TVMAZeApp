//
//  ShowTableViewCell.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

class ShowTableViewCell: UITableViewCell, BaseShowCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var scorelabel: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    func setupWith(model: BaseShowInfoModel) {
        posterImage.image = nil
        posterImage.backgroundColor = BaseColorPalette.bgColorSecondary.color
        posterImage.load(url: model.show.image?.medium ?? "")
        showTitle.setFont(.titleS)
        showTitle.text = model.show.name
        posterImage.contentMode = .scaleAspectFill
        if let summary = model.show.summary {
            self.summary.setFont(.bodyS)
            self.summary.text = summary.htmlToString
        }
        guard let score = model.score else {
            scorelabel.text = ""
            return
        }
        scorelabel.setFont(.bodyS)
        scorelabel.text = "shows.search.score".localized + "\(String(format: "%.2f", score * 5)) 🌟"
    }
}
