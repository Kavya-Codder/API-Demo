//
//  ViewController.swift
//  ApiDemo
//
//  Created by Sunil Developer on 23/11/22.
//

import UIKit

enum EmployeeDetailValidation: String {
     case name = "Please enter name"
     case age = "Please enter age"
    case salary = "Please enter salary"
}

class ViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtSalary: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var btnViewEmployee: UIButton!
    @IBOutlet weak var lblNavigation: UILabel!
    
    var updateData = EmpDetailsViewController()
    var obj : eDataModel?
    var aObj : AllEmpDataModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetUp()
        
        txtName.text = obj?.employee_name
        txtAge.text = "\(obj?.employee_age ?? 0)"
        txtSalary.text = "\(obj?.employee_salary ?? 0)"
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        navConfige()
    }
   
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickSubmitBtn(_ sender: Any) {
        let validation = doValidation()
        if validation.0 {
          
            if self.obj != nil {
                
                updateEmpData(id: obj?.id ?? 0)
    
                showAlert(title: "Update", message: "Update successfully") { (str) in
                    
                    self.navigationController?.popViewController(animated: true)
                }
                
                
            } else {
               
                apiCall()
                showAlert(title: "Success", message: "Add successfully") { (str) in
                    self.navigationController?.popViewController(animated: true)
                }
                
            }
            
        } else {
            showAlert(title: "Error", message: validation.1, hendler: nil)
            
        }
    }
    
    func doValidation() -> (Bool, String)
    {
            if (txtName.text?.isEmpty ?? false) {
                return(false, EmployeeDetailValidation.name.rawValue)
            } else if (txtAge.text?.isEmpty ?? false) {
                return(false, EmployeeDetailValidation.age.rawValue)
            } else if (txtSalary.text?.isEmpty ?? false) {
                return(false, EmployeeDetailValidation.salary.rawValue)
            }
         return(true, "")
        }
    
    func apiCall() {
        let apiNmae = "https://dummy.restapiexample.com/api/v1/create"
        guard let url = URL(string: apiNmae) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let param = ["name": txtName.text, "salary": txtSalary.text, "age": txtAge.text]
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [])
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as! Dictionary<String, AnyObject>
               
                let data1 = eDataModel(response: json)
                
                DispatchQueue.main.async {
                    //self.aObj?.data.append(data1)
                   // self.updateData.empData.append(data1)
                   // self.navigationController?.popViewController(animated: true)
                    
                    
                    
                }
                print(json)
                
            }catch {
                
            }
        }.resume()
    }
    func updateEmpData (id: Int) {
        let apiName = "https://dummy.restapiexample.com/api/v1/update/\(id)"
        guard let url = URL(string: apiName) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let param = ["name": txtName.text, "salary": txtSalary.text, "age": txtAge.text]
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [])
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as! Dictionary<String, AnyObject>
               
                let data1 = eDataModel(response: json)
            
                DispatchQueue.main.async {
                   // self.aObj?.data.insert(data1, at: id)
//                    self.empData = allEmpData.data
//                    self. = data1.employee_name
                    
                    
                    
                }
                print(json)
                
            }catch {
                
            }
        }.resume()
    }
    
    func initialSetUp() {
        btnSubmit.layer.cornerRadius = 10
        btnSubmit.clipsToBounds = true
        
        btnViewEmployee.layer.cornerRadius = 10
        btnViewEmployee.clipsToBounds = true
    }
    
    func navConfige()  {
        if self.obj != nil {
           navigationItem.title = "Update Record"
            btnSubmit.setTitle("Update", for: .normal)
        } else {
            
            navigationItem.title = "Add new employee"
            btnSubmit.setTitle("Save", for: .normal)
        }
    
}
}

    
