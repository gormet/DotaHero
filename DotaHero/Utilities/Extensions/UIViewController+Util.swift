//
//  UIViewController+Util.swift
//  CodableCoredata
//
//  Created by Nithin Kumar on 02/04/2020.
//  Copyright © 2020 Nithin Kumar. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(_ title: String?, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
}
