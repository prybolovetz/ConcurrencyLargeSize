//
//  ViewController.swift
//  ConcurrencyLargeSize
//
//  Created by Ivan on 12/17/18.
//  Copyright © 2018 Ivan Prybolovetz. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myImage: UIImageView!
    @IBAction func buttonOne(_ sender: UIButton) {
        updateImage(button: 1)
    }
    @IBAction func buttonTwo(_ sender: UIButton) {
        updateImage(button: 2)
    }
    @IBAction func buttonThree(_ sender: UIButton) {
        updateImage(button: 3)
    }
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    func updateImage(button: Int) {
        self.indicator.startAnimating()
        var imageURL = URL(string: "")
        switch button {
        case 1:
            imageURL = URL(string: "https://bipbap.ru/wp-content/uploads/2017/10/0_8eb56_842bba74_XL-640x400.jpg")
        case 2:
            imageURL = URL(string:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAJfADs0uIpvt_UzCdVOOo_HRmzxP8fWZP0Yi9oUHveCSVoYWN")
        case 3:
            imageURL = URL(string:"https://ic.pics.livejournal.com/i_r_k_a/52491789/347470/347470_900.jpg")
        default:
            break
        }
        
        // Asynchronous
        DispatchQueue.global(qos: DispatchQoS.userInitiated.qosClass).async {
            let fetch = NSData(contentsOf: imageURL! as URL)
            DispatchQueue.main.async {
                if let imageData = fetch {
                    self.indicator.stopAnimating()
                    self.myImage.image = UIImage(data: imageData as Data)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myImage.layer.cornerRadius = 50.0
        myImage.layer.masksToBounds = true
        self.indicator.stopAnimating()
    }
}
