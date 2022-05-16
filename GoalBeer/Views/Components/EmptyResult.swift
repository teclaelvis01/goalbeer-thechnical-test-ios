//
//  EmptyResult.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 15/5/22.
//

import SwiftUI

struct EmptyResult: View {
    var body: some View {
        VStack{
            Image("woman")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("we-dont-have")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.black)
                .padding()
            
        }
        .padding(40)
    }
}

struct EmptyResult_Previews: PreviewProvider {
    static var previews: some View {
        EmptyResult()
    }
}
