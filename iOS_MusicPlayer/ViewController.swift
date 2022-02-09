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
    @IBOutlet weak var playTime : UILabel!
    @IBOutlet weak var playAllTime : UILabel!
    @IBOutlet weak var playSlider : UISlider!
    
    var url = Bundle.main.url(forResource: "sound", withExtension: "mp3")
    var audioPlayer : AVAudioPlayer?
    var playState : Bool?
    var playDuration : Double?
    var playingAllTime:String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlayer()
        // Do any additional setup after loading the view.
    }
    
    func loadPlayer (){
        // AVAudioPlayer 에 url 넣으려면 do catch 문 안에서 try throw 를 사용해야한다
   
        
        if let urlFile = url {
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: urlFile)
                print("ready to play")
                audioPlayer?.play()
                playBtn?.isSelected = true
                playDuration = audioPlayer?.duration
                guard let durationTime = playDuration else { return }
                playingAllTime = showPlayingSecond(durationTime)
                playAllTime.text = playingAllTime
                
               // playCurrent = audioPlayer?.currentTime
                
//                playCurrent = audioPlayer?.currentTime
//                guard let currentTime = playCurrent else { return }
//                playingCurrentTime = showPlayingSecond(currentTime)
//                playTime.text = playingCurrentTime
   
            }catch let error as NSError{
                print("i made \(error)")
            }
        }
        
       

    }
    
    func showPlayingSecond (_ durations : Double) -> String{
        let min = Int(durations / 60)
        let sec  = Int(durations)
        let playingTime: String = "\(String(format: "%02d", min)):\(String(format: "%02d", sec))"
        return playingTime
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


