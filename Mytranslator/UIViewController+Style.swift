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
            spinner.stopAnimating()
            spinner.isHidden = true
            microBtn.backgroundColor = UIColor.gray
            pressto.text = "Tap to Translate"
            topbar.backgroundColor = UIColor.green
            
            
        case .recognizing:
            spinner.startAnimating()
            spinner.isHidden = false
            microBtn.backgroundColor = UIColor.red
            pressto.text = "Translating ..."
            topbar.backgroundColor = UIColor.red
            
            
        case .unavailable:
            spinner.stopAnimating()
            spinner.isHidden = true
            microBtn.backgroundColor = UIColor.gray
            pressto.text = "Tap to Translate"
            topbar.backgroundColor = UIColor.green
            
        }
    }
    
}
