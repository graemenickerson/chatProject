//
//  MainMessageViewController.swift
//  Final Chat Project
//
//  Created by Graeme Nickerson on 2019-03-25.
//  Copyright © 2019 Graeme Nickerson. All rights reserved.
//

import UIKit
import AutoKeyboard

class MainMessageViewController: UIViewController {

    @IBOutlet var mainTable: UITableView!
    @IBOutlet var textInputField: UITextField!
    
    var getData : NetworkController = NetworkController()
    var thisUser = "Graeme"
    var messages: [NewMessages] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDataForTable()
        self.mainTable.dataSource = self
        self.textInputField.delegate = self
        self.scrollToBottom()
        
        //Timer
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true){ (timer) in
            self.getDataForTable()
        }
        
    }
    
    // Get Data from servers and refreshes message table
    func getDataForTable() {
        self.getData.getMessagesFromServer { (messages) in
            self.messages = messages
            self.mainTable.reloadData()
        }
    }

}

// MARK: - UITableViewDataSource

extension MainMessageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableCell", for: indexPath) as! UserTableCell
        let message = self.messages[indexPath.row]
        cell.cellLayoutControls(userName: message.userName, message: message.message)
        return cell
    }
    
    func scrollToBottom(){

        if self.mainTable.numberOfRows(inSection: 0) > 0 {
            self.mainTable.selectRow(at: IndexPath(row: self.messages.count - 1, section: 0), animated: true, scrollPosition: .bottom)
        }
    }

}

//MARK: - Text Field Handling
extension MainMessageViewController:  UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textInputField.text else { return }
        
        let toServer : NetworkController = NetworkController()
        toServer.sendMessagesToServer(username: thisUser, message: text)
        textInputField.text = ""
        self.scrollToBottom()
        textInputField.resignFirstResponder()
        
        self.getDataForTable()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard if the return key is pressed
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollToBottom()
    }
    
}

//MARK: - Auto Keyboard
extension MainMessageViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        registerAutoKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unRegisterAutoKeyboard()
    }
    
}


