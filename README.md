# Looptimer - Introduction



## Looptimer feature and compare with NSTimer

1. Independent of NSRunLoop
2. No retain cycle
3. Support dynamically changing timer interval
4. Support closure synax
5. Support GCD queue


## Usage

### single timer


	// single timer
	
	// timer needed by maintain self, when self to nil then timer to nil
   	self.singleTimer = LoopTimer(interval: .seconds(2)) { (timer) in
   		print("start single timer that run single task")
   	}
  	singleTimer?.start()
  	
  	
### repeating timer
  	
  	// repeating timer
  	self.repeatingTimer = LoopTimer(interval: .seconds(2), repeating: true, leeway: .seconds(0), queue: .main) { (timer) in
       print("loop timer interval with 2 second")
   	}
   	self.repeatingTimer.start()


## dynamically changing timer interval 


	let repeaticTimer = LoopTimer(interval: .seconds(2), repeating: true, leeway: .seconds(0), queue: .main) { (timer) in
        print("repeatic timer interval with 2 second")
    }
    repeaticTimer.start()
    
    func speedUp() {
    	repeaticTimer = LoopTimer.repeatTimer(interval: .seconds(5), repeating: true, leeway: .seconds(0), queue: .main, handler: { (timer) in
        	print("reset timer interval speed up to 5 second")
    	})
    	repeaticTimer.start()
    }
    
## dynamically changing timer handler

	timer.repeatHandler { (timer) in
        print("repeatHandler")
	} 

## other operation 

	// timer pause
	timer.pause()
	
	// timer pause then active timer
	timer.active()
        
    

