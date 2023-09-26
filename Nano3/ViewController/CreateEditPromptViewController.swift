//
//  CreateEditPromptViewController.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 26/09/23.
//

import Foundation
import UIKit

class CreateEditPromptViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var prompt: Prompt? // A ideia a ser editada (pode ser nula para criar uma nova ideia)
    var promptViewModel: PromptViewModel // A ViewModel que gerencia as ideias
    var promptListDelegate: PromptListDelegate? // Delegate para atualizar a tela de listagem
    
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
    
    // Inicialização da CreateEditPromptViewController com a PromptViewModel
    init(promptViewModel: PromptViewModel) {
        self.promptViewModel = promptViewModel
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
        
        // Configure as restrições
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            noteTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noteTextView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Preencha as informações da ideia, se estiver editando
        if let prompt = prompt {
            titleTextField.text = prompt.title
            noteTextView.text = prompt.note
        }
        
        // Configurar a barra de navegação
        if prompt == nil {
            navigationItem.title = "Criar Novo Prompt"
        } else {
            navigationItem.title = "Editar Prompt"
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
        if prompt == nil {
            let newPrompt = Prompt(title: titleTextField.text ?? "", note: noteTextView.text, phraseList: [])
            promptViewModel.addPrompt(newPrompt)
            promptListDelegate?.didCreateNewPrompt(newPrompt)
        } else {
            prompt?.title = titleTextField.text ?? ""
            prompt?.note = noteTextView.text
        }

        navigationController?.popViewController(animated: true)
    }
    
    @objc func cancel() {
        // Cancelar a criação ou edição da ideia e retornar à tela anterior
        navigationController?.popViewController(animated: true)
    }
}
