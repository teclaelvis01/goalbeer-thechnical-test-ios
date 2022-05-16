//
//  CardWelcomeView.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 14/5/22.
//

import SwiftUI

struct CardWelcomeView: View {
    var body: some View {
        HStack(alignment:.center){
            VStack(alignment:.leading){
                
                Text("find-perf-beer")
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    
                Text("find-out-which")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.black)
                    .padding()

            }
            Spacer()
            Image("reward")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
                .padding(.trailing)
        }
        .background(
            Color("yellow-hight")
                .cornerRadius(15)
                .padding(.vertical, -20)
                .shadow(color: .gray, radius: 7.0, x: 0, y: 0)
        )
    }
}

struct CardWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        CardWelcomeView()
    }
}
