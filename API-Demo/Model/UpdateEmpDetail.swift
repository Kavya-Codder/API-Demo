//
//  UpdateEmpDetail.swift
//  ApiDemo
//
//  Created by Sunil Developer on 24/11/22.
//

import Foundation
struct EmpDataBaseModel {
    var status: String?
    var data: UpdateDataModel?
    init(response: [String: AnyObject]) {
        self.status = response["status"] as? String
        self.data = UpdateDataModel(response: response["data"] as! [String: AnyObject])
        
    }
}
struct UpdateDataModel {
    var name: String?
    var salary: String?
    var age: String?
    var id: Int?
    init(response: [String: AnyObject]) {
        self.name = response["name"] as? String
        self.salary = response["salary"] as? String
        self.age = response["age"] as? String
        self.id = response["id"] as? Int
    }
}
