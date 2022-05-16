//
//  Info.swift
//  GoalBeer
//
//  Created by Elvis Reyes on 15/5/22.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.openURL) var openURL
    var body: some View {
        VStack{
            List{
                Section{
                    HStack{
                        Spacer()
                        VStack(alignment: .center){
                            Image("me-profile")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100)
                            Text("Elvis Reyes")
                                .font(.largeTitle)
                            HStack{
                                Text("684 502 350")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("@teclaelvis01")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }.listRowBackground(Color(""))
                }
                
                Section{
                    Button {
                        openURL(URL(string: "https://www.linkedin.com/in/teclaelvis01/")!)
                    } label: {
                        HStack{
                            Image("linkedin")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            Text("Linkedin")
                            Spacer()
                            Image(systemName: "arrow.up.forward")
                        }
                    }
                    
                    Button {
                        openURL(URL(string: "https://www.elvisreyes.com/")!)
                    } label: {
                        HStack{
                            Image(systemName: "network")
                            Text("Website")
                            Spacer()
                            Image(systemName: "arrow.up.forward")
                        }
                    }
                    
                    Button {
                        openURL(URL(string: "https://github.com/teclaelvis01")!)
                    } label: {
                        HStack{
                            Image("github")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            Text("GitHub")
                            Spacer()
                            Image(systemName: "arrow.up.forward")
                        }
                    }
                    
                    Button {
                        openURL(URL(string: "https://t.me/teclaelvis01")!)
                    } label: {
                        HStack{
                            Image("telegram")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            Text("Telegram")
                            Spacer()
                            Image(systemName: "arrow.up.forward")
                        }
                    }
                    
                    Button {
                        openURL(URL(string: "https://wa.me/34684502350")!)
                    } label: {
                        HStack{
                            Image("whatsapp")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Whatsapp")
                            Spacer()
                            Image(systemName: "arrow.up.forward")
                        }
                    }
                    
                    Button {
                        openURL(URL(string: "tel://684502350")!)
                    } label: {
                        HStack{
                            Image(systemName: "phone")
                            Text("Mobile")
                            Spacer()
                            Image(systemName: "arrow.up.forward")
                        }
                    }
                    
                

                    
                }
                

                
            }
        }
    }
}

struct Info_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
