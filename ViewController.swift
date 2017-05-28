//
//  ViewController.swift
//  GoToSea
//
//  Created by kpugame on 2017. 5. 10..
//  Copyright © 2017년 Jae Won Yoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    var loc :String?
    @IBOutlet var locateButtons: [UIButton]!

    @IBAction func SelectLocate(_ sender: Any) {
        for(index, button) in locateButtons.enumerated(){
            if(button.isEqual(sender)){
                loc = button.titleLabel?.text
                
                performSegue(withIdentifier: "showDateView", sender: self)
               
            }
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if(segue.identifier == "showDateView")
        {
            if let dateViewController = segue.destination as? DateViewController{
                dateViewController.locate = loc
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

