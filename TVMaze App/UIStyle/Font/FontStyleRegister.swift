//
//  FontStyleRegister.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

class FontStyleRegister {
    static func registerFonts() {
        registerFontWith(filenameString: "Montserrat-Regular.ttf")
        registerFontWith(filenameString: "Montserrat-SemiBold.ttf")
    }
    
    // MARK: - Make custom font bundle register to framework
    
    private static func registerFontWith(filenameString: String) {
        let filenamePath = "\(filenameString)"
        
        let bundle = Bundle.main
        if let pathForResourceString = bundle.path(forResource: filenamePath, ofType: nil), let fontData = NSData(contentsOfFile: pathForResourceString), let dataProvider = CGDataProvider(data: fontData) {
            let fontRef = CGFont(dataProvider)
            var errorRef: Unmanaged<CFError>?
            if CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) == false {
                print("Failed to register font \(filenamePath)- register graphics font failed - this font may have already been registered in the main bundle.")
            } 
        }
    }
}
