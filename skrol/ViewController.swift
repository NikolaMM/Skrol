//
//  ViewController.swift
//  skrol
//
//  Created by Nikola Milenkovic on 5/11/17.
//  Copyright © 2017 Nikola Milenkovic. All rights reserved.
//

import UIKit

var broj = 0

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

    var snap : UISnapBehavior!
    var animator : UIDynamicAnimator!
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeSkrol()
        makeImageView()
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan(_:)))
        view.addGestureRecognizer(pan)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secoundVC = segue.destination as! SecoundViewController
        secoundVC.transitioningDelegate = self
        secoundVC.modalPresentationStyle = .custom
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .present
        transition.startingPoint = CGPoint(x: (viewN?.center.x)! - skrol.contentOffset.x, y: skrol.center.y)//(viewN?.center)!
        transition.circleColor = .black
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .dismiss
        transition.startingPoint = CGPoint(x: (viewN?.center.x)! - skrol.contentOffset.x, y: skrol.center.y )
        transition.circleColor = .black
        
        return transition
    }
    
    
    var razmak:CGFloat = 0
    
    func pan(_ sender: UIPanGestureRecognizer){
        
        let translation = sender.translation(in: self.view)
        let startPoint = CGPoint.zero
        let distance = Double(translation.y - startPoint.y)
        
        
        if sender.state == .began {
            
            razmak = skrol.frame.origin.y - sender.location(in: view).y
        }
      skrol.frame.origin.y = sender.location(in: view).y + razmak
        
        if skrol.frame.origin.y < view.frame.height - 160 {
          skrol.frame.origin.y = view.frame.height - 160
        } else if skrol.frame.origin.y > view.frame.height - 20 {
          skrol.frame.origin.y = view.frame.height - 20
        }
        
        
        if sender.state == .ended && skrol.frame.origin.y > view.frame.height - 160 && skrol.frame.origin.y < view.frame.height - 90{
            
            UIView.animate(withDuration: 0.5, animations: {
                self.skrol.frame.origin.y = self.view.frame.height - 160
            })
            
        }
        
        else if sender.state == .ended && skrol.frame.origin.y > view.frame.height - 90 && skrol.frame.origin.y < view.frame.height - 20{
            
            UIView.animate(withDuration: 0.5, animations: {
                self.skrol.frame.origin.y = self.view.frame.height - 20
            })
            //skrol.frame.origin.y = view.frame.height - 20
        }
        
        if  distance > 0 {
            if sender.state == .ended {
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.skrol.frame.origin.y = self.view.frame.height - 20
                })
                
                //skrol.frame.origin.y = view.frame.height - 20
            }
            
        }
        
    }
  
    let skrol = UIScrollView()
    
    func makeSkrol() {
        
        skrol.frame = CGRect(x: 0, y: view.frame.size.height - 160 , width: view.frame.size.width, height: 200)
        skrol.backgroundColor = .clear
        skrol.contentSize = CGSize(width: (10 * 100) + 110, height: 200)
        skrol.tag = 100
        view.addSubview(skrol)
        
    }
    
    func makeImageView() {
        
        let razmak:CGFloat = 10
        
        for i in 0...9 {
            
            let slika = UIImageView()
            slika.isUserInteractionEnabled = true
            slika.tag = i
            slika.frame.size = CGSize(width: 100, height: 200)
            slika.frame.origin = CGPoint(x: (CGFloat(i) * 100) + (razmak * (CGFloat(i) + 1)), y: 0)
            slika.layer.cornerRadius = 20
            slika.layer.masksToBounds = true
            slika.image = UIImage(named: "img\(i + 1)")
            
            skrol.addSubview(slika)
           
            slika.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tap(_:))))
            
        
        }
        
        
    }
    
    var viewN: UIView?
    
    func tap(_ sender: UITapGestureRecognizer){
       
        viewN = sender.view
        //print(Int(skrol.contentOffset.x) / 10 )
        broj = (sender.view?.tag)!
        performSegue(withIdentifier: "xxx", sender: self)
        
    }

    
    
    
    
}

