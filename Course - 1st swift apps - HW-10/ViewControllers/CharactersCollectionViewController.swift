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
    private var characters = Characters()
    private var cellIdentifier = "characterCell"
    private var characterSegueIdentifier = "showCharacter"
    
//    private var images = [UIImage]()
    
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        characters.getCharacters(from: DataURL.shared.characters) { 
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        
        
//        DispatchQueue.global().async {
//            for character in self.characters.list {
//                if let stringURL = character.image {
//                    if let imageURL = URL(string: stringURL) {
//                        if let imageData = try? Data(contentsOf: imageURL) {
//                            self.images.append(UIImage(data: imageData) ?? UIImage())
//                        } else {
//                            self.images.append(UIImage())
//                        }
//                    }
//                }
//            }
//        }
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.list.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CharacterCollectionViewCell
        
//        let index = indexPath.item
//        let image = images.count > index ? images[index] : nil
//        cell.configure(with: characters.list[index], image: image)
        cell.configure(with: characters.list[indexPath.item])
    
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
    
}

// MARK: - Extension + CharactersCollectionViewController
extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = UIScreen.main.bounds.width/2 - 2
        return CGSize(width: size, height: size)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters.list[indexPath.item]
        performSegue(withIdentifier: characterSegueIdentifier, sender: character)
    }
}
