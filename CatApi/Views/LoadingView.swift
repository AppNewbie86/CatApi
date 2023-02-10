//
//  LoadingView.swift
//  CatApi
//
//  Created by Marcel Zimmermann on 10.02.23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            // Anzeige des Texts "one moment ..."
            Text("one moment ...")
                .font(.system(size: 40))
            
            // Anzeige des ProgressViews
            ProgressView()
            
            // Anzeige des Texts "Ich hole dir deine Katzen... "
            Text("Ich hole dir deine Katzen... ")
                .foregroundColor(Color.yellow)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        // Erstellung einer Preview-Instanz von LoadingView
        LoadingView()
    }
}
