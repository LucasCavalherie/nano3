//
//  CreateEditIdeaViewController.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 25/09/23.
//

import Foundation
import UIKit

class CreateEditIdeaViewController: UIViewController {
    
    var idea: Idea? // A ideia a ser editada (pode ser nula para criar uma nova ideia)
    var ideasViewModel: IdeasViewModel // A ViewModel que gerencia as ideias
    var ideasListDelegate: IdeasListDelegate? // Delegate para atualizar a tela de listagem
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Título"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let noteTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        return textView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    // Inicialização da CreateEditIdeaViewController com a IdeasViewModel
    init(ideasViewModel: IdeasViewModel) {
        self.ideasViewModel = ideasViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Configure as subviews
        view.addSubview(titleTextField)
        view.addSubview(noteTextView)
        view.addSubview(imageView)
        
        // Configure as restrições
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            noteTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noteTextView.heightAnchor.constraint(equalToConstant: 100),
            
            imageView.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Preencha as informações da ideia, se estiver editando
        if let idea = idea {
            titleTextField.text = idea.title
            noteTextView.text = idea.note
            if let firstImage = idea.images.first {
                imageView.image = firstImage
            }
        }
        
        // Configurar a barra de navegação
        if idea == nil {
            navigationItem.title = "Criar Nova Ideia"
        } else {
            navigationItem.title = "Editar Ideia"
        }
        
        // Adicionar botões de salvar e cancelar à barra de navegação
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveIdea)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancel)
        )
    }
    
    // MARK: - Actions
    
    @objc func saveIdea() {
        // Salvar a ideia ou atualizar a ideia existente com base nos dados do formulário
        
        // Exemplo: Crie uma nova ideia ou atualize a ideia existente
        if idea == nil {
            // Criar uma nova ideia
            let newIdea = Idea(title: titleTextField.text ?? "", note: noteTextView.text, images: [])
            ideasViewModel.addIdea(newIdea)
            
            ideasListDelegate?.didCreateNewIdea(newIdea)
        } else {
            // Atualizar a ideia existente
            idea?.title = titleTextField.text ?? ""
            idea?.note = noteTextView.text
            // Atualize a imagem se necessário
        }
        
        // Retorne à tela anterior
        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancel() {
        // Cancelar a criação ou edição da ideia e retornar à tela anterior
        navigationController?.popViewController(animated: true)
    }
}

