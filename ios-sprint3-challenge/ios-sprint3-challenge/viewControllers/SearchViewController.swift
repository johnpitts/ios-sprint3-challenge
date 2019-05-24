//
//  SearchViewController.swift
//  ios-sprint3-challenge
//
//  Created by John Pitts on 5/24/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }

    
    /* perhaps we use something like this from Students project...
     let studentController = StudentController()
     
     var students: [Student] = []
     var editedStudents: [Student] = []
     
     override func viewDidLoad() {
     super.viewDidLoad()
     
     // This is calling the load... method, and also giving us access to implement the closure, or the code we want to run when the load... method has finished.
     
     // Main -> BG to fetch students -> Call completion -> Reload TV on main queue
     
     studentController.loadFromPersistentStore { (students) in
     
     self.students = students
     self.editedStudents = students
     
     
     // If you are trying to do anything with a `UI` prefixed object, it should be done on the main thread.
     
     DispatchQueue.main.async {
     self.updateDataSource()
     self.tableView.reloadData()
     }
     }
     
     }
     */
    
    override func viewWillAppear(_ animated: Bool) {
        
        updateViews()
    }
    
    @IBAction func savePokemonButtonPressed(_ sender: Any) {
        
        //save the new pokemon info from search to model and....
        guard let pokemon = pokemonController.pokemon else {return}
        print(pokemon.name)
        pokemonController.savePokemonToArray(with: pokemon)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("search bar activated")
        
        guard let searchTerm = searchBar.text?.lowercased() else { return }
        
        pokemonController.searchForPokemon(with: searchTerm) {
            
            DispatchQueue.main.async {
                
                self.updateViews()
                
                //self.tableView.reloadData() happens automatically if i go back to it, right?
            }
        }
    }
    
    func updateViews() {
        
        // this is a potential problem area, bc you're reloading pokemonController.pokemon instead of using what the SEGUE gave you for pokemon.  BUT, you also need to load pokemonController if you arrived here from the OTHER segue, namely the search segue.  so you're ending up with the LAST pokemon all the time bc here you're loading from pokemonController instead of the indexPath'd pokemon from your detail-segue.  an if-statement could cure this, but can you use segue indentifier in this viewController?
        guard let pokemon = pokemonController.pokemon else {return}
        
        nameLabel.text = pokemon.name
        idLabel.text = String(pokemon.id)
        typeLabel.text =  pokemon.types.reduce("") {$0 + $1.type.name + ", "}
        //let joined = pokemon.abilities.joined(separator: ", ")
        abilitiesLabel.text = pokemon.abilities.reduce("") {$0 + $1.ability.name + ", "}
        
        
        // will need to write a file to convert http to a photo string name version
        let spriteURL = pokemon.sprites.front_default
        guard let imageUrl = URL(string: spriteURL) else { return }
        if let imageData = try? Data(contentsOf: imageUrl) {
            imageView.image = UIImage(data: imageData)
        }
    }
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    var pokemonController = PokemonController()
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }

}
