//
//  CatBreed.swift
//  CatApi
//
//  Created by Marcel Zimmermann on 10.02.23.
//
import Foundation

// Struct "Breed" implementiert das Codable-Protokoll und das CustomStringConvertible-Protokoll
struct Breed : Codable, CustomStringConvertible, Identifiable {
    // Variablen, die Eigenschaften einer Rasse darstellen
    let id : String
    let name : String
    let temperament : String
    let breedExplaination : String
    let energyLevel : Int
    let isHairless : Bool
    let image : BreedImage?
   
    // Computed Property, die eine beschreibende Zeichenkette für die Rasse bereitstellt
    var description : String {
        return "breed with name: \(name) and id \(id), energy level: \(energyLevel) isHairless: \(isHairless ? "YES" : "NO")"
    }
    
    // Enum für die Codierungsschlüssel
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case temperament
        case breedExplaination = "description"
        case energyLevel = "energy_level"
        case isHairless = "hairless"
        case image

    }
    
    // Initialisierungsmethode
    init(from decoder : Decoder) throws {
        // Werte aus dem Dekodierer
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // Entschlüsselung der einzelnen Werte
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        temperament = try values.decode(String.self, forKey: .temperament)
        breedExplaination = try values.decode(String.self, forKey: .breedExplaination)
        energyLevel = try values.decode(Int.self, forKey: .energyLevel)
        
        // Überprüfung, ob die Rasse haarlos ist (1 = ja, 0 = nein)
        let hairless = try values.decode(Int.self, forKey: .isHairless)
        isHairless = hairless == 1
        
        // Entschlüsselung des Images
        image = try values.decodeIfPresent(BreedImage.self, forKey: .image)
    }
    
    init(name: String, id: String, explaination: String, temperament: String, energyLevel: Int, isHairless: Bool, image: BreedImage?){
        self.name = name
        self.id = id
        self.breedExplaination = explaination
        self.energyLevel = energyLevel
        self.temperament = temperament
        self.image = image
        self.isHairless = isHairless

        
    }
    
    static func example1() -> Breed {
            return Breed(name: "Abyssinian",
                          id: "abys",
                          explaination: "The Abyssinian is easy to care for, and a joy to have in your home. They're affectionate cats and love both people and other animals.",
                          temperament: "Active, Energetic, Independent, Intelligent, Gentle",
                          energyLevel: 4,
                          isHairless: false,
                          image: nil )
    }
    
    static func example2() -> Breed {
           return Breed(name: "Cyprus",
                          id: "cypr",
                          explaination: "Loving, loyal, social and inquisitive, the Cyprus cat forms strong ties with their. They are not overly active by nature which makes them the perfect companion for people who would like to share their homes with a laid-back relaxed feline companion",
                          temperament: "Affectionate, Social",
                          energyLevel: 4,
                          isHairless: false,
                          image: nil )
    }
}
