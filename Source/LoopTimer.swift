//
//  LoopTimer.swift
//
//  Created by pingjun lin on 2017/6/21.
//  Copyright © 2018年 MK. All rights reserved.
//

import Foundation

public class LoopTimer {
    
    private let internalTimer: DispatchSourceTimer
    
    public typealias LoopTimerHander = (LoopTimer) -> Void
    
    private var loopHandler: LoopTimerHander
    
    private var interval: DispatchTimeInterval
    
    private var repeating: Bool
    
    private var leeway: DispatchTimeInterval
    
    private var isRunning: Bool = false
    
    private var isDestory: Bool = false
    
    public init(interval: DispatchTimeInterval, repeating: Bool = false, leeway: DispatchTimeInterval = .seconds(0), queue: DispatchQueue = .main, handler: @escaping LoopTimerHander) {
        
        self.interval = interval
        self.repeating = repeating
        self.leeway = leeway
        self.loopHandler = handler
        
        self.internalTimer = DispatchSource.makeTimerSource(queue: queue)
        internalTimer.setEventHandler { [weak self] in
            if let strongSelf = self {
                handler(strongSelf)
            }
        }
        
        if repeating {
            internalTimer.schedule(deadline: .now() + interval, repeating: interval, leeway: leeway)
        } else {
            internalTimer.schedule(deadline: .now() + interval, leeway: leeway)
        }
    }
    
    deinit {
        if !self.isRunning {
            internalTimer.resume()
        }
    }
    
    // MARK: - Switch Option Manager
    
    public func start() {
        if !isRunning && !isDestory {
            internalTimer.resume()
            isRunning = true
        }
    }
    
    public func active() {
        if !isRunning && !isDestory {
            internalTimer.resume()
            isRunning = true
        }
    }
    
    public func pause() {
        if isRunning && isDestory {
            internalTimer.suspend()
            isRunning = false
        }
    }
    
    public func destroy() {
        internalTimer.cancel()
        isDestory = true
    }
    
    
    
    public static func repeatTimer(interval: DispatchTimeInterval, repeating: Bool = false, leeway: DispatchTimeInterval = .seconds(0), queue: DispatchQueue = .main, handler: @escaping LoopTimerHander) -> LoopTimer {
        return LoopTimer(interval: interval, repeating: repeating, leeway: leeway, queue: queue, handler: handler);
    }
    
    public func rescheduleRepeating(interval: DispatchTimeInterval) {
        internalTimer.schedule(deadline: .now() + interval, repeating: interval, leeway: leeway)
    }
    
    public func repeatHandler(handler: @escaping LoopTimerHander) {
        internalTimer.setEventHandler { [weak self] in
            if let strongSelf = self {
                handler(strongSelf)
            }
        }
        self.loopHandler = handler
    }
}
