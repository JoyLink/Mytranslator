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
    @IBOutlet weak var microBtn: CircleButton!
    
    var audioPlay: AVAudioPlayer!
    
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    var status = SpeechStatus.ready {
        didSet {
            self.setUI(status: status)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        
        switch SFSpeechRecognizer.authorizationStatus() {
        case .notDetermined:
            askSpeechPermission()
        case .authorized:
            self.status = .ready
        case .denied, .restricted:
            self.status = .unavailable
        }
       
    }
    
    func startRecording() {
        // Setup audio engine and speech recognizer
        guard let node = audioEngine.inputNode else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        
        // Prepare and start recording
        audioEngine.prepare()
        do {
            try audioEngine.start()
            self.status = .recognizing
        } catch {
            return print(error)
        }
        
        // Analyze the speech
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
//                self.flightTextView.text = result.bestTranscription.formattedString
//                self.searchFlight(number: result.bestTranscription.formattedString)
                print(result.bestTranscription.formattedString)
                self.textfield.text = result.bestTranscription.formattedString
            } else if let error = error {
                print(error)
            }
        })
    }
    

    func askSpeechPermission() {
        SFSpeechRecognizer.requestAuthorization { status in
            OperationQueue.main.addOperation {
                switch status {
                case .authorized:
                    self.status = .ready
                default:
                    self.status = .unavailable
                }
            }
        }
    }
    
    
    func cancelRecording() {
        audioEngine.stop()
        if let node = audioEngine.inputNode {
            node.removeTap(onBus: 0)
        }
        recognitionTask?.cancel()
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
//        requestSpeechAuth()
        switch status {
        case .ready:
            startRecording()
            status = .recognizing
        case .recognizing:
            cancelRecording()
            status = .ready
        default:
            break
        }
        
    }
    
    

}

