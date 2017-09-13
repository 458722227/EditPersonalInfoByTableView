//
//  PersonalInfoTableViewCell.swift
//  EditPersonalInfoByTableView
//
//  Created by 4wd-ios on 2017/9/11.
//  Copyright © 2017年 szd. All rights reserved.
//

import UIKit

class PersonalInfoTableViewCell: UITableViewCell ,UITextFieldDelegate{

    @IBOutlet weak var infoKeyLab: UILabel!
    @IBOutlet weak var infoValueTF: UITextField!
    @IBOutlet weak var rightArrowImgV: UIImageView!
    
    var infoModel : PersonalInfoModel!
    
    //传值闭包
    var tfChanged : ((_ text:String) -> Void)?
    var chooseGender : ((Void) -> Void)?
    var chooseBloodType : ((Void) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoValueTF.addTarget(self, action: #selector(textDidChange), for:.editingChanged)
        infoValueTF.delegate = self
    }
    
    func updateCellWithModel(model:PersonalInfoModel) -> Void {
        infoModel = model
        
        infoKeyLab.text = model.infoKeyStr
        infoValueTF.placeholder = model.placeHolderStr
        
        if model.infoKeyStr == "性别" || model.infoKeyStr == "血型" {
            rightArrowImgV.isHidden = false
        }else{
            rightArrowImgV.isHidden = true
        }
        
        //键盘类型
        let arr = ["姓名","专业","单位名称"]
        if arr.contains(model.infoKeyStr) {
            infoValueTF.keyboardType = .default
        }else{
            if model.infoKeyStr == "邮箱" {
                infoValueTF.keyboardType = .emailAddress
            }else{
                infoValueTF.keyboardType = .numberPad
            }
        }
    }
    
    func textDidChange(){
        tfChanged?(infoValueTF.text!);
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if infoModel.infoKeyStr == "性别"{
            chooseGender?();
            return false
        }else if infoModel.infoKeyStr == "血型" {
            chooseBloodType?();
            return false
        }else{
            return true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
