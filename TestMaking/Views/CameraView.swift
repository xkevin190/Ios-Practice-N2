//
//  CameraView.swift
//  TestMaking
//
//  Created by Kevin Velasco on 28/4/23.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @ObservedObject var camera: CameraViewModel
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                HStack() {
                    Button {
                        camera.ToogleFlash()
                    } label: {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(camera.flash ? .yellow : .white)
                            .font(.system(size: 25))
                            .padding(.top)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.bottom, UIScreen.main.bounds.height * 0.04)
                
                
                
                CameraPriew(camera: camera)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.65, alignment: .top)
                
                
                Text("PHOTO").foregroundColor(.yellow).padding(.vertical)
                
                HStack {
                    
                    Button {
                        camera.openCamera = false
                    } label: {
                        Text("Cancel").font(.system(size: 22))
                    }.padding(.horizontal).foregroundColor(.white)
                    
                    Spacer()
                    
                    Button {
                        camera.TakePicture()
                    } label: {
                        ZStack {
                            Circle().fill(Color.white).frame(width: 60, height: 60)
                            Circle().stroke(Color.white, lineWidth: 8).frame(width: 75, height: 75)
                        }
                        
                    }
                    Spacer()
                    
                    Button {
                        camera.toggleCamera()
                    } label: {
                        ZStack {
                            Circle().fill(Color.white.opacity(0.2)).frame(width: 60, height: 60)
                            Image(systemName: "arrow.triangle.2.circlepath").font(.system(size: 25)).foregroundColor(.white)
                        }
                    }.padding(.horizontal)
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct CameraPriew: UIViewRepresentable {
    @ObservedObject var camera: CameraViewModel
    
    func makeUIView(context: Context) -> some UIView {
        
        let screenSize = UIScreen.main.bounds.size
        let viewSize = CGSize(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
        let viewOrigin = CGPoint(x: (screenSize.width - viewSize.width) / 2, y: 0)
        let viewFrame = CGRect(origin: viewOrigin, size: viewSize)
        
        let View = UIView(frame: viewFrame)
        
        
        DispatchQueue.main.async {
            camera.preview = AVCaptureVideoPreviewLayer(session: camera.sesion)
            camera.preview.frame = View.frame
            camera.preview.videoGravity = .resize
            
            View.layer.addSublayer(camera.preview)
            
            DispatchQueue.global(qos: .background).async {
                camera.sesion.startRunning()
            }
        }
        
        return View
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(camera: CameraViewModel())
    }
}
