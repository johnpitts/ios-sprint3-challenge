//
//  PokemonTableViewController.swift
//  ios-sprint3-challenge
//
//  Created by John Pitts on 5/24/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    @IBAction func gotoSearchButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "SearchSegue", sender: (Any).self)
        // i think just "self" is ok, but let's run first
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        
        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name
        print(pokemon.sprites.front_default)
        if let spriteURL = URL(string: pokemon.sprites.front_default),
            let imageData = try? Data(contentsOf: spriteURL) {
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pokemonController.pokemons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // two segues from here:
        //one for add bar button
        
        if segue.identifier == "SearchSegue" {
            if let searchVC = segue.destination as? SearchViewController {
                searchVC.pokemonController = pokemonController
            }
            
            //the other for pressing a cell
        } else {
            if segue.identifier == "PokemonDetail" {
                print("COMMENCED DETAIL SEGUE")
                if let detailVC = segue.destination as? SearchViewController,
                    let indexPath = tableView.indexPathForSelectedRow {
                    detailVC.pokemon = pokemonController.pokemons[indexPath.row]
                    print("you selected INDEXPATH-ROW \(indexPath.row)")
                    detailVC.pokemonController = pokemonController
                }
            }
        }
        
    }
    
    
    var pokemonController = PokemonController()
}
