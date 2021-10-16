//
//  StoryBoarded.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//


import UIKit

protocol Storyboarded {
    static func create(from storyboard: Storyboards) -> Self?
}

extension Storyboarded where Self: UIViewController {
    static func create(from storyboard: Storyboards) -> Self? {
        let fullName = NSStringFromClass(self)
        guard let className = fullName.components(separatedBy: ".").last else { return nil }
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as? Self
    }
}
