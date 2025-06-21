//
//  wcWidget.swift
//  World Clocks
//
//  Created by Devin on 21.06.25.
//  
//

import Foundation
import AppKit
import PockKit

class wcWidget: PKWidget {
    
    static var identifier: String = "widgetdock.World-Clocks"
    var customizationLabel: String = "World Clocks"
    var view: NSView!
    
    required init() {
        self.view = PKButton(title: "World Clocks", target: self, action: #selector(printMessage))
    }
    
    @objc private func printMessage() {
        NSLog("[wcWidget]: Hello, World!")
    }
    
}
