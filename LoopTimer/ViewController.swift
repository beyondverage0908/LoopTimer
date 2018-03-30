//
//  ViewController.swift
//  LoopTimer
//
//  Created by pingjun lin on 2018/3/24.
//  Copyright © 2018年 MK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var singleTimer: LoopTimer? = nil
    
    var repeatingTimer: LoopTimer!
    
    var repeaticTimer: LoopTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - single timer
        
        // single rimer
        singleTimer = LoopTimer(interval: .seconds(2)) { (timer) in
                print("start single timer that run single task")
        }
        singleTimer?.start()
        
        
        // MARK: - repeating timer
        
        // start repeating timer with 2 second and leeway 0 seconds on main queue
        repeatingTimer = LoopTimer(interval: .seconds(2), repeating: true, leeway: .seconds(0), queue: .main) { (timer) in
            print("loop timer interval with 2 second")
        }
        repeatingTimer.start()
        
        
        // MARK: - repeatic timer
        
        // you can reset timer interval
        
        repeaticTimer = LoopTimer(interval: .seconds(2), repeating: true, leeway: .seconds(0), queue: .main) { (timer) in
            print("repeatic timer")
        }
        repeaticTimer.start()
        
        repeaticTimer = LoopTimer.repeatTimer(interval: .seconds(5), repeating: true, leeway: .seconds(0), queue: .main, handler: { (timer) in
            print("reset timer interval to 5 second")
        })
        repeaticTimer.start()
        
        
        // MARK: - timer other operation
        
        let timer = LoopTimer(interval: .seconds(2), repeating: true, leeway: .seconds(0), queue: .main) { (timer) in
            print("timer task")
        }
        timer.start()
        
        // you can pause timer
        timer.pause()
        // you can active timer
        timer.active()
        
        // MARK: - dynamically changing handler
        timer.repeatHandler { (timer) in
            print("repeatHandler")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }


}

