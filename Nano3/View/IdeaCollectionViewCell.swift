//
//  IdeaCollectionViewCell.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 25/09/23.
//

import Foundation
import UIKit

class IdeaCollectionViewCell: UICollectionViewCell {
    
    // Properties para exibir informações da ideia
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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cellLayout()
        
        // Adicione subviews à célula
        addSubview(titleLabel)
        addSubview(noteLabel)
        addSubview(imageView)
        
        // Configure as restrições
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            noteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            noteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            noteLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            imageView.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    func cellLayout() {
        self.backgroundColor = UIColor.lightGray
    }
    
    
    // Configure a célula com as informações da ideia
    func configure(with idea: Idea) {
        titleLabel.text = idea.title
        noteLabel.text = idea.note
        if let firstImage = idea.images.first {
            imageView.image = firstImage
        } else {
            imageView.image = nil // Limpe a imagem se não houver imagens
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
