//
//  BreedRow.swift
//  CatApi
//
//  Created by Marcel Zimmermann on 10.02.23.
//

import SwiftUI

// Struktur für eine Katzenart (BreedRow)
struct BreedRow: View {
    
    // Eigenschaft für die Katzenart
    let breed : Breed
    
    // Größe des Bildes
    let imageSize: CGFloat = 100
    
    // Körper-View
    var body: some View {
        
        // Horizontales Stack-View
        HStack {
            
            // Wenn ein Bild für die Katzenart verfügbar ist
            if breed.image?.url != nil {
                
                // Bild wird asynchron geladen
                AsyncImage(url: URL(string: breed.image!.url!)) { phase in
                    
                    // Wenn das Bild geladen wurde
                    if let image = phase.image {
                        // Bild wird skaliert und beschnitten
                        image.resizable()
                            .scaledToFill()
                            .frame(width: imageSize, height: imageSize)
                            .clipped()
                    }
                    // Wenn ein Fehler beim Laden aufgetreten ist
                    else if phase.error != nil {
                        Text(phase.error?.localizedDescription ?? "error")
                            .foregroundColor(Color.pink)
                        Color.red
                            .frame(width: imageSize, height: imageSize)
                    }
                    // Wenn das Bild noch nicht geladen wurde
                    else {
                        ProgressView()
                            .frame(width: imageSize, height: imageSize)
                    }
                }
            }
            // Wenn kein Bild verfügbar ist
            else {
                Color.gray.frame(width: imageSize, height: imageSize)
            }
            
            // Vertikales Stack-View mit Katzenart-Informationen
            VStack(alignment: .leading, spacing: 5) {
                Text(breed.name)
                    .font(.headline)
                Text(breed.temperament)
            }

        }
    }
}

// Preview für BreedRow
struct BreedRow_Previews: PreviewProvider {
    static var previews: some View {
        BreedRow(breed: Breed.example1())
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
