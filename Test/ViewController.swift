//
//  ViewController.swift
//  Test
//
//  Created by Gursewak singh on 04/09/20.
//  Copyright © 2020 Gursewak singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var table_View: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "My Diary"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font:UIFont.init(name: "SF UI Text", size: 17.0)!]
        
        self.table_View.register(UINib(nibName: CellIdentifier.MainCell, bundle: nil), forCellReuseIdentifier:CellIdentifier.MainCell)
        
        self.table_View.register(UINib(nibName: Headerdentifier.MainHeader, bundle:nil), forHeaderFooterViewReuseIdentifier: Headerdentifier.MainHeader)
        
        self.table_View.separatorStyle = .none
        
        self.table_View.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
}

//--------------------------------------------
// MARK - UITABLEVIEW DELEGATE/ DATASOURCE
//--------------------------------------------
extension ViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView : MainHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Headerdentifier.MainHeader) as! MainHeader
        headerView.lbl_title.text = data.allKeys[section] as? String
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.MainCell,
                                                                   for: indexPath) as! MainTableViewCell
    
        cell.selectionStyle = .none
        
        if let section = data[data.allKeys[indexPath.section]] as? [Any]{
            if let row = section[indexPath.row] as? [String : String]{
                cell.lbl_title.text = row["titles"]!
                cell.lbl_description.text = row["Description"]!
                cell.lbl_date.text = row["Dates"]!
            }
        }
        cell.btn_edit.accessibilityIdentifier = "\(cell.lbl_title.text!)##\( cell.lbl_description.text!)"
        cell.btn_edit.tag = indexPath.section * 1000 + indexPath.row
        cell.btn_edit.addTarget(self, action: #selector(btn_Edit), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func btn_Edit(sender : UIButton){
        let details = sender.accessibilityIdentifier?.components(separatedBy: "##")
        titles = details![0]
        Descriptions = details![1]
        self.performSegue(withIdentifier: "detail", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let arr = data[data.allKeys[section]] as? NSArray{
            return arr.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

class button: UIButton {
    var btn_title : String?
    var btn_description: String?
}

