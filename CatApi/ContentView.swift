//
//  ContentView.swift
//  CatApi
//
//  Created by Marcel Zimmermann on 10.02.23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var breedViewModel = BreedViewModel()
    
    var body: some View {
        
        if breedViewModel.isLoading {
            LoadingView()
        }else if breedViewModel.errorMessage != nil {
            ErrorView(breedViewModel: breedViewModel)
        }else {
            BreedListView(breeds: breedViewModel.breeds)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
