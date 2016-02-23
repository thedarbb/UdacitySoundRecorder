//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Dustin Sappier on 2016-02-22.
//  Copyright © 2016 bsc. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        
        do {
            let sound = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
            audioPlayer = sound
            sound.stop()
            sound.enableRate = true
            sound.rate = 0.25
            sound.play()
        } catch {
            print("couldn't load file")
        }
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        
        do {
            let sound = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
            audioPlayer = sound
            sound.stop()
            sound.enableRate = true
            sound.rate = 2
            sound.play()
        } catch {
            print("couldn't load file")
        }
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func playDarthVader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    //helper function to stop the audio
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
