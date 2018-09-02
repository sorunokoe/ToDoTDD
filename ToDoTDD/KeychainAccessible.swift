//
//  KeychainAccessible.swift
//  ToDoTDD
//
//  Created by Mac on 31.08.2018.
//  Copyright © 2018 salgara. All rights reserved.
//

import Foundation
protocol KeychainAccessible {
    func setPassword(password: String,
                     account: String)
    
    func deletePasswortForAccount(account: String)
    
    func passwordForAccount(account: String) -> String?
}
