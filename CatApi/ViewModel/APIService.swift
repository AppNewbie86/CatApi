//
//  APIService.swift
//  CatApi
//
//  Created by Marcel Zimmermann on 10.02.23.
//
import Foundation

struct APIService {
    
    // Funktion zum Abrufen von Daten vom API
    func fetch<T: Decodable>(_ type: T.Type, url: URL?, completion: @escaping(Result<T,APIError>) -> Void) {
        
        // Überprüfung, ob die URL für die API-Anfrage vorhanden ist
        guard let url = url else {
            // Wenn nicht, wird ein Fehler mit Typ "badURL" erzeugt
            let error = APIError.badURL
            // Rückgabe des Fehlers
            completion(Result.failure(error))
            return
        }
        
        // Erstellung einer Datentask für die URL-Session
        let task = URLSession.shared.dataTask(with: url) {( data , response, error) in
            
            // Überprüfung, ob ein Fehler bei der URL-Session aufgetreten ist
            if let error = error as? URLError {
                // Wenn ja, Rückgabe des Fehlers vom Typ "url"
                completion(Result.failure(APIError.url(error)))
            }
            // Überprüfung, ob die HTTP-Antwort im erwarteten Bereich (200-299) liegt
            else if let response = response as? HTTPURLResponse,
                    !(200...299).contains(response.statusCode) {
                // Wenn nicht, Rückgabe des Fehlers vom Typ "badResponse" mit dem Statuscode
                completion(Result.failure(APIError.badResponse(statusCode:
                                                                response.statusCode)))
            }
            // Überprüfung, ob Daten vorhanden sind
            else if let data = data {
                
                // Erstellung eines JSON-Dekodierers
                let decoder = JSONDecoder()
                
                do {
                    // Versuch, die Daten in ein Objekt des Typs T zu dekodieren
                    let result = try decoder.decode(type, from: data)
                    // Rückgabe der erfolgreich dekodierten Daten
                    
                    completion(Result.success(result))
                    
                    
                } catch {
                    // Rückgabe des Fehlers vom Typ "parsing"
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
                
            }
            
            
        }
        
        // Starten des Tasks
        task.resume()
    }
    
    // Funktion zum Abrufen von Daten über die Rasse
    
    func fetchBreeds(url: URL?, completion: @escaping(Result<[Breed], APIError>) -> Void)  {
        
        // Überprüfung, ob die URL für die API-Anfrage vorhanden ist
        guard let url = url else {
            // Wenn nicht, wird ein Fehler mit Typ "badURL" erzeugt
            let error = APIError.badURL
            // und über die completion-Handler-Funktion mit dem Fehler-Result zurückgegeben
            completion(Result.failure(error))
            // Funktionsabbruch mit "return"
            return
        }
        
        // Datentask für die URL-Session
        let task = URLSession.shared.dataTask(with: url) {( data , response, error) in
            
            // Überprüfung, ob ein Fehler bei der Datenaufgabe aufgetreten ist
            if let error = error as? URLError {
                // Wenn ja, wird ein Fehler mit Typ "url" erzeugt
                // und über die completion-Handler-Funktion mit dem Fehler-Result zurückgegeben
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse,
                      // Überprüfung, ob der HTTP-Statuscode ein gültiger 2xx-Statuscode ist
                      !(200...299).contains(response.statusCode) {
                // Wenn nicht, wird ein Fehler mit Typ "badResponse" erzeugt
                // und über die completion-Handler-Funktion mit dem Fehler-Result zurückgegeben
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                // JSON-Dekodierer
                let decoder = JSONDecoder()
                
                do {
                    // Versuch, die Daten in ein Array des Typs "Breed" zu dekodieren
                    let breeds = try decoder.decode([Breed].self, from: data)
                    // Ausgabe der dekodierten Daten
                    completion(Result.success(breeds))
                } catch {
                    // Wenn das Dekodieren fehlschlägt, wird ein Fehler mit Typ "parsing" erzeugt
                    // und über die completion-Handler-Funktion mit dem Fehler-Result zurückgegeben
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        
        // Task wird gestartet
        task.resume()
    }
}
