//
//  BaseEpisodeCollectionCellMock.swift
//  TVMaze AppTests
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

@testable import TVMaze_App
import UIKit
class BaseEpisodeCollectionCellMock: UICollectionViewCell, BaseEpisodeCollectionCell {
    var setupWithCalled = false
    func setupWith(image: String, name: String) {
        setupWithCalled = true
    }
}
