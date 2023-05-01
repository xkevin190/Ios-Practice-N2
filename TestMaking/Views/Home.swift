//
//  Home.swift
//  TestMaking
//
//  Created by Kevin Velasco on 26/4/23.
//

import SwiftUI
import CameraView

protocol MyTextFieldDelegate {
    func didEnterText(_ text: String)
}

struct Home: View {
    @State var activeSheet = false
    @State var number = 1
    
    
    @ObservedObject var camera = CameraViewModel();
    @ObservedObject var ItemModel = ItemsViewModel();
    @ObservedObject var locationModel = LocationViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(ItemModel.Items)  { item in
                            NavigationLink(destination: Details(item: item) , label:  {
                                Item(image: UIImage(data: item.Image) ?? UIImage())
                            })
                        }
                    }
                    .font(.largeTitle)
                    .padding(.horizontal)
                    .padding(.top)
                }.frame(height: UIScreen.main.bounds.height * 0.8)
                Spacer()
                Button {
                    camera.openCamera = true
                    locationModel.getCurrentLocation()
                } label: {
                    VStack{
                        Text("Take picture")
                            .foregroundColor(.white)
                            .padding()
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .background(.red)
                    .cornerRadius(15)
                }.sheet(isPresented: $camera.openCamera, onDismiss: {
                    DispatchQueue.main.async {
                        camera.sesion.stopRunning()
                    }
                }){
                    CameraView(camera: camera).onChange(of: camera.imagePicked) { newData in
                        ItemModel.addNewItem(imageData: newData, location: locationModel.userLocation)
                        camera.openCamera = false
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Picture")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                    }
                }
            }
            .toolbarBackground(Color.red, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .background(.white)
            .onAppear {
                camera.check()
                locationModel.requestLocationPermission()
            }
            
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
