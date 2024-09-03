//
//  SuperheroProvider.swift
//  Superheroes
//
//  Created by Mañanas on 2/9/24.
//

import Foundation

class SuperheroProvider {
    
    static let shared = SuperheroProvider()
    
    private init() {}
    
    func searchSuperheroes(by query: String, completion: @escaping (Result<[Superhero], Error>) -> Void) {
        let url = URL(string: "\(Constants.API_BASE_URL)search/\(query)")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibió ningún dato"])
                print("Error: No data received")
                completion(.failure(error))
                return
            }
            
            // Imprime la respuesta de la API para depuración
            if let responseString = String(data: data, encoding: .utf8) {
                print("Respuesta de la API: \(responseString)")
            } else {
                print("No se pudo convertir los datos a string.")
            }
            
            do {
                let decoder = JSONDecoder()
                let superheroResponse = try decoder.decode(SuperheroResponse.self, from: data)
                
                if superheroResponse.response == "success" {
                    print("Superhéroes recibidos: \(superheroResponse.results.count)")
                    completion(.success(superheroResponse.results))
                } else {
                    let errorMessage = superheroResponse.error ?? "Error desconocido de la API."
                    print("Error de la API: \(errorMessage)")
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
            } catch let jsonError {
                print("Error de JSON: \(jsonError.localizedDescription)")
                completion(.failure(jsonError))
            }
        }
        task.resume() // Inicia la tarea
    }
}


// MARK: Utils


