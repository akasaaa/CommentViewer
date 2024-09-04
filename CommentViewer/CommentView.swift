//
//  CommentView.swift
//  CommentViewer
//
//  Created by akasaaa on 2018/04/05.
//  Copyright © 2018年 ichimots. All rights reserved.
//

import UIKit


public class CommentView: UIView {
    
    // MARK: - Properties
    
    @IBInspectable
    public var textFontSize: CGFloat = 18
    
    @IBInspectable
    public var textColor: UIColor = UIColor.white
    
    @IBInspectable
    public var duration: Double = 4
    
    
    private var labelTagNumber = 9_999
    
    private lazy var lines: Int = {
        let label = createNewLabel(text: "Sample")
        return Int(self.frame.height / label.frame.height)
    }()
    
    private lazy var addedLines: [Int] = Array(repeating: 0, count: lines)
    
    
    // MARK: - Public Functions
    
    public func addComment(_ text: String) {

        let label = createNewLabel(text: text)
        label.tag = labelTagNumber
        if labelTagNumber > 9_000 {
            labelTagNumber -= 1
        } else {
            labelTagNumber = 9_999
        }
        let line = nextLine()
        self.addSubview(label)
        label.frame.origin.x = self.frame.width
        label.frame.origin.y = label.frame.height * CGFloat(line)
        addedLines[line - 1] += 1
        
        UIView.transition(with: label, duration: duration, options: .curveLinear, animations: {
            label.frame.origin.x = -label.frame.width
        }, completion: { [unowned self] _ in
            self.viewWithTag(label.tag)?.removeFromSuperview()
        })
        
        let limit = Double(label.frame.width * CGFloat(duration) / (self.frame.width + label.frame.width))
        DispatchQueue.main.asyncAfter(deadline: .now() + limit) { [unowned self] in
            self.addedLines[line - 1] -= 1
        }
    }
    
    
    // MARK: - Private Functions
    
    private func nextLine() -> Int {
        if let emptyLine = addedLines.enumerated().filter({ $0.element == 0 }).first?.offset {
            return emptyLine + 1
        } else if let min = addedLines.enumerated().min(by: { $0.element < $1.element })?.offset {
            return min + 1
        } else {
            return 1
        }
    }
    
    private func createNewLabel(text: String) -> UILabel {
        let label = UILabel()
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 1 // TODO: set 0

        label.font = UIFont.systemFont(ofSize: textFontSize)
        label.textColor = textColor
        label.text = text
        label.sizeToFit()

        return label
    }
    
    
}
