//
//  ContentView.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 14/5/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var beerVMInstance = BeerViewModel()
    
    @State var isSearching = false
    @State var showFilters = false
    
    var body: some View {
        TabView{
            HomeView(isSearching: $isSearching, showFilters: $showFilters, beerVMInstance: beerVMInstance)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("home")
                }
                .sheet(isPresented: $showFilters) {
                    FiltersView(hideme: $showFilters, intanceBeerVM: beerVMInstance)
                }
            
            InfoView().tabItem {
                Image(systemName: "info.circle.fill")
                Text("info")
            }
        }
        .accentColor(Color("brown"))
        .onAppear {
            beerVMInstance.getBeers()
            print("NAda ndad")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


