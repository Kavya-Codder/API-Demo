//
//  EmpDetailsTableViewCell.swift
//  ApiDemo
//
//  Created by Sunil Developer on 24/11/22.
//

import UIKit

class EmpDetailsTableViewCell: UITableViewCell {
static let identifier = "EmpDetailsTableViewCell"
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var editBtn:(()->Void)?
    @IBAction func onClickEditBtn(_ sender: Any) {
        
      editBtn?()
    
    }
    
    var deleteBtn:(()->Void)?
    @IBAction func onClickDeleteBtn(_ sender: Any) {
    deleteBtn?()
}
    

}
