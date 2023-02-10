//
//  ErrorView.swift
//  CatApi
//
//  Created by Marcel Zimmermann on 10.02.23.
//
import SwiftUI

// ErrorView-Struktur, die ein ObservedObject-Modell des Typs "BreedViewModel" verwendet
struct ErrorView: View {
    @ObservedObject var breedViewModel: BreedViewModel

    // Body-Ansicht, die Textansichten enthält
    var body: some View {
        VStack {
            // Textansicht mit dem statischen Text "SHIT NO DATAS"
            Text("SHIT NO DATAS")
                .foregroundColor(Color.gray)
            
            // Textansicht, die den Fehlertext aus dem BreedViewModel enthält
            Text(breedViewModel.errorMessage ?? "")
        }
    }
}

// Struktur für Vorschauen, die Vorschauansichten von ErrorView bereitstellt
struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(breedViewModel: BreedViewModel())
    }
}
