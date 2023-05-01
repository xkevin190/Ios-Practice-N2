//
//  Details.swift
//  TestMaking
//
//  Created by Kevin Velasco on 30/4/23.
//

import SwiftUI

struct Details: View {
    
    var item: Card;
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var screen = UIScreen.main.bounds
    
    var body: some View {
        NavigationView {
            VStack(){
                Image(uiImage:  UIImage(data: item.Image) ?? UIImage())
                .resizable()
                .frame(width: screen.width * 0.8, height: screen.height * 0.5)
                .background(.yellow)
                .cornerRadius(20)
                .padding(.top, screen.height * 0.04)
                .shadow(color: .black.opacity(0.6), radius: 8, x: 4, y: 3)
                
                
                Image("location")
                    .resizable()
                    .frame(width: screen.width * 0.2, height: screen.width * 0.2)
                    .cornerRadius(30)
                    .padding(.top)
                    .shadow(color: .black.opacity(0.6), radius: 4, x: 4, y: 3)
                
                VStack {
                    Text("Postal code: \(item.localtion.postalCode)")
                    Text(item.localtion.address)
                    Text(item.localtion.country)
                    
                }
                
                Spacer()
            }
            .toolbarBackground(Color.red, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.backward").foregroundColor(.white).font(.system(size: 20))
                        }
                        
                        Spacer()
                        Text("Picture Details")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                        Spacer()
                        
                        Image(systemName: "chevron.backward").foregroundColor(.red).font(.system(size: 20))
                        
                    }.background(.red)
                }
            }
            
        }.navigationBarBackButtonHidden(true)
        
    }
}

struct Details_Previews: PreviewProvider {
    static var previews: some View {
        Details(item: Card(localtion: UserLocation(postalCode: "unknow", city: "unknow", country: "unknow", address: "unknow"), Image: Data(count: 0)))
    }
}
