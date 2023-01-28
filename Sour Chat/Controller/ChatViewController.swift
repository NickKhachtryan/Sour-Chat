//
//  ChatViewController.swift
//  Sour Chat
//
//  Created by Nick Khachatryan on 15.01.2021.
//

import UIKit
import Firebase
//import IQKeyboardManager

class ChatViewController : UIViewController{
    
    
    //  MARK: - IBOUTLET PROPERTIES
    @IBOutlet weak var chatTF: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    
    
    //  MARK: - CUSTOM PROPETRIES
    let db = Firestore.firestore()
    var messages : [Message] = []
    let sourColor = CGColor(red: 255, green: 150, blue: 0, alpha: 1.0)
    
    
    //  MARK: - CYCLES CONTROLLERS
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.dataSource = self
        //        chatTableView.delegate = self
        chatTF.setSourColorAndBorderWidth()
        navigationItem.hidesBackButton = true
        //        navigationItem.title = "Sour Chat"
        title = "Sour Chat"
        chatTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        readDataFromFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: ACTIONS
    @IBAction func pressedLogOutButton(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
            UserDefaults.standard.set(false, forKey: KPlist.succesfulLogin)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func pressedSendMessage(_ sender: UIButton) {
        guard let emailUser = Auth.auth().currentUser?.email , let message = chatTF.text , message != "" else {return}
        let secondsFrom1970Year = Date().timeIntervalSince1970
        // Add a new document with a generated ID
        var ref: DocumentReference?
        ref = db.collection(K.keyAllMessages).addDocument(data: [
            K.keyUserEmail : emailUser,
            K.keyMessage : message,
            K.keyDate : secondsFrom1970Year
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.chatTF.text = ""
                
//                self.readDataFromFirebase()
            }
        }
    }
    
    
    // MARK: FUNCTIONS
    func readDataFromFirebase(){
        db.collection(K.keyAllMessages).order(by: K.keyDate).addSnapshotListener { (querySnapshot, err) in
            self.messages = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let safeSnapshot = querySnapshot?.documents else {return}
                for document in safeSnapshot {
                    //                    print("\(document.documentID) => \(document.data())")
                    guard let sender = document.data()[K.keyUserEmail] as? String , let message = document.data()[K.keyMessage] as? String else {return}
                    let dataFromFB = Message(sender: sender, message: message)
                    self.messages.append(dataFromFB)
                }
                print(self.messages)
                DispatchQueue.main.async {
                    self.chatTableView.reloadData()
                    self.chatTableView.scrollToRow(at: IndexPath.init(row: self.messages.count - 1, section: 0), at: .top, animated: true)
                }
            }
        }
    }
}


//  MARK: - EXTENSIONS
extension ChatViewController : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellProt = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MessageTableViewCell
        
        //        cellProt.textLabel?.text = "\(indexPath.row + 1) \(messages[indexPath.row].message)"
        
        cellProt.chatLabel.text = "\(messages[indexPath.row].message)"
        
        if Auth.auth().currentUser?.email == messages[indexPath.row].sender{
            cellProt.chatBG.image = #imageLiteral(resourceName: "chatBackgroundRight")
            cellProt.avatarGirlIMG.isHidden = true
            cellProt.avatarBoyIMG.isHidden = false

        } else {
            cellProt.chatBG.image = #imageLiteral(resourceName: "chatBackgroundLeft")
            cellProt.avatarGirlIMG.isHidden = false
            cellProt.avatarBoyIMG.isHidden = true
        }
        
        return cellProt
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        //        print("didSelectRowAt",indexPath.row)
    //        print("\(indexPath.row + 1) \(messages[indexPath.row].message)")
    //        let myCell = tableView.cellForRow(at: indexPath)
    //        print(myCell?.textLabel?.text)
    //    }
    
}













