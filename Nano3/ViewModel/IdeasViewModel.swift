//
//  IdeasViewModel.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 25/09/23.
//

import Foundation

class IdeasViewModel {
    var ideas: [Idea] = [Idea(title: "Teste", note: "Ola mundo", images: [])]
    
    func addIdea(_ idea: Idea) {
        ideas.append(idea)
    }
    
    func editIdea(at index: Int, with updatedIdea: Idea) {
        ideas[index] = updatedIdea
    }
    
    func deleteIdea(at index: Int) {
        ideas.remove(at: index)
    }
}
