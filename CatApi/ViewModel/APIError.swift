//
//  APIError.swift
//  CatApi
//
//  Created by Marcel Zimmermann on 10.02.23.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    
    // Fall: ungültige URL

case badURL
    
    // Fall: schlechte Antwort (mit einer Status-Code-Variable)

case badResponse(statusCode: Int)
   
    // Fall: URL-Fehler (mit einer Variable vom Typ URLError)

case url(URLError)
    
    // Fall: Parsing-Fehler (mit einer Optional-Variable vom Typ DecodingError)

case parsing(DecodingError?)
    
    // Fall: unbekannter Fehler

case unknown
    
    
    // Eine Variable "localizedDescription" mit dem Datentyp String, die eine benutzerfreundliche Fehlermeldung bereitstellt
    var localizedDescription: String {
        
        // Benutzer-Feedback
        switch self {
        case .badURL, .parsing, .unknown:
            return "Sorry irgendwas lief schief"
        case .badResponse(_):
            return "Sorry deine Verbindung mit dem Server lief schief"
        case .url(let error):
            return error.localizedDescription ?? "Sorry irgendwas lief schief"
        }
        
        
    }
    // Eine Variable "description" mit dem Datentyp String, die Informationen für das Debugging bereitstellt

    var description: String {
        // info fürs Debugging
        switch self {
        case .unknown: return "unknown error"
        case .badURL: return "invalid URL"
        case .url(let error):
            return error.localizedDescription ?? "url session error"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"

        }
    }
}
