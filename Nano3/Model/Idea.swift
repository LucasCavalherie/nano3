//
//  Idea.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 25/09/23.
//

import Foundation
import UIKit

class Idea {
    var title: String
    var note: String
    var images: [UIImage]
    
    init(title: String, note: String, images: [UIImage]) {
        self.title = title
        self.note = note
        self.images = images
    }
}
