//
//  ViewController.swift
//  Mytranslator
//
//  Created by Joy on 3/17/17.
//  Copyright © 2017 me. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{

    @IBOutlet weak var textfield: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var audioPlay: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
       
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        spinner.stopAnimating()
        spinner.isHidden = true
        
    }

    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authoStatus in
            if authoStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a"){
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlay = sound
                        self.audioPlay.delegate = self
                        sound.play()
                    } catch {
                        print("Error")
                    }
                    
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There was a erro! \(error)")
                        } else {
                            self.textfield.text = result?.bestTranscription.formattedString
                            
                        }
                    }
                }
                
            }
        }
        
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        requestSpeechAuth()
        
    }
    
    

}

