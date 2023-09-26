//
//  PromptViewModel.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 26/09/23.
//

import Foundation

class PromptViewModel {
    var prompts: [Prompt] = [Prompt(title: "Teste", note: "Ola mundo", phraseList: [])]
    
    func addPrompt(_ idea: Prompt) {
        prompts.append(idea)
    }
    
    func editPrompt(at index: Int, with updatedPrompt: Prompt) {
        prompts[index] = updatedPrompt
    }
    
    func deletePrompt(at index: Int) {
        prompts.remove(at: index)
    }
}
