//
//  CTFGoNoGoStepGenerator.swift
//  Impulse
//
//  Created by James Kizer on 12/20/16.
//  Copyright © 2016 James Kizer. All rights reserved.
//

import UIKit
import Bricoleur
import ResearchKit
import Gloss


class CTFGoNoGoStepGenerator: BCLBaseStepGenerator {
    
    public init(){}
    
    let _supportedTypes = [
        "CTFGoNoGoActiveStep"
    ]
    
    public var supportedTypes: [String]! {
        return self._supportedTypes
    }
    
    open func generateStep(type: String, jsonObject: JSON, helper: BCLStepBuilderHelper) -> ORKStep? {
        
        guard let customStepDescriptor = helper.getCustomStepDescriptor(forJsonObject: jsonObject),
            let parameters = customStepDescriptor.parameters,
            let goNoGoStepParams = CTFGoNoGoStepParamsDescriptor(json: parameters ) else {
                return nil
        }
        
        let stepParams = CTFGoNoGoStepParameters(waitTime: goNoGoStepParams.waitTime, crossTime: goNoGoStepParams.crossTime, blankTime: goNoGoStepParams.blankTime, cueTimeOptions: goNoGoStepParams.cueTimeOptions, fillTime: goNoGoStepParams.fillTime, goCueTargetProb: goNoGoStepParams.goCueTargetProb, noGoCueTargetProb: goNoGoStepParams.noGoCueTargetProb, goCueProb: goNoGoStepParams.goCueProb, numTrials: goNoGoStepParams.numTrials)
        
        let step = CTFGoNoGoStep(identifier: customStepDescriptor.identifier)
        step.goNoGoParams = stepParams
        step.isOptional = customStepDescriptor.optional
        return step
    }
    
    open func processStepResult(type: String,
                                jsonObject: JsonObject,
                                result: ORKStepResult,
                                helper: BCLStepBuilderHelper) -> JSON? {
        return nil
    }

}
