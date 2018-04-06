//
//  ViewController.swift
//  Loch
//
//  Created by Eric Cormack on 3/13/18.
//  Copyright © 2018 the Odin Spire. All rights reserved.
//

import UIKit

class TimerViewController: LochViewController {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var timerLoop: LoopView!
    
    var timerRunning = false
    var timerAcknowledged = true
    var timerState = TimerState.Work

    var timer = Timer() //  Empty to avoid optional
    var timeLeft = 0.0

    let second = 1.0
    let minute = 60.0
    let hour = 3600.0

    var breakLength = 30.0
    var workLength = 120.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func userDidTapScreen(_ sender: UITapGestureRecognizer) {
        guard !timerRunning else { return }
        
        guard timerAcknowledged else {
            timerAcknowledged = true
            timerState = timerState == .Work ? .Break : .Work
            timerLoop.animateTimerReset(withNextState: timerState)
            return
        }

        switch timerState {
        case .Work:
//            view.backgroundColor = UIColor.red
            startTimer(at: workLength)
        case .Break:
//            view.backgroundColor = UIColor.green
            startTimer(at: breakLength)
        default:
            print("Do you even try?")
        }
    }

    func startTimer(at interval: TimeInterval) {
        timeLeft = interval
        updateClock()
        timerLoop.animateTimer(over: interval)
        timer = Timer.scheduledTimer(withTimeInterval: second, repeats: true) { _ in
            self.updateClock()
        }
    }

    func updateClock() {
        timeLeft -= 1

        guard timeLeft >= 0 else {
            DispatchQueue.main.async { self.endTimer() }
            return
        }

        let hours = Int(timeLeft / hour)
        let minutes = Int((timeLeft.truncatingRemainder(dividingBy: hour)) / minute)
        let seconds = Int(timeLeft.truncatingRemainder(dividingBy: minute))

        DispatchQueue.main.async {
            self.infoLabel.text = hours > 0 ?
                String(format: "%u:%02u:%02u", hours, minutes, seconds) :
                String(format: "%u:%02u", minutes, seconds)
        }
    }

    func endTimer() {
        timerAcknowledged = false
        timer.invalidate()
        switch timerState {
        case .Break:
            infoLabel.text = "Let's get to work!"
        case .Work:
            infoLabel.text = "It's break time!"
        default:
            infoLabel.text = "You've run out of time"
        }
    }
}
