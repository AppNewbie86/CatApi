//
//  BreedImage.swift
//  CatApi
//
//  Created by Marcel Zimmermann on 10.02.23.
//

import Foundation

// Diese Struktur beschreibt die Informationen eines Bildes einer bestimmten Rasse

struct BreedImage : Codable {
    
    // alle Parameter sind auf Optional
    
    let height: Int? // Höhe des Bildes
    let id : String? // eindeutige Id Zuweisung
    let url : String? // URL Link zum Bild
    let width : Int? // Breite des Images
}
