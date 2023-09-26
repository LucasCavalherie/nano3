//
//  PromptDetailViewController.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 26/09/23.
//

import Foundation
import UIKit

class PromptDetailViewController: UIViewController {
    
    var prompt: Prompt? // O prompt a ser exibido
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let noteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0 // Permite várias linhas para a anotação
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Verifique se há uma ideia para exibir
        guard let prompt = prompt else {
            // Lide com o caso em que a ideia é nula ou inválida
            // Você pode exibir uma mensagem de erro ou fazer o que for apropriado para o seu aplicativo.
            return
        }
        
        // Adicione subviews à vista
        view.addSubview(titleLabel)
        view.addSubview(noteLabel)
        
        // Configure as restrições
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            noteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            noteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // Preencha as informações da ideia na tela
        titleLabel.text = prompt.title
        noteLabel.text = prompt.note
        
        // Configurar a barra de navegação
        navigationItem.title = "Detalhes do prompt"
    }
}
