//
//  ViewController.swift
//  TimerDemo
//
//  Created by ut-i02 on 22/03/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnRestart: UIButton!
    @IBOutlet weak var btnPauseContinue: UIButton!
    
    private let timerControl: TimerControl = TimerControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timerControl.delegate = self
        timerControl.timerInSecond = 20
    }

    @IBAction func btnPauseTouchUpInside(_ sender: Any) {
        switch timerControl.status {
        case .running:
            timerControl.pauseTimer()
        case .pause:
            timerControl.continueTimer()
        default://end
            return
        }
    }
    
    @IBAction func btnRestartTouchUpInside(_ sender: Any) {
        timerControl.restartTimer()
    }
}

extension ViewController: TimerControlDelegate{
    func timerEnd() {
        btnPauseContinue.setTitle("Continue", for: .normal)
        btnPauseContinue.isEnabled = false
    }
    
    func timerPause() {
        btnPauseContinue.setTitle("Continue", for: .normal)
        btnPauseContinue.isEnabled = true
    }
    
    func timerContinue() {
        btnPauseContinue.setTitle("Pause", for: .normal)
        btnRestart.setTitle("Restart", for: .normal)
        btnPauseContinue.isEnabled = true
    }
    
    func timerRestart() {
        btnRestart.setTitle("Restart", for: .normal)
    }
    
    func timeChange(seconds: Int, timeString: String) {
        lblTimer.text = timeString
    }
    
}

