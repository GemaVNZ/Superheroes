//
//  DetailViewController.swift
//  Superheroes
//
//  Created by Mañanas on 2/9/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var superheroImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var powerstatsTextView: UITextView!
    
    @IBOutlet weak var workTextView: UITextView!
    
    var superhero: Superhero? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let superhero = superhero {
                    nameLabel.text = superhero.name
                    powerstatsTextView.text = "Intelligence: \(superhero.powerstats.intelligence ?? "N/A")\nStrength: \(superhero.powerstats.strength ?? "N/A")\nSpeed: \(superhero.powerstats.speed ?? "N/A")\nDurability: \(superhero.powerstats.durability ?? "N/A")\nPower: \(superhero.powerstats.power ?? "N/A")\nCombat: \(superhero.powerstats.combat ?? "N/A")"
                    workTextView.text = "Publisher: \(superhero.biography.publisher)"
                    
                    if let url = URL(string: superhero.image.url) {
                        URLSession.shared.dataTask(with: url) { data, response, error in
                            guard let data = data, error == nil else {
                                print("Error al descargar la imagen: \(error?.localizedDescription ?? "Desconocido")")
                                return
                            }
                            
                            DispatchQueue.main.async {
                                self.superheroImageView.image = UIImage(data: data)
                            }
                        }.resume()
                    }
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

