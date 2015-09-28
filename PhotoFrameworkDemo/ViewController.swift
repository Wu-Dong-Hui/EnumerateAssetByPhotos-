//
//  ViewController.swift
//  PhotoFrameworkDemo
//
//  Created by Roy on 15/9/25.
//  Copyright © 2015年 Pixshow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
//        let button = UIButton(type: .Custom)
//        button.frame = CGRect(x: 100, y: 100, width: 150, height: 50)
//        button.setAttributedTitle(NSAttributedString(string: "click me", attributes: [NSForegroundColorAttributeName: UIColor.blackColor(), NSFontAttributeName: UIFont.systemFontOfSize(18)]), forState: .Normal)
//        view.addSubview(button)
//        button.addTarget(self, action: "buttonCLicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.title = "Photos Demo"
        
    }
    @IBAction func imagesClicked(sender: UIButton) {
        let vc = PhotoCollectionController(mediaType: .Image)
        vc.title = "Images"
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func videosClcked(sender: UIButton) {
        
        let vc = PhotoCollectionController(mediaType: .Video)
        vc.title = "Videos"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

