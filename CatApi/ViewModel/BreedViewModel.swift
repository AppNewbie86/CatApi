//
//  BreedViewModel.swift
//  CatApi
//
//  Created by Marcel Zimmermann on 10.02.23.
//
import Foundation

// Dies ist die Hauptklasse "BreedViewModel", die eine ObservableObject ist
@MainActor class BreedViewModel: ObservableObject {
    
    // Ein veröffentlichtes Array, das Daten des Typs "Breed" enthält
    @Published var breeds: [Breed] = []
    
    // Ein veröffentlichtes Variable mit dem Namen isLoading vom Datentyp Boolean, wo mit false als Defaultwert belegt wurde
    @Published var isLoading: Bool = false
    
    // Ein veröffentlichtes Variable mit dem Namen errorMessage vom Datentyp String, die optional ist und einen leeren Wert hat
    @Published var errorMessage : String? = nil
    
    // Initialisierungsmethode
    init() {
        fetchAllBreeds()
    }
    
    // Methode zum Abrufen aller Rassen
    func fetchAllBreeds() {
        
        // Setzen des isLoading-Flags auf true, um anzuzeigen, dass das Laden im Gange ist
        isLoading = true
        errorMessage = nil
        
        // Instanz von APIService wird erstellt
        let service = APIService()
        // URL wird erstellt
        let url = URL(string: "https://api.thecatapi.com/v1/breeds")
        // Die Methode fetchBreeds wird aufgerufen, um die Rassen abzurufen
        service.fetchBreeds(url: url) { [ unowned self ] result in
            
            DispatchQueue.main.async {
                
                // Setzen des isLoading-Flags auf false, um anzuzeigen, dass das Laden abgeschlossen ist
                self.isLoading = false
                switch result {
                case.failure(let error):
                    // Fehlermeldung wird gesetzt
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let breeds):
                    // Breeds werden gesetzt
                    self.breeds = breeds
                }
            }
        }
    }
    
    // MARK: Preview-Helfer
    
    static func errorState() -> BreedViewModel {
        let fetcher = BreedViewModel()
        // Fehlermeldung wird gesetzt
        fetcher.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return fetcher
    }
    static func sucessState() -> BreedViewModel {
        let fetcher = BreedViewModel()
        // Beispiel-Rassen werden gesetzt
        fetcher.breeds = [Breed.example1(), Breed.example2()]
        return fetcher
    }
}
