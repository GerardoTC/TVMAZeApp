//
//  EpisodesFlowLayoutCollection.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 17/10/21.
//

import UIKit

class EpisodesFlowLayoutCollection: UICollectionViewFlowLayout {
    
    override func prepare() {
        let space:CGFloat = 15
        minimumInteritemSpacing = space
        minimumLineSpacing = space
        itemSize = CGSize(width: 200, height: 240)
        collectionView?.contentInset = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        scrollDirection = .horizontal
        super.prepare()
        
    }
}
