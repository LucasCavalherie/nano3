//
//  Prompt.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 26/09/23.
//

import Foundation
import UIKit

class Prompt {
    var title: String
    var note: String
    var phraseList: [Phrase]
    
    init(title: String, note: String, phraseList: [Phrase]) {
        self.title = title
        self.note = note
        self.phraseList = phraseList
    }
}
