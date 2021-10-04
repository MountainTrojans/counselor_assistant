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
    var isSigned:Bool
    var isAdmin:Bool
    
    //init of the data model
    override init(){
        isSigned = false
        isAdmin = false
    }
    
    private func extractEmail(email: String) -> String {
        let components = email.components(separatedBy: "@")
        if(!components.isEmpty){
            return components[1]
        }
        return "";
    }
    
    func validateEmail(email:String)->Bool{
        let domain = extractEmail(email: email)
        if domain == "mountaincounseling.org"{
            isSigned = true;
            return true
        }
        return false
        
    }
    
}
