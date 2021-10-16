//
//  FontStyle.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

enum FontStyle {
    var font: UIFont {
        switch self {
        case .titleL:
            return UIFont.font(name: "Montserrat-SemiBold", size: 28, maximumSize: 56)
        case .titleM:
            return UIFont.font(name: "Montserrat-SemiBold", size: 24, maximumSize: 48)
        case .titleS:
            return UIFont.font(name: "Montserrat-SemiBold", size: 20, maximumSize: 40)
        case .bodyL:
            return UIFont.font(name: "Montserrat-Regular", size: 18, maximumSize: 36)
        case .bodyM:
            return UIFont.font(name: "Montserrat-Regular", size: 16, maximumSize: 32)
        case .bodyS:
            return UIFont.font(name: "Montserrat-Regular", size: 14, maximumSize: 28)
        }
    }
    
    case titleL
    case titleM
    case titleS
    case bodyL
    case bodyM
    case bodyS
}
