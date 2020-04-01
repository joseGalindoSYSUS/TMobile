//
//  Decorator.swift
//  TMobile
//
//  Created by Jose Galindo martinez on 01/04/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit

class Decorator: NSObject {
}

extension UIViewController {
    
    func showErrorMessage(_ message : String) {
        let alertc = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertc, animated: true, completion: nil)
    }
}
