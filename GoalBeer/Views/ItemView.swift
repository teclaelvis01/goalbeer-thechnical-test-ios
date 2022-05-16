//
//  ItemView.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 14/5/22.
//

import SwiftUI

struct ItemView<Content:View>: View {
    private var item: BeerModel
    private var destinationView: () -> Content
    
    init(item:BeerModel,@ViewBuilder destinationView: @escaping () -> Content) {
        self.destinationView = destinationView
        self.item = item
    }
    
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
            VStack(alignment: .center){
                CacheAsyncImage(url: item.url){ phase in
                    
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
                                .frame(height:200)
                                .padding(.top)
                        }
                    case .failure(let error):
                        Text("image-could-not \(error.localizedDescription)")
                    @unknown default:
                        fatalError()
                    }
                    
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text(item.name)
                        .lineLimit(1)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.top,10)
                    Text(item.tagline)
                        .frame(height: 50, alignment: .leading)
                        .lineLimit(2)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                    
                }.padding(.bottom,40)
                
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(
                Color("orange")
                    .cornerRadius(15)
                    .clipShape(ItemCurve())
                    .padding(.bottom, 20)
            )
            
            NavigationLink(destination: {
                destinationView()
            }, label: {
                Image(systemName: "eye")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color("orange"))
                    .clipShape(Circle())
            })
            .offset(x:10,y:-10)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: BeerModel(), destinationView: {
            
        })
    }
}
