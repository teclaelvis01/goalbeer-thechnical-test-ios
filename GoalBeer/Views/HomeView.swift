//
//  HomeView.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 15/5/22.
//

import SwiftUI

struct HomeView: View {
    @Binding var isSearching: Bool
    @Binding var showFilters: Bool
    @StateObject var beerVMInstance: BeerViewModel
    
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack{
            NavigationView {
                ScrollView( showsIndicators: false){
                    CardWelcomeView()
                        .padding(.bottom,30)
                        .padding()
                    SearchBar(searchFoodText: $beerVMInstance.searchFood, isSearching: $isSearching)
                    if beerVMInstance.notResults {
                        EmptyResult()
                    }
                    LazyVGrid(columns: gridItems, spacing: 10) {
                        ForEach(beerVMInstance.beers) { beerItem in
                            ItemView(item: beerItem, destinationView: {
                                DetailBeer(beer: beerItem)
                            })
                            .onAppear(){
                                self.beerVMInstance.loadMoreContent(currentItem: beerItem)
                            }
                        }
                        
                    }.padding()
                }
                
                .navigationTitle(Text("home"))
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    Button {
                        showFilters = true
                    } label: {
                        ZStack{
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.system(size: 20, weight: .regular))
                            if beerVMInstance.isFiltered {
                                Circle()
                                    .foregroundColor(.red)
                                    .frame(width: 15, height: 15)
                                    .offset(x: 10, y: -10)
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    @State static var isSearching = true
    @State static var showFilters = true
    static var previews: some View {
        HomeView(isSearching: $isSearching, showFilters: $showFilters, beerVMInstance: BeerViewModel())
    }
}
