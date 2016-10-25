//
//  CTFScheduleItem.swift
//  Impulse
//
//  Created by James Kizer on 10/14/16.
//  Copyright © 2016 James Kizer. All rights reserved.
//

import UIKit

public enum CTFScheduleItemType {
    
    case sequential // only supports first task
    case random //randomly selects a task to run
    
    init?(name: String?) {
        guard let type = name else { self = .sequential; return }
        switch(type) {
        case "sequential"      : self = .sequential
        case "random"       : self = .random
        default             : self = .sequential
        }
    }
}

class CTFScheduleItem: NSObject {
    
    private var activities: [CTFActivity]!
    var guid: String!
    var title: String!
    var type: CTFScheduleItemType!
    
    override init() {
        super.init()
    }
    
    init?(json: AnyObject) {
        super.init()
        
        guard let tasks = json["tasks"] as? [AnyObject],
            let title = json["scheduleTitle"] as? String,
            let scheduleIdentifier = json["scheduleIdentifier"] as? String,
            let type = CTFScheduleItemType(name: json["activityType"] as? String) else {
                return nil
        }
        
        self.activities = tasks.flatMap { task in
            return CTFActivity(json: task)
        }
        
        self.title = title
        self.guid = scheduleIdentifier
        self.type = type
    }
    
    private func selectActivity() -> CTFActivity? {
        switch(self.type) {
        case .some(.sequential):
            return self.activities.first
            
        case .some(.random):
            return self.activities?.random()
        default:
            return nil
        }
    }
    
    func generateScheduledActivity() -> CTFScheduledActivity? {
        guard let activity = self.selectActivity()
            else {
            return nil
        }
        
        return CTFScheduledActivity(guid: self.guid, title: self.title, activity: activity)
    }
    
    
    

}