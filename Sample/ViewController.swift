//
//  ViewController.swift
//  Sample
//
//  Created by akasaaa on 2018/04/05.
//  Copyright © 2018年 ichimots. All rights reserved.
//

import UIKit
import CommentViewer

class ViewController: UIViewController {
    
    @IBOutlet weak var commentView: CommentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            DispatchQueue.main.async { [unowned self] in
                self.commentView.addComment("CommentViewer")
            }
        }
    }
    
    @IBAction func didTapButton(_ sender:    UIButton) {
        commentView.addComment("https://github.com/akasaaa/CommentViewer")
    }
}

