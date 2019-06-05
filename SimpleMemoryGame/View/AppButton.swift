//
//  AppButton.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 24/04/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import SpriteKit

protocol ButtonDelegate: class {
    func onTap(sender: AppButton)
}

class AppButton: SKShapeNode {
    
    weak var delegate: ButtonDelegate?
    private var textNode = SKLabelNode()
    
    private var originalColor = SKColor.white
    var highlightColor: SKColor?
    
    func setText(text: String) {
        if textNode.parent == nil {
            addChild(textNode)
            textNode.fontName = "Futura"
            textNode.fontSize = 15
            textNode.verticalAlignmentMode = .center
            textNode.fontColor = .white
            textNode.position = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
        }
        textNode.text = text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let highlightColor = highlightColor {
            self.textNode.fontColor = .white
            originalColor = fillColor
            fillColor = highlightColor
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = highlightColor {
            fillColor = originalColor
            self.textNode.fontColor = .white
        }
        if let touch = touches.first, let parent = parent {
            if frame.contains(touch.location(in: parent)) {
                if let delegate = delegate {
                    delegate.onTap(sender: self)
                }
            }
        }
    }
    
}
