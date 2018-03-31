//
//  TableVC
//  KTW2
//
//  Created by Gabriel Kieruzel on 1/19/18.
//  Copyright © 2018 Gabriel Kieruzel. All rights reserved.
//

import UIKit

class TableVC: UITableViewController {
    var _tab = 0
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
        
        self.view.backgroundColor = TColors[0]
//        self.navigationController?.navigationBar.titleTextAttributes =
//            ([NSAttributedStringKey.foregroundColor: UIColor.red])
        

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapVC") as! mapVC
        destVC.address = DataService.instance.drinkAdresses[indexPath.row]
        print("Address in table vc : \(DataService.instance.drinkAdresses[indexPath.row])")
            
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    

    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
//        print("In view will appear .... after reloadData() " )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _tab = (self.tabBarController?.selectedIndex)!
//        print(" _tab: \(_tab) in viewDidAppear...")
        //tableView.reloadData()
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ( _tab == 0 ) {
            return DataService.instance.seeTabPic.count
        } else if ( _tab == 1 ) {
            return DataService.instance.hotelTabPic.count
        } else if ( _tab == 2 ) {
            return DataService.instance.eatTabPic.count
        } else if ( _tab == 3 ) {
            return DataService.instance.drinkTabPic.count
        } else if ( _tab == 4 ) {
            return DataService.instance.transTabPic.count
        }

        return 0
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = Bundle.main.loadNibNamed("cstTbCell", owner: self, options: nil)?.first as! cstTbCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "myTVCell") as! kTabCell
        cell.mainLbl.text = String(indexPath.row)
        cell.confCell(tab: _tab, row: indexPath.row)

        
        
            cell.selectionStyle = .none
            return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 290
    }
}

