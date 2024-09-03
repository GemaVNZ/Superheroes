//
//  SuperheroViewCell.swift
//  Superheroes
//
//  Created by Mañanas on 2/9/24.
//

import UIKit

class SuperheroViewCell: UITableViewCell {
    
    var task: URLSessionDataTask? = nil
    
    @IBOutlet weak var superheroImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        }
        
    func render(Superhero: Superhero) {
        nameLabel.text = Superhero.name
        
        // Establecer una imagen de placeholder
        superheroImage.image = UIImage(named: "image-placeholder")
        
        // Cancelar cualquier tarea previa si existe
        task?.cancel()
        
        // Verificar que la URL sea válida
        guard let url = URL(string: Superhero.image.url) else {
            print("URL de imagen inválida")
            return
        }
        
        // Descargar la imagen
        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Verificar si hay datos y si no hubo errores
            guard let data = data, error == nil else {
                print("Error al descargar la imagen: \(error?.localizedDescription ?? "Desconocido")")
                return
            }
            
            // Actualizar la imagen en el hilo principal
            DispatchQueue.main.async {
                // Solo actualizar si la celda sigue siendo visible
                if let image = UIImage(data: data) {
                    self?.superheroImage.image = image
                }
            }
        }
        task?.resume()
    }
}
