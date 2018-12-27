//
//  ViewController.swift
//  Animation_grid
//
//  Created by Danni on 12/27/18.
//  Copyright © 2018 Danni Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        calculate appropriate width and height
        let numViewPerRow:CGFloat = 32
        let viewSize = view.frame.size
        let iphone = Int(viewSize.height/viewSize.width)
        let ipad = Int(viewSize.width/viewSize.height)
        let maxValue = max(iphone, ipad)
        let numViewPerColom:CGFloat = CGFloat(maxValue*Int(numViewPerRow))
        let width:CGFloat = viewSize.width/numViewPerRow
        let height:CGFloat = viewSize.height/numViewPerColom
        let totalGrid = Int(numViewPerColom*numViewPerRow)
        //        initialize grids
        for i in 0..<totalGrid{
            let columIndex = i%Int(numViewPerRow)
            let lineIndex = i/Int(numViewPerRow)
            let randomView = UIView()
            view.addSubview(randomView)
            randomView.layer.borderColor = UIColor.black.cgColor
            randomView.layer.borderWidth = 0.5
            randomView.backgroundColor = randomColor()
            randomView.frame = CGRect(x: CGFloat(columIndex)*width, y: CGFloat(lineIndex)*height, width: width, height: height)
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gestureRecognizer:)))
            randomView.addGestureRecognizer(panGestureRecognizer)
        }
    }
    
    //  zoom in and fade the grids
    @objc private func handlePanGesture(gestureRecognizer:UIPanGestureRecognizer){
        
        let pressLocation = gestureRecognizer.location(in: view)
        
        if let foundView = view.hitTest(pressLocation, with: nil){
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                foundView.layer.transform = CATransform3DMakeScale(3, 4, 4)
            }) { (_) in
                UIView.animate(withDuration: 0.3, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                    foundView.layer.transform = CATransform3DIdentity
                }, completion: nil)
            }
        }
        
    }
    
    
    
    //   randomly generate color for grids
    private func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 0.9)
    }
    
}

