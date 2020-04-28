//
//  UIViewControllerExtensions.swift
//  Pokedex
//
//  Created by Leonardo Diaz on 4/27/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
}
