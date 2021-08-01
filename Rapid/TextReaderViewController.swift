//
//  TextReaderViewController.swift
//  Rapid
//
//  Created by Apple on 11/28/19.
//  Copyright © 2019 ___MostafaSafaeipour___. All rights reserved.
//

import UIKit

class TextReaderViewController: UIViewController {

    @IBAction func GetBackToMainView(_ sender: Any) {
        let presentingViewController = self.presentingViewController
        self.dismiss(animated: false, completion: {
            presentingViewController?.dismiss(animated: true, completion: {})
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
