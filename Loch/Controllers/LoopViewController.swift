//
//  LoopViewController.swift
//  Loch
//
//  Created by Eric Cormack on 3/16/18.
//  Copyright © 2018 the Odin Spire. All rights reserved.
//

import UIKit

class LoopViewController: UIViewController {
    @IBOutlet weak var loopView: LoopView!
    
    var state = TimerState.Work
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        loopView.animateTimer(over: 10)
    }
    
    @IBAction func reset(_ sender: Any) {
        state = state == .Work ? .Break : .Work
        loopView.animateTimerReset(withNextState: state)
    }
    
    @IBAction func start(_ sender: Any) {
        loopView.animateTimer(over: 2)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
