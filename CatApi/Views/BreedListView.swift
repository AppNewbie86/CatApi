//
//  BreedListView.swift
//  CatApi
//
//  Created by Marcel Zimmermann on 10.02.23.
//
import SwiftUI

// Eine Struktur "BreedListView", die eine Liste von Rassen darstellt
struct BreedListView: View {
    
    // Eine Konstante "breeds", die ein Array von "Breed"-Daten enthält
    let breeds: [Breed]
    
    // Eine @State-Variable "searchtext", die den gesuchten Text speichert
    @State private var searchtext: String = ""
    
    // Eine Computed Property "filteredBreeds", die die Rassen nach dem Suchtext filtern
    var filteredBreeds : [Breed] {
        if searchtext.count == 0 {
            return breeds
        }else {
            return breeds.filter { $0.name.contains(searchtext)}
        }
    }
    
    // Die Hauptansicht der Struktur
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredBreeds) { breed in
                    NavigationLink {
                        BreedDetailView(breed: breed)
                    } label: {
                        BreedRow(breed: breed)
                    }
                    
                }
                
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Find Your best Cat")
            .searchable(text: $searchtext)
            
        }
    }
}
    
// Eine Struktur "BreedListView_Previews", die eine Vorschau der Ansicht bereitstellt
struct BreedListView_Previews: PreviewProvider {
    static var previews: some View {
        BreedListView(breeds: BreedViewModel.sucessState().breeds)
    }
}
