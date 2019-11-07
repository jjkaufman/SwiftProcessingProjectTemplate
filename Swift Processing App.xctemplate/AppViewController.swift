//
//  ViewController.swift
//  SwiftProcessingTesting
//
//  Created by Jonathan Kaufman on 10/29/19.
//  Copyright © 2019 Jonathan Kaufman. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewDidAppear(_ animated: Bool) {

        
        let sketch = self.view as! MySketch
        if sketch.isFaceMode {
            let faceViewController = self.storyboard!.instantiateViewController(withIdentifier: "faceViewController") as! FaceViewController
            self.present(faceViewController, animated: false, completion: nil)
        }
    }
    
    
}

