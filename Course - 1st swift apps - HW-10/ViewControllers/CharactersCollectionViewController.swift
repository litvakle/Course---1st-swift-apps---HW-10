//
//  CharactersCollectionViewController.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 29.02.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class CharactersCollectionViewController: UICollectionViewController {
    
    // MARK: - Private Properties
    private var cellIdentifier = "characterCell"
    private var characterSegueIdentifier = "showCharacter"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var filteredCharacters = [RMCharacter]()
    
    private var searchBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }
    
    // MARK: - Initialisers
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search character"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .white
        }
    }
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? filteredCharacters.count : Characters.shared.list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CharacterCollectionViewCell
        
        let index = indexPath.item
        let character = isFiltering ? filteredCharacters[index] : Characters.shared.list[index]
        cell.configure(with: character)
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == characterSegueIdentifier {
            guard let cvc = segue.destination as? CharacterViewController else { return }
            guard let character = sender as? RMCharacter else { return }
            
            cvc.character = character
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let character = isFiltering ? filteredCharacters[index] : Characters.shared.list[index]
        performSegue(withIdentifier: characterSegueIdentifier, sender: character)
    }
}
    
// MARK: - Extension + CharactersCollectionViewController
extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width/2 - 4
       
        return CGSize(width: size, height: size)
    }
}

extension CharactersCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterCharacters()
        collectionView.reloadData()
    }
    
    private func filterCharacters() {
        let searchText = searchController.searchBar.text ?? ""
        filteredCharacters = Characters.shared.list.filter { $0.name?.contains(searchText) ?? false }
    }
}
