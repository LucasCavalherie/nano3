//
//  IdeasListDelegate.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 25/09/23.
//

import Foundation

protocol IdeasListDelegate: AnyObject {
    func didCreateNewIdea(_ idea: Idea)
}
