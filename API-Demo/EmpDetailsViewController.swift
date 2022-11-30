//
//  EmpDetailsViewController.swift
//  ApiDemo
//
//  Created by Sunil Developer on 24/11/22.
//

import UIKit

class EmpDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    var empData: [eDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        navConfige()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: EmpDetailsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EmpDetailsTableViewCell.identifier)
        
    }
@IBAction func onClickAddBtn(_ sender: Any) {
    
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
    
   
    navigationController?.pushViewController(vc, animated: true)
    
   

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: EmpDetailsTableViewCell.identifier, for: indexPath) as! EmpDetailsTableViewCell
        let obj = empData[indexPath.row]
        cell.lblName.text = "Name: \(obj.employee_name ?? "")"
        cell.lblAge.text = "Age: \(obj.employee_age ?? 0)"
        cell.lblSalary.text = "salary: \(obj.employee_salary ?? 0)"
       
        
        cell.deleteBtn = {
            let obj = self.empData[indexPath.row]
            let alertVC = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: .alert)
            let yesBtn = UIAlertAction(title: "YES", style: .destructive) { (alert) in
                
                self.deleteData(id: obj.id ?? 0, row: indexPath.row)
                print("record deleted successfully: \(indexPath.row)")
            
            }
            let noBtn = UIAlertAction(title: "NO", style: .default) { (alert) in
               
                
                self.dismiss(animated: true, completion: nil)
            }
            alertVC.addAction(yesBtn)
            alertVC.addAction(noBtn)
            
            self.present(alertVC, animated: true, completion: nil)
            
            
        }
        
        cell.editBtn = {
           // let obj = self.empData[indexPath.row]
            let editVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as! ViewController
            
            
            editVC.obj = self.empData[indexPath.row]

            self.navigationController?.pushViewController(editVC, animated: false)
            
        }
        
             return cell
        }
    

    func getData() {
        let apiName = "https://dummy.restapiexample.com/api/v1/employees"
        guard let url = URL(string: apiName) else {
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
         URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as! Dictionary<String, AnyObject>
                 let allEmpData = AllEmpDataModel(response: json)
                
                DispatchQueue.main.async {
                    self.empData = allEmpData.data
                    self.tableview.reloadData()
                    
            
                }
                print(json)
                
            } catch {
                  
            }
        }.resume()
    }
   
    func deleteData(id: Int, row: Int) {
        
        let apiName = "https://dummy.restapiexample.com/api/v1/delete/\(id)"
        guard let url = URL(string: apiName) else {
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "DELETE"
       
         URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as! Dictionary<String, AnyObject>
                 
                DispatchQueue.main.async {
                    self.empData.remove(at: row)
                     
                    self.tableview.reloadData()
                }
                print(json)
                
            } catch {
                  
            }
        }.resume()
    }
    func navConfige()  {
        navigationItem.title = "All Employee Details"
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "btnColour")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        //navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.setHidesBackButton(true, animated: true)
    
}
}

