//
//  LoginViewController.swift
//  Rapid
//
//  Created by Apple on 10/28/19.
//  Copyright © 2019 ___MostafaSafaeipour___. All rights reserved.
//

import UIKit
import MBProgressHUD
class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var LoginTextField: RapidTextField!
    let generator = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginTextField.delegate = self
        LoginTextField.addTarget(self, action: #selector(LoginViewController.changedText) , for: .editingChanged)
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(red: 242.0, green: 241.0, blue: 239.0, alpha: 1.0),NSAttributedString.Key.font: UIFont.init(name: "B Yekan", size: 27.0)!]
        self.title = "ورود"
        
        
        let backButtonBackgroundImage = #imageLiteral(resourceName: "back")
        self.navigationController?.navigationBar.backIndicatorImage = backButtonBackgroundImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 242.0, green: 241.0, blue: 239.0, alpha: 1.0)
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LoginTextField.setForRapid(RapidPlaceHolder: "شماره تلفن همراه خود را وارد نمایید", isPersian: true)
        LoginTextField.becomeFirstResponder()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func isNumberValid(Number:String) -> Bool {
        switch Number.count {
        case 11:
            if Number.hasPrefix("09"){
                return true
            }else{
                return false
            }
        case let x where x > 11:
            return false
        default:
            return false
        }
    }
    
   @objc func changedText() {
        if isNumberValid(Number: LoginTextField.text!){
            print("Data To Server")
            self.view.endEditing(true)
            MBProgressHUD.showAdded(to: self.view, animated: true)
            DispatchQueue.global(qos: .userInteractive).async{
                //Data To Server
                DispatchQueue.main.async {
                    self.generator.notificationOccurred(.success)
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.performSegue(withIdentifier: "PresetMainViewController", sender: self)
                }
            }
        }else if LoginTextField.text!.count >= 11{
            self.generator.notificationOccurred(.error)
            let alert = UIAlertController(title: "خطا", message: "شماره تلفن وارد شده صحیح نمی باشد.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "باشه", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            LoginTextField.text = ""
        }
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
