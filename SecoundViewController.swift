//
//  SecoundViewController.swift
//  skrol
//
//  Created by Nikola Milenkovic on 5/14/17.
//  Copyright © 2017 Nikola Milenkovic. All rights reserved.
//

import UIKit

class SecoundViewController: UIViewController {


    let labela = UILabel()
    
    @IBOutlet weak var slika: UIImageView!
    
    func makeLabela() {
        
        labela.frame = CGRect(x: 90, y: 20, width: 200, height: 50)
        whiteView.addSubview(labela)
        labela.textColor = .black
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labela.layer.opacity = 0
        button()
        makeWhiteView()
        makeLabela()
        whiteView.center.y += 300
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
            self.labela.layer.opacity = 1
            self.butt.layer.opacity = 1
            self.whiteView.center.y -= 300
            
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                
                self.labela.layer.opacity = 0
                self.butt.layer.opacity = 0
                self.whiteView.center.y += 300
                
            }, completion: nil)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        labela.text = String(broj)
        slika.image = UIImage(named: "img\(broj + 1)")
    }
    
    let butt = UIButton()

    func button () {
        butt.layer.opacity = 0
        butt.layer.cornerRadius = 25
        butt.frame = CGRect(x: 20, y: 20 , width: 50, height: 50)
        butt.backgroundColor = .black
        butt.setTitle("Back", for: .normal)
        butt.tintColor = .white
        butt.addTarget(self, action: #selector(SecoundViewController.klik(_:)), for: .touchUpInside)
        whiteView.addSubview(butt)
    }
    
    let whiteView = UIView()
    
    func makeWhiteView() {
        
        whiteView.backgroundColor = .white
        whiteView.frame = CGRect(x: 0, y: view.frame.height - 300, width: view.frame.width, height: 400)
        view.addSubview(whiteView)
        
    }
    
        
    

    func klik(_ sender: UIButton){
        dismiss(animated: true, completion: nil)
    }
}
