//
//  BreedDetailView.swift
//  CatApi
//
//  Created by Marcel Zimmermann on 10.02.23.
//

import SwiftUI

struct BreedDetailView: View {
    let breed : Breed
    let imageSize: CGFloat = 300
    var body: some View {
        VStack {
            // Prüfen, ob ein Bild für die Rasse vorhanden ist.
            if breed.image?.url != nil {
                // Asynchroner Image-Loader, der ein Bild aus dem Internet lädt.
                AsyncImage(url: URL(string: breed.image!.url!)) { phase in
                    if let image = phase.image {
                        // Wenn das Bild geladen wurde, wird es skaliert und angezeigt.
                        image.resizable()
                            .scaledToFit()
                            .frame(height: imageSize)
                            .clipped()
                    } else if phase.error != nil {
                        // Wenn ein Fehler aufgetreten ist, wird dieser angezeigt.
                        Text(phase.error?.localizedDescription ?? "error")
                            .foregroundColor(Color.pink)
                            .frame(width: imageSize, height: imageSize)
                    } else {
                        // Während das Bild geladen wird, wird ein Ladebalken angezeigt.
                        ProgressView()
                            .frame(width: imageSize, height: imageSize)
                    }
                }
            }else {
                // Wenn kein Bild vorhanden ist, wird ein graues Feld angezeigt.
                Color.gray.frame(width: imageSize, height: imageSize)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                // Rassenname
                Text(breed.name)
                    .font(.headline)
                // Charakterisierung
                Text(breed.temperament)
                    .font(.footnote)
                // Erklärung
                Text(breed.breedExplaination)
                // Haarlosigkeit
                if breed.isHairless {
                    Text("hairless")
                }
                
                HStack {
                    Text("Energy Level ")
                    Spacer()
                    // Darstellung des Energielevels durch Stern-Icons
                    ForEach(1..<6) { id in
                        Image(systemName: "star.fill")
                            .foregroundColor(breed.energyLevel > id ?
                                             Color.accentColor : Color.gray )
                    }
                }
                
                Spacer()
            }.padding()
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
