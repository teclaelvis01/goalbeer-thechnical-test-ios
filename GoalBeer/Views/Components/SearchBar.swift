//
//  SearchBar.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 14/5/22.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchFoodText: String
    @Binding var isSearching: Bool
    var body: some View {
        HStack{
            HStack{
                TextField("search-here", text: $searchFoodText)
                    .padding(.leading, 24  )
            }
            .padding(10)
            .background(Color(.systemGray4))
            .cornerRadius(6)
            .onTapGesture {
                withAnimation(.easeInOut) {
                    isSearching = true
                }
                
            }
            .padding(.horizontal)
            .overlay(
                HStack{
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if isSearching {
                        Button {
                            searchFoodText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        }
                    }
                    
                }.padding(.horizontal, 32)
                    .foregroundColor(.gray)
            )
            .transition(.move(edge: .trailing))
            
            if isSearching {
                Button {
                    withAnimation(.easeInOut) {
                        isSearching = false
                        searchFoodText = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    
                } label: {
                    Text("cancel")
                        .padding(.trailing)
                        .padding(.leading,0)
                }.transition(.move(edge: .trailing))
            }
        }
    }
}
struct SearchBar_Previews: PreviewProvider {
    @State static var search = ""
    @State static var isSearching = false
    static var previews: some View {
        
        SearchBar(searchFoodText: $search, isSearching: $isSearching)
    }
}
