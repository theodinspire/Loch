//
//  ViewController.swift
//  Loch
//
//  Created by Eric Cormack on 3/13/18.
//  Copyright © 2018 the Odin Spire. All rights reserved.
//

import UIKit
import UserNotifications

class TimerViewController: LochViewController {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var timerLoop: LoopView!
    
    var timerRunning = false
    var timerState = TimerState.break

    var timer = Timer() //  Empty to avoid optional

    var breakLength: TimeInterval = .minute * 0.5
    var workLength: TimeInterval = .minute * 1
    
    var endTime: Date = Date.distantPast

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

        timerState = timerState == .work ? .break : .work
        timerLoop.animateTimerReset(withNextState: timerState)

        switch timerState {
        case .work:
            startTimer(at: workLength)
        case .break:
            startTimer(at: breakLength)
        default:
            print("Do you even try?")
        }
    }

    func startTimer(at interval: TimeInterval) {
        endTime = Date(timeIntervalSinceNow: interval)
        updateClock()
        setNotification(in: interval)
        timerLoop.animateTimer(over: interval)
        timer = Timer.scheduledTimer(withTimeInterval: .second, repeats: true) { _ in
            self.updateClock()
        }
    }

    func updateClock() {
        let timeLeft = endTime.timeIntervalSinceNow
        
        guard timeLeft >= 0 else {
            DispatchQueue.main.async { self.endTimer() }
            return
        }

        let hours = Int(timeLeft / .hour)
        let minutes = Int((timeLeft.truncatingRemainder(dividingBy: .hour)) / .minute)
        let seconds = Int(timeLeft.truncatingRemainder(dividingBy: .minute))

        DispatchQueue.main.async {
            self.infoLabel.text = hours > 0 ?
                String(format: "%u:%02u:%02u", hours, minutes, seconds) :
                String(format: "%u:%02u", minutes, seconds)
        }
    }

    func setNotification(in interval: TimeInterval) {
        guard State.current.isAuthorizedForNotifications else { return }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let content = UNMutableNotificationContent()
        content.body = timerState == .work ?
            "Great job! Let's take a break." :
        "That was a good break. Let's do some work!"
        content.title = "Loch"

        let request = UNNotificationRequest(identifier: "loch", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            }
        }
    }

    func endTimer() {
        timer.invalidate()
        switch timerState {
        case .break:
            infoLabel.text = "Let's get to work!"
        case .work:
            infoLabel.text = "It's break time!"
        default:
            infoLabel.text = "You've run out of time"
        }
    }
}
