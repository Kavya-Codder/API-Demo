//
//  CreateEmp.swift
//  ApiDemo
//
//  Created by Sunil Developer on 24/11/22.
//

import Foundation
struct CreateEmpModel {
    var status: String?
    var data: dataModel?
    init(response: [String: AnyObject]) {
        self.status = response["status"] as? String
        self.data = dataModel(response: response["data"] as! [String: AnyObject])
        
    }
}
    struct dataModel {
        var name: String?
        var salary: String?
        var age: String?
        init(response: [String: AnyObject]) {
            self.name = response["name"] as? String
            self.salary = response["salary"] as? String
            self.age = response["age"] as? String
        }
    }

