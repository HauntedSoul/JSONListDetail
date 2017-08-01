//
//  UserModel.swift
//  JSONListDetail
//
//  Created by Vitor Dinis on 01/08/2017.
//  Copyright © 2017 Vitor Dinis. All rights reserved.
//

import Foundation


struct UserModel {
    let id:Int
    let name:String
    let username:String
    let email:String
    let address:[String:Any]
    let phone:String
    let website:String
    let company:[String:Any]
    var comments:[[String:Any]]
    
    init(data:[String:Any]) {
        id = data["id"] as! Int
        name = data["name"] as! String
        username = data["username"] as! String
        email = data["email"] as! String
        address = data["address"] as! [String:Any]
        phone = data["phone"] as! String
        website = data["website"] as! String
        company = data["company"] as! [String:Any]
        comments = []
    }
}

/*
{
    "id": 1,
    "name": "Leanne Graham",
    "username": "Bret",
    "email": "Sincere@april.biz",
    "address": {
        "street": "Kulas Light",
        "suite": "Apt. 556",
        "city": "Gwenborough",
        "zipcode": "92998-3874",
        "geo": {
            "lat": "-37.3159",
            "lng": "81.1496"
        }
    },
    "phone": "1-770-736-8031 x56442",
    "website": "hildegard.org",
    "company": {
        "name": "Romaguera-Crona",
        "catchPhrase": "Multi-layered client-server neural-net",
        "bs": "harness real-time e-markets"
    }
}
*/
