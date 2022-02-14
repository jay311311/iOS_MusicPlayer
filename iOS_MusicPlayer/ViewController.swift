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
    var isSeeking :Bool! = false
    
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
    // 첫화면
        playBtn?.isSelected = true
        playAllTime.text =  secondsToString(sec : audioPlayer?.duration)
        audioPlayer?.play()
        
        // 재생중에따른 현재 시간 보여주는 기능
        if audioPlayer?.isPlaying  == true {
            timer =  Timer.scheduledTimer(withTimeInterval: 0, repeats: true, block:{ (_)  in
                if self.isSeeking == false{
                self.playCurrentTime.text = self.secondsToString(sec : self.audioPlayer?.currentTime)
                self.playSlider.value = Float(self.audioPlayer!.currentTime) / Float(self.audioPlayer!.duration)
                if self.playCurrentTime.text == self.playAllTime.text{
                    self.playBtn?.isSelected = false
                }
                }
            })
        }
    }
    
// timeInteval 형식을 string 으로 변경
    func secondsToString(sec: TimeInterval?) -> String {
        guard let Time = sec else { return "00:00" }
        let totalSeconds = Int(Time)
        let min = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
    }
    
    // 버튼에 클릭에따른 음악 재생 멈춤
    @IBAction func touchPlayBtn(_ sender: UIButton) -> Void {
        sender.isSelected = !sender.isSelected
        if !sender.isSelected  {
            audioPlayer?.pause()
        }else{
            audioPlayer?.play()
        }
    }
    
    //슬라이드바 이동중에는 timer update일시 정지하는 기능
    @IBAction func dragStartSlider(_ sender: Any)  {
        isSeeking = true
    }
    
    @IBAction func dragEndSlider(_ sender: Any) {
        isSeeking = false
      
    }
    
    // 슬라이드바 이동된 거리만큼 현재 재생 시간 변경
    @IBAction func moveSlider(_ sender: UISlider) {
        let position = playSlider.value * Float(audioPlayer!.duration)
        let time =  TimeInterval(position)
        audioPlayer?.prepareToPlay()
        audioPlayer?.play(atTime: time)
        audioPlayer?.currentTime = time
        
    }
    
}


