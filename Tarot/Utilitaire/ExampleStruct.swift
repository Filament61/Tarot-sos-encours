//
//  ExampleStruct.swift
//  Tarot
//
//  Created by Serge Gori on 14/06/2019.
//  Copyright © 2019 Serge Gori. All rights reserved.
//

import Foundation

struct Account {
    var name: String
    init(name: String) {
        self.name = name
    }
}

struct AccountViewModel {
    private var account: Account
    
    var accountName: String {
        return "Account Name >>>>> " + self.account.name
    }
    
    init(acc: Account) {
        self.account = acc
    }
    
    mutating func updateAccountName(name: String) {
        self.account.name = name
    }
}

let acc = Account.init(name: "First Account")
//print("Account Name >>>>>", acc.name)

var accountVM: AccountViewModel?
//accountVM = AccountViewModel.init(acc: acc)

//if var accVM = accountVM {
//    accVM.updateAccountName(name: "Update Name")
//}

//print(accountVM?.accountName ?? "")
