//
//  TimerControl.swift
//  TimerDemo
//
//  Created by ut-i02 on 22/03/2022.
//

import Foundation

protocol TimerControlDelegate{
    func timerEnd()
    func timerPause()
    func timerContinue()
    func timerRestart()
    
    func timeChange(seconds: Int, timeString: String)
    
}

class TimerControl {
    enum Status {
        case running
        case pause
        case end
    }
    
    private var timer: Timer = Timer()
    private var counterInSecond: Int = 0
    public var delegate: TimerControlDelegate? = nil
    public var timeIntervalInSecond: Double = 1
    public var timerInSecond: Int = 0 {
        didSet{
            refreshTimeString(seconds: timerInSecond - counterInSecond)
            counterInSecond = 0
        }
    }
    
    public var status: Status{
        get{
            if isPlaying{
                return .running
            }else{
                if timerInSecond - counterInSecond > 0{
                    return .pause
                }else {
                    return .end
                }
            }
        }
    }
    
    private var isPlaying = false {
        didSet{
            if isPlaying {
                //Status: Continue
                if let delegate = delegate {
                    delegate.timerContinue()
                }
            }else{
                if timerInSecond - counterInSecond <= 0{
                    //Stagus: End
                    if let delegate = delegate { delegate.timerEnd() }
                }else{
                    //Status: Pause
                    if let delegate = delegate { delegate.timerPause() }
                }
            }
        }
    }
    
    public func pauseTimer(){
        stopTimer()
    }
    
    public func continueTimer(){
        startTimer()
    }
    
    public func restartTimer(){
        counterInSecond = 0
        stopTimer()
        startTimer()
        if let delegate = delegate {
            delegate.timerRestart()
        }
    }
    
    private func stopTimer(){
        timer.invalidate()
        isPlaying = false
    }
    
    private func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: timeIntervalInSecond, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @objc func updateTimer() {
        counterInSecond += 1
        var diff = timerInSecond - counterInSecond
        if diff <= 0{
            diff = 0
            counterInSecond = timerInSecond
            stopTimer()
        }
        refreshTimeString(seconds: diff)
    }
    
    private func refreshTimeString(seconds: Int){
        if let delegate = delegate {
            delegate.timeChange(seconds: seconds, timeString: getTimeString(seconds: seconds))
        }
    }
    
    public func getTimeString(seconds: Int) -> String{
        let time = convert(seconds: seconds)
        
        if time.hours > 0{
            return String(format: "%02d:%02d:%02d", time.hours, time.minutes, time.seconds)
        }else{
            return String(format: "%02d:%02d", time.minutes, time.seconds)
        }
    }
    
    private func convert(seconds: Int) -> (hours:Int, minutes: Int, seconds: Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
