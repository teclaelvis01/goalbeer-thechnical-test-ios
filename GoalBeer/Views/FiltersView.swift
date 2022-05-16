//
//  Filters.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 15/5/22.
//

import SwiftUI

struct FiltersView: View {
    @Binding var hideme: Bool
    @StateObject var intanceBeerVM: BeerViewModel
    
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    hideme = false
                } label: {
                    Text("cancel")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.gray)
                }.padding(.leading)
                Spacer()
                Text("filters")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
                Button {
                    hideme = false
                    intanceBeerVM.resetFilters()
                } label: {
                    Text("reset")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
            }
            .padding(.top)
            
            List{
                
                Section{
                    VStack(alignment: .leading){
                        Toggle("ABV", isOn: $intanceBeerVM.abvFilterActive.animation())
                        
                        Text("act-filter-abv")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    if intanceBeerVM.abvFilterActive {
                        Stepper("ABV greater than \(String(format: "%.1f", intanceBeerVM.abvGtCounter))",value: $intanceBeerVM.abvGtCounter,in: 1...20,step: 0.5)
                            .transition(.move(edge: .bottom))
                        
                        Stepper("ABV less than \(String(format: "%.1f", intanceBeerVM.abvLtCounter))",value: $intanceBeerVM.abvLtCounter,in: 1...10,step: 0.5)
                            .transition(.move(edge: .bottom))
                    }
                    
                } header: {
                    Text("alcohol-by-volume")
                }
                
                Section{
                    VStack(alignment: .leading){
                        Toggle("IBU", isOn: $intanceBeerVM.ibuFilterActive.animation())
                        
                        Text("act-filter-ibu")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    if intanceBeerVM.ibuFilterActive {
                        Stepper("IBU greater than \(intanceBeerVM.ibuGtCounter)",value: $intanceBeerVM.ibuGtCounter,in: 1...100,step: 5)
                            .transition(.move(edge: .bottom))
                        Stepper("IBU less than \(intanceBeerVM.ibuLtCounter)",value: $intanceBeerVM.ibuLtCounter,in: 1...100,step: 5)
                            .transition(.move(edge: .bottom))
                    }
                    
                } header: {
                    Text("international-bittering-units")
                }

                Section{
                    VStack(alignment: .leading){
                        Toggle("Brewed", isOn: $intanceBeerVM.brewedFilterActive.animation())
                        
                        Text("act-filter-brewed")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    if intanceBeerVM.brewedFilterActive {
                        DatePicker("before-this-date", selection: $intanceBeerVM.brewedBeforeDate, displayedComponents: .date)
                            .transition(.move(edge: .bottom))
                        DatePicker("after-this-date", selection: $intanceBeerVM.brewedAfterDate, displayedComponents: .date)
                            .transition(.move(edge: .bottom))
                    }
                    
                } header: {
                    Text("beer-brewed")
                }
            }
            
            Button {
                hideme = false
                intanceBeerVM.appyFilters()
            } label: {
                Text("apply-filters")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("orange-strong"))
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct Filters_Previews: PreviewProvider {
    @State static var hide = true
    
    static var previews: some View {
        FiltersView(hideme: $hide, intanceBeerVM: BeerViewModel())
    }
}
