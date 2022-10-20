//
//  SpriteFiles.swift
//  DvdScreensaver
//
//  Created by rsbj on 18/10/22.
//

import SpriteKit

public class PongScene: SKScene {
    
    private let bolaNode: SKNode
    private var raqueteNode : SKNode
    private var moveTransform = CGAffineTransform(translationX: 3, y: -3)
    private var moveTransformRaquete = CGAffineTransform(translationX: 0, y: 0)
    
    
    public init(node: SKNode, size: CGSize, raquete: SKNode) {
        self.bolaNode = node
        self.raqueteNode = raquete
        super.init(size: size)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        addChild(bolaNode)
        addChild(raqueteNode)
        raqueteNode.position = CGPoint(x: self.frame.midX, y: CGFloat(Int(self.frame.minY)+45))
        bolaNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        raqueteNode.run(SKAction())
        bolaNode.run(SKAction())
    }
    
    var speeed : Float = 3
    
    // Update is called once per frame
    public override func update(_ currentTime: TimeInterval) {
        speeed = speeed + 0.00005
        
        // Collect a reference frame for the node's current position
        let currentFrame = bolaNode.calculateAccumulatedFrame()
        let frameRaquete = raqueteNode.calculateAccumulatedFrame()
        
        //        let ballPosition = currentFrame.midX // Used to determinate de side were the music is coming from
        //        let ballDistance = currentFrame.midY //Used to determinate the intensity of the music
        //        print("\(ballPosition) \(ballDistance)")
        
        // Top bound
        if currentFrame.maxY >= self.frame.maxY+10 {
            moveTransform.ty = CGFloat(-speeed)
        }
        
        // Right bound
        if currentFrame.maxX >= self.frame.maxX+10 {
            moveTransform.tx = CGFloat(-speeed)
        }
        
        // Bottom bound
        if frameRaquete.maxY >= currentFrame.minY+15 && currentFrame.minX <= frameRaquete.maxX-15 && currentFrame.maxX >= frameRaquete.minX+15 && frameRaquete.minY <= currentFrame.maxY-35{
            moveTransform.ty = CGFloat(+speeed)
        }
        
        // Left bound
        if currentFrame.minX <= self.frame.minX-15 {
            moveTransform.tx = CGFloat(+speeed)
        }
        
        // Update the node's position by applying the transform
        bolaNode.position = bolaNode.position.applying(moveTransform)
        
        raqueteNode.position = raqueteNode.position.applying(moveTransformRaquete)
        
    }
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let frameRaquete = raqueteNode.calculateAccumulatedFrame()
            
            let location = touch.location(in: self)
            
            if frameRaquete.maxX <= self.frame.maxX && frameRaquete.minX >= self.frame.minX{
                raqueteNode.position.x = location.x
            }
            
            // Right bound
            if frameRaquete.maxX >= self.frame.maxX {
                raqueteNode.position.x = raqueteNode.position.x - 3
            }

            // Left bound
            if frameRaquete.minX <= self.frame.minX {
                raqueteNode.position.x = raqueteNode.position.x + 3
            }
        }
    }
}
