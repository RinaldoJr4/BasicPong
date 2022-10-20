//
//  ContentView.swift
//  DvdScreensaver
//
//  Created by rsbj on 18/10/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
   // @Binding var react: CGRect
    
    var body: some View {
        GeometryReader{
            geo in
          //  self.react = geo.frame(in: .global)
            SpriteView(scene: scene)
                .frame(width: geo.size.width, height: geo.size.height)
        }.ignoresSafeArea()
    }
    
    var scene: SKScene{

        let viewFrame = CGRect(x: 0.5, y: 0.5, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let view = SKView(frame: viewFrame)
        print("\(UIScreen.main.bounds.width)")
        let dvdNode = SKSpriteNode(imageNamed: "neonBall")
        dvdNode.size = CGSize(width: 60, height: 60)
        
        let raqueteNode = SKSpriteNode(color: .purple, size: CGSize(width: 150, height: 20))
        
        let scene = PongScene(node: dvdNode, size: view.frame.size, raquete: raqueteNode)
        scene.scaleMode = .aspectFit
        
        scene.backgroundColor = .white
        
        return scene
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
