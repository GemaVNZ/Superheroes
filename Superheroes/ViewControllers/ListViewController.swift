//
//  ListViewController.swift
//  Superheroes
//
//  Created by Mañanas on 2/9/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UISearchBar!
    
    var superheroList: [Superhero] = []
    var superheroInitialList: [Superhero] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        searchButton.delegate = self
    }
    
    //Actualizar los datos de la vista
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superheroList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SuperheroViewCell
        let superhero = superheroList[indexPath.row]
        cell.render(Superhero: superhero)
        return cell
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Texto de búsqueda actual: '\(searchText)'")
        
        guard !searchText.isEmpty else {
            superheroList = superheroInitialList
            tableView.reloadData()
            print("Texto de búsqueda vacío. Lista reseteada a la inicial.")
            return
        }
        
        print("Buscando superhéroes con el nombre: \(searchText)")
        
        
        SuperheroProvider.shared.searchSuperheroes(by: searchText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let superheroes):
                    print("Superhéroes encontrados: \(superheroes.count)")
                    self?.superheroList = superheroes
                case .failure(let error):
                    print("Error al buscar superhéroes: \(error.localizedDescription)")
                    self?.superheroList = []
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "navigateToDetail" {
            let viewController = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            viewController.superhero = superheroList[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


