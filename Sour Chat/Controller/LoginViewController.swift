//
//  LoginViewController.swift
//  Sour Chat
//
//  Created by Nick Khachatryan on 15.01.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController{
    
    
    // MARK: OUTLETS
    @IBOutlet weak var loginEmailTF: UITextField!
    @IBOutlet weak var passwordLoginTF: UITextField!
    
    
    // MARK: VC LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginEmailTF.setSourColorAndBorderWidth()
        passwordLoginTF.setSourColorAndBorderWidth()
        
        if  UserDefaults.standard.bool(forKey: "succesfulLogin"){
            self.performSegue(withIdentifier: KSegues.fromLoginToChat, sender: self)
        }
//        print( UserDefaults.standard.bool(forKey: "succesfulLogin"))
//        print(UserDefaults.standard.string(forKey: "someKey"))
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
//        print(UUID())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: ACTIONS
    @IBAction func pressedLogin(_ sender: UIButton) {
        guard let email = loginEmailTF.text , let password = passwordLoginTF.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let self = self else { return }
            if let errorr = error{
                print(errorr.localizedDescription)
            } else {
                
                UserDefaults.standard.set(true, forKey: "succesfulLogin")
                
                self.performSegue(withIdentifier: KSegues.fromLoginToChat, sender: self)
            }
        }
    }
    
    @IBAction func pressedGoToRegister(_ sender: UIButton) {
    }
}

//  MARK: - EXTENSIONS

extension UITextField {
    
    func setSourColorAndBorderWidth(){
        self.layer.borderColor =  CGColor(red: 255, green: 150, blue: 0, alpha: 1.0)
        
        self.layer.borderWidth = 2
    }
    
    
    
}















