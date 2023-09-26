//
//  PromptListViewController.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 26/09/23.
//

import Foundation
import UIKit

class PromptListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PromptListDelegate {

    var promptViewModel = PromptViewModel()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 8 // Espaçamento entre as células (ajuste conforme necessário)
        let width = UIScreen.main.bounds.width - (2 * itemSpacing) // Largura da célula
        layout.itemSize = CGSize(width: width, height: 100) // Altura pode ser ajustada conforme necessário
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar a coleção
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PromptCollectionViewCell.self, forCellWithReuseIdentifier: "IdeaCell")
        collectionView.collectionViewLayout = collectionViewFlowLayout
        
        // Adicionar a coleção à vista principal
        view.addSubview(collectionView)
        
        // Configurar as restrições da coleção
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Configurar um botão de "Criar Nova Ideia" na barra de navegação
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(createNewPrompt)
        )
    }
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promptViewModel.prompts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IdeaCell", for: indexPath) as! PromptCollectionViewCell
        
        // Configure a célula com as informações da ideia
        let prompt = promptViewModel.prompts[indexPath.item]
        cell.configure(with: prompt)
        
        return cell
    }
    
    // MARK: - Collection View Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Quando uma ideia é selecionada, navegue para a tela de detalhes da ideia
        let prompt = promptViewModel.prompts[indexPath.item]
        let promptDetailViewController = PromptDetailViewController()
        promptDetailViewController.prompt = prompt
        navigationController?.pushViewController(promptDetailViewController, animated: true)
    }
    
    // MARK: - IdeasListDelegate
    func didCreateNewPrompt(_ prompt: Prompt) {
        // Adicione a nova ideia à sua data source (ideasViewModel) e recarregue a coleção
        collectionView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc func createNewPrompt() {
        // Quando o botão "Criar Novo Prompt" é pressionado, navegue para a tela de criação/edição de ideia
        let createEditPromptViewController = CreateEditPromptViewController(promptViewModel: promptViewModel)
        createEditPromptViewController.promptListDelegate = self
        navigationController?.pushViewController(createEditPromptViewController, animated: true)
    }
}
