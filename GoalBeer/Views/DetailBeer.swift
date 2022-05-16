//
//  DetailBeer.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 15/5/22.
//

import SwiftUI

struct DetailBeer: View {
    let beer: BeerModel
    var body: some View {
        ScrollView{
            VStack{
                ZStack{
                    Image("homer")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .offset(x: 150, y: -150)
                    
                    CacheAsyncImage(url: beer.url){ phase in
                        
                        switch phase {
                        case .empty:
                            HStack(alignment: .center){
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                            }
                        case .success(let image):
                            HStack{
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height:300)
                            }
                        case .failure(let error):
                            Text("image-could-not \(error.localizedDescription)")
                        @unknown default:
                            fatalError()
                        }
                        
                    }
                    
                    
                }
                
                
                VStack(alignment: .leading){
                    HStack{
                        Text(beer.name)
                            .font(.system(size: 32, weight: .heavy, design: .rounded))
                        Spacer()
                    }.padding(.vertical)

                        
                    Text(beer.description)
                        .font(.system(size: 18, weight: .regular))
                        .lineSpacing(10)
                        .padding(.bottom)
                    
                    if beer.foodPairing.count > 0 {
                        Text("food-pairing")
                            .font(.system(size: 26, weight: .bold))
                            .padding(.bottom)
                        
                        ForEach(beer.foodPairing, id: \.self) { str in
                            HStack{
                                Image(systemName: "exclamationmark.circle.fill")
                                    .foregroundColor(.gray)
                                Text(str)
                            }.padding(.vertical,1)
                            
                        }
                    }
                    
                }
                .padding(.bottom)
                
                Image("paddle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)

                Spacer()
            }.padding()
        }
        
        
    }
}

struct DetailBeer_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailBeer(beer: BeerModel())
    }
}
