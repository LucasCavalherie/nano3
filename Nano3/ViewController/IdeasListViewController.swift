//
//  IdeasListViewController.swift
//  Nano3
//
//  Created by Lucas Cavalherie on 25/09/23.
//

import Foundation
import UIKit

class IdeasListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, IdeasListDelegate {

    var ideasViewModel = IdeasViewModel()
    
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
        collectionView.register(IdeaCollectionViewCell.self, forCellWithReuseIdentifier: "IdeaCell")
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
            action: #selector(createNewIdea)
        )
    }
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ideasViewModel.ideas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IdeaCell", for: indexPath) as! IdeaCollectionViewCell
        
        // Configure a célula com as informações da ideia
        let idea = ideasViewModel.ideas[indexPath.item]
        cell.configure(with: idea)
        
        return cell
    }
    
    // MARK: - Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Quando uma ideia é selecionada, navegue para a tela de detalhes da ideia
        let idea = ideasViewModel.ideas[indexPath.item]
        let ideaDetailViewController = IdeaDetailViewController()
        ideaDetailViewController.idea = idea
        navigationController?.pushViewController(ideaDetailViewController, animated: true)
    }
    
    // MARK: - IdeasListDelegate
    func didCreateNewIdea(_ idea: Idea) {
        // Adicione a nova ideia à sua data source (ideasViewModel) e recarregue a coleção
        collectionView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc func createNewIdea() {
        // Quando o botão "Criar Nova Ideia" é pressionado, navegue para a tela de criação/edição de ideia
        let createEditIdeaViewController = CreateEditIdeaViewController(ideasViewModel: ideasViewModel)
        createEditIdeaViewController.ideasListDelegate = self
        navigationController?.pushViewController(createEditIdeaViewController, animated: true)
    }
}

