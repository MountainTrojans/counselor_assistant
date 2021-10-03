//
//  AccountModel.swift
//  counselor_assistant
//
//  Created by Zhenghao Dai on 10/2/21.
//

import Foundation

class AccountModel:NSObject{
    //singleton
    static let sharedInstance = AccountModel()
    var gmail:String?
    
    private func extractEmail(email: String) -> String {
        let components = email.components(separatedBy: "@")
        return components[1]
    }
    
    func validateEmail(email:String)->Bool{
       
        print(extractEmail(email: email))
        
        return false
    }
    
}
