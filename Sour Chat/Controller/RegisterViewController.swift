//
//  RegisterViewController.swift
//  Sour Chat
//
//  Created by Nick Khachatryan on 15.01.2021.
//

import UIKit
import Firebase

class RegisterViewController : UIViewController{
    
    
    // MARK: OUTLETS
    @IBOutlet weak var registerEmailTF: UITextField!
    @IBOutlet weak var passwordRegisterTF: UITextField!
    
    
    // MARK: VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerEmailTF.setSourColorAndBorderWidth()
        passwordRegisterTF.setSourColorAndBorderWidth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: ACTIONS
    @IBAction func pressedRegister(_ sender: UIButton) {
        guard let email = registerEmailTF.text , let password = passwordRegisterTF.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "fromRegisterToChat", sender: self)
            }
        }
    }
}















