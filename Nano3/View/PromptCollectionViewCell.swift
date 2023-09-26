//
//  PromptCollectionViewCell.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 26/09/23.
//

import Foundation
import UIKit

class PromptCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0 // Permite várias linhas para a anotação
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellLayout()
        
        // Adicione subviews à célula
        addSubview(titleLabel)
        addSubview(noteLabel)
        
        // Configure as restrições
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            noteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            noteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            noteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    
    func cellLayout() {
        self.backgroundColor = UIColor.lightGray
    }
    
    
    // Configure a célula com as informações do prompt
    func configure(with prompt: Prompt) {
        titleLabel.text = prompt.title
        noteLabel.text = prompt.note
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
