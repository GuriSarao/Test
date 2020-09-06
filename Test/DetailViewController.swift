//
//  DetailViewController.swift
//  Test
//
//  Created by Gursewak singh on 06/09/20.
//  Copyright © 2020 Gursewak singh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var table_View: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let image = UIImage(named: "Union")!

        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        
        
        self.navigationItem.title = titles
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,NSAttributedString.Key.font:UIFont.init(name: "SF UI Text", size: 17.0)!]
        
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = .clear
        
        self.table_View.register(UINib(nibName: CellIdentifier.detailCell, bundle: nil), forCellReuseIdentifier:CellIdentifier.detailCell)
        
        self.table_View.tableFooterView = UIView()
    }
    
    
    @objc func backBtnTapped(sender : UIButton){
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//--------------------------------------------
// MARK - UITABLEVIEW DELEGATE/ DATASOURCE
//--------------------------------------------
extension DetailViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.detailCell,
                                                                   for: indexPath) as! DetailTableViewCell
    
        cell.selectionStyle = .none
        cell.lbl_title.text = indexPath.row == 0 ? "Diary Title" : "Diary Content"
        cell.lbl_description.text = indexPath.row == 0 ? titles : Descriptions
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

