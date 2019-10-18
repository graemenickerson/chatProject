//
//  NewtorkController.swift
//  Final Chat Project
//
//  Created by Graeme Nickerson on 2019-04-01.
//  Copyright © 2019 Graeme Nickerson. All rights reserved.
//

import Foundation
import Alamofire

class NetworkController {
    
    
    //ULR of message server
    var serverULRString : String = "http://localhost:1337/messages"
    
    //MARK: - GET FROM SERVER
    func getMessagesFromServer (completion: @escaping ([NewMessages]) -> ()) {
        
        Alamofire.request(serverULRString).responseJSON { (response) in
            //set resopnse to messages array
            if let MessagesOnServer = response.result.value as? [AnyObject] {
                
                var messages: [NewMessages] = []
                for messageAtIndex in MessagesOnServer {
                    let userId = messageAtIndex["username"] as! String
                    let message = messageAtIndex["text"] as! String
                    let newMessage = NewMessages(userName: userId, message: message)
                    messages.append(newMessage)
                }
                completion(messages)
            }
            
        }
    }
    
    //MARK: - SEND TO SERVER
    func sendMessagesToServer (username: String, message: String) {
        
        let APIMessageKey = "text"
        let APIUsernameKey = "username"
        
        let postPerameters: Dictionary = [ APIMessageKey: message, APIUsernameKey: username ]
        
        Alamofire.request(serverULRString, method: .post, parameters: postPerameters).response { (response) in
            //print(response)
        }
    }

}
