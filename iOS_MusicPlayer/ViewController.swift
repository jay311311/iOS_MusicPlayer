//
//  ViewController.swift
//  iOS_MusicPlayer
//
//  Created by Jooeun Kim on 2022/02/08.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playBtn : UIButton?
    @IBOutlet weak var playTime : UILabel?
    @IBOutlet weak var playAllTime : UILabel?
    @IBOutlet weak var playSlider : UISlider?
    
    var url : URL?
    var audioPlayer : AVAudioPlayer?
    var playState : Bool?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadPlayer()
        
        // Do any additional setup after loading the view.
    }
    
    func loadPlayer (){
        // AVAudioPlayer 에 url 넣으려면 do catch 문 안에서 try throw 를 사용해야한다
        url = Bundle.main.url(forResource: "sound", withExtension: "mp3")
        
        if let urlFile = url {
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: urlFile)
                print("ready to play")
                audioPlayer?.play()
                playBtn?.isSelected = true
            }catch let error as NSError{
                print("i made \(error)")
            }
        }
    }
    
    
    @IBAction func touchPlayBtn(_ sender: UIButton) -> Void {
        print("touch playBtn")
        guard let playState = audioPlayer?.isPlaying  else { return }
        
        if playState  {
            audioPlayer?.pause()
            playBtn?.isSelected = false
        }else{
            audioPlayer?.play()
            playBtn?.isSelected = true
        }
        
        
    }
    
    
    @IBAction func moveSlider(_ sender: UISlider) {
        print("change slider")
    }
    
}

