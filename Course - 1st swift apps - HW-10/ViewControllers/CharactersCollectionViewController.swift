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
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Characters.shared.list.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CharacterCollectionViewCell
        
        let index = indexPath.item
        cell.configure(with: Characters.shared.list[index])
        
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
        let character = Characters.shared.list[indexPath.item]
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
