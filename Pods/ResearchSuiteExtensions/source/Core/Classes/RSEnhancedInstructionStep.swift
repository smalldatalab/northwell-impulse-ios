//
//  RSEnhancedInstructionStep.swift
//  Pods
//
//  Created by James Kizer on 7/30/17.
//
//

import UIKit
import ResearchKit

open class RSEnhancedInstructionStep: RSStep {

    override open func stepViewControllerClass() -> AnyClass {
        return RSQuestionViewController.self
    }

}
