//
//  AllEmployeeData.swift
//  ApiDemo
//
//  Created by Sunil Developer on 24/11/22.
//

import Foundation
struct AllEmpDataModel {
    var status: String?
    var data: [eDataModel] = []
    init(response: [String: AnyObject]) {
        self.status = response["status"] as? String
        if let empData = response["data"] as? [[String: AnyObject]] {
            empData.forEach { responseDic in
                let employee = eDataModel(response: responseDic)
                data.append(employee)
            }
         }
    }
}
    struct eDataModel {
        var id: Int?
        var employee_name: String?
        var employee_salary: Int?
        var employee_age: Int?
        var profile_image: String?
        init(response: [String: AnyObject]) {
            self.id = response["id"] as? Int
            self.employee_name = response["employee_name"] as? String
            self.employee_salary = response["employee_salary"] as? Int
            self.employee_age = response["employee_age"] as? Int
            self.profile_image = response["profile_image"] as? String
        }
    }

