//
//  UIViewController+Style.swift
//  Mytranslator
//
//  Created by Joy on 3/18/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit

enum SpeechStatus {
    case ready
    case recognizing
    case unavailable
}

// MARK: - UI Styling

extension ViewController {
    
    
    func setUI(status: SpeechStatus) {
        switch status {
        case .ready:

            microBtn.backgroundColor = UIColor.gray
            pressto.text = "Tap to Translate"
            topbar.backgroundColor = UIColor.green
            play.image = UIImage(named: "play")
            transilator.image = UIImage(named: "My-translator")
            
        case .recognizing:

            microBtn.backgroundColor = UIColor.red
            pressto.text = "Translating ..."
            topbar.backgroundColor = UIColor.red
            play.image = UIImage(named: "stop")
            transilator.image = UIImage(named: "speaking")
            
        case .unavailable:
            
            microBtn.backgroundColor = UIColor.gray
            pressto.text = "Tap to Translate"
            topbar.backgroundColor = UIColor.green
            play.image = UIImage(named: "play")
            transilator.image = UIImage(named: "My-translator")
            
        }
    }
    
}
