//
//  PromptListDelegate.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 26/09/23.
//

import Foundation

protocol PromptListDelegate: AnyObject {
    func didCreateNewPrompt(_ prompt: Prompt)
}
