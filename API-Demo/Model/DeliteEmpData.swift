//
//  DeliteEmpData.swift
//  ApiDemo
//
//  Created by Sunil Developer on 24/11/22.
//

import Foundation
struct DeleteDataModel {
    var status: String?
    var message: String?
    init(response: [String: AnyObject]) {
        self.status = response["status"] as? String
        self.message = response["message"] as? String
    }
}
