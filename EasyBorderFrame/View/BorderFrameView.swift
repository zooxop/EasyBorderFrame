//
//  ContentView.swift
//  EasyBorderFrame
//
//  Created by 문철현 on 2023/03/29.
//

import SwiftUI

struct BorderFrameView: View {
    @State var imageClipboard: NSImage?
    @State var isHover: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Color.gray
                        .opacity(0.2)
                        .ignoresSafeArea()
                    
                    if let image = imageClipboard {
                        Image(nsImage: image)
                            .resizable()
                            .foregroundColor(.green)
                            .scaledToFit()
                    } else {
                        Image(systemName: "photo.artframe")
                            .resizable()
                            .foregroundColor(.green)
                            .scaledToFit()
                    }
                }
                .frame(width: 300, height: 250)
                .padding(.top, 5)
                
                
                Button {
                    
                } label: {
                    Text("Copy to Clip board")
                        .frame(maxWidth: geometry.size.width - 10, maxHeight: 40)
                        .font(.title3)
                }
                .buttonStyle(CustomButtonStyle())

                Text("Hover Effect")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            //.trim(from: isHover ? 0 : 1, to: 1)
                            .stroke(Color.black.opacity(1), lineWidth: 1)
                    )
                    .scaleEffect(isHover ? 1.2 : 1)
                    .animation(.spring())
                    .onHover { hover in
                        isHover = hover
                    }
                
                Spacer()
            }
            .background(Color.white)
        }
        .frame(width: 300, height: 500)
        .onAppear {
            let pasteboard = NSPasteboard.general
            if let data = pasteboard.data(forType: .tiff),
               let image = NSImage(data: data) {
                self.imageClipboard = image
            }
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    @State private var isHover: Bool = false
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(isHover ? .green : .red)
            .background(configuration.isPressed ? Color.white : Color.blue)
            .cornerRadius(15.0)
            .onHover { hover in
                isHover = hover
            }
    }
}

struct BorderFrameView_Previews: PreviewProvider {
    static var previews: some View {
        BorderFrameView()
    }
}
