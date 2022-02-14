//
//  ViewController.swift
//  iOS_MusicPlayer
//
//  Created by Jooeun Kim on 2022/02/08.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playBtn : UIButton!
    @IBOutlet weak var playCurrentTime : UILabel!
    @IBOutlet weak var playAllTime : UILabel!
    @IBOutlet weak var playSlider : UISlider!
    
    var url = Bundle.main.url(forResource: "sound", withExtension: "mp3")
    var audioPlayer : AVAudioPlayer?
    var playState : Bool?
    var playCurrent : Double?
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlayer()
    }
    
    func loadPlayer (){
        // AVAudioPlayer 에 url 넣으려면 do catch 문 안에서 try throw 를 사용해야한다
        if let urlFile = url {
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: urlFile)
            }catch let error as NSError{
                print("i made \(error)")
            }
        }
    
        playBtn?.isSelected = true
        playAllTime.text =  secondsToString(sec : audioPlayer?.duration)
        audioPlayer?.play()
        
        if audioPlayer?.isPlaying  == true{
            timer =  Timer.scheduledTimer(withTimeInterval: 0, repeats: true, block:{ (_)  in
                self.playCurrentTime.text = self.secondsToString(sec : self.audioPlayer?.currentTime)
                if self.playCurrentTime.text == self.playAllTime.text{
                    self.playBtn?.isSelected = false
                }
            })
        }
    }
    

    func secondsToString(sec: TimeInterval?) -> String {
        guard let Time = sec else { return "00:00" }
        let totalSeconds = Int(Time)
        let min = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
    }
    
    
    @IBAction func touchPlayBtn(_ sender: UIButton) -> Void {
        print("touch playBtn")
       
        sender.isSelected = !sender.isSelected
        if !sender.isSelected  {
            audioPlayer?.pause()
        }else{
            audioPlayer?.play()
        }
    }
    
    
    @IBAction func moveSlider(_ sender: UISlider) {
        print("change slider")
    }
    
}


