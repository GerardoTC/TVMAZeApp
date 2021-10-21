//
//  TextDebouncer.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import Foundation

typealias ClosureHandler = (String?) -> Void

class TextDebouncer: TextDebouncerProtocol {
    
    var closure: ClosureHandler?
    var timeInterval: TimeInterval
    var timer: Timer?
    private(set) var currentText: String = String()
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    func restarInterval(with text: String) {
        currentText = text
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false, block: { [weak self] timer in
            self?.closure?(self?.currentText)
        })
    }
}

protocol TextDebouncerProtocol {
    var closure: ClosureHandler? {get set}
    func restarInterval(with text: String)
}
