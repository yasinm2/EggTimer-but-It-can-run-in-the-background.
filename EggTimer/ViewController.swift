import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timer = Timer()
    var totalTime = 0
    var timeRemaining = 0
    
    let softTime = 4
    let mediumTime = 420
    let hardTime = 720
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle
        
        if hardness == "Soft" {
            totalTime = softTime
        } else if hardness == "Medium" {
            totalTime = mediumTime
        } else {
            totalTime = hardTime
        }
        
        timeRemaining = totalTime
        progressBar.progress = 0.0
        startTimer()
    }
    
    func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    
    @objc func updateTimer() {
        if timeRemaining > 0 {
            let progress = Float(totalTime - timeRemaining + 1) / Float(totalTime)
            timeRemaining -= 1
            progressBar.progress = progress
            
            print(progress)
        } else {
            timer.invalidate()
            print("Timer finished")
            label.text = "DONE!"
            playSound(soundName: "alarm_sound")
        }
    }

}
