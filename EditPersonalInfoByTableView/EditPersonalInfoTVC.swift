//
//  EditPersonalInfoTVC.swift
//  EditPersonalInfoByTableView
//
//  Created by 4wd-ios on 2017/9/11.
//  Copyright © 2017年 szd. All rights reserved.
//

import UIKit

class EditPersonalInfoTVC: UITableViewController , UIActionSheetDelegate{

    var dataArr : [Array<Any>] = []
    
    var chooseActionSheet : ((_ text:String) -> Void)?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "个人信息"
        
        tableViewConfig()
        
        setUpNavBar()
        
        createData()
    }
    
    func tableViewConfig() {
        self.tableView.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        
        self.tableView.register(UINib.init(nibName: "PersonalInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
    }
    
    func setUpNavBar() {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        btn.setTitle("完成", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(saveClick), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: btn)
    }
    
    func saveClick() {
        for item in dataArr {
            let arr = item
            for obj in arr {
                let model = obj as! PersonalInfoModel
                
                print("\(model.infoKeyStr):\(model.infoValueStr)")
            }
        }
    }
    
    func createData() {
        let arr = [["身份证号码","姓名","性别","专业","手机号","血型","身高(cm)","体重(kg)","单位名称","邮箱"],["姓名","手机号"],["姓名"]]
        for item in arr {
            var mArr : [PersonalInfoModel] = []
            
            for str in item {
                let model = PersonalInfoModel(infoKeyStr:str, infoValueStr:"" ,placeHolderStr:"请输入\(str)")
                mArr.append(model)
            }
            dataArr.append(mArr)
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! PersonalInfoTableViewCell
        cell.selectionStyle = .none
        
        var model = dataArr[indexPath.section][indexPath.row] as! PersonalInfoModel
        cell.updateCellWithModel(model: model)
        
        cell.tfChanged = {
            (text:String) in
            model.infoValueStr = text
            self.dataArr[indexPath.section][indexPath.row] = model
        }
        cell.chooseGender = {
            self.tableView.endEditing(true)
            let alertSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "男","女")
            alertSheet.show(in: self.view)
            
            self.chooseActionSheet = {
                (text:String) in
                model.infoValueStr = text
                self.dataArr[indexPath.section][indexPath.row] = model
                cell.infoValueTF.text = text
            }
        }
        cell.chooseBloodType = {
            self.tableView.endEditing(true)
            let alertSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "A型","B型","AB型","O型","其他")
            alertSheet.show(in: self.view)
            self.chooseActionSheet = {
                (text:String) in
                model.infoValueStr = text
                self.dataArr[indexPath.section][indexPath.row] = model
                cell.infoValueTF.text = text
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let arr = ["   报名人信息","   紧急联系人信息","   推荐人"]
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 36.0))
        lab.text = arr[section]
        lab.backgroundColor = UIColor.white
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
        
        return lab
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36.0
    }

    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        let title = actionSheet.buttonTitle(at: buttonIndex)
        if title == "取消" {
            
        }else{
            chooseActionSheet?(title!)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.tableView.endEditing(true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
