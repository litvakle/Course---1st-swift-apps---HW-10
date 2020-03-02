//
//  EpisodesTableViewController.swift
//  Course - 1st swift apps - HW-10
//
//  Created by Lev Litvak on 01.03.2020.
//  Copyright © 2020 Lev Litvak. All rights reserved.
//

import UIKit

class EpisodesTableViewController: UITableViewController {

    // MARK: - Public properties
    var character: RMCharacter!
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.episode?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath)

        let index = indexPath.row
        
        if let episodes = character.episode {
            let url = episodes[index]
            
            if let episode = Episodes.shared.getEpisode(by: url) {
                cell.textLabel?.text = "\(episode.episode ?? "") - \(episode.name ?? "")"
                cell.detailTextLabel?.text = "Release date: \(episode.air_date ?? "")"
                cell.textLabel?.textColor = UIColor.white
                cell.detailTextLabel?.textColor = UIColor.white
            }
        }
        
        return cell
    }
}
