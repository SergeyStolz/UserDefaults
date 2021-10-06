//
//  UserModel.swift
//  UserDefaults
//
//  Created by mac on 04.10.2021.
//

import UIKit

enum SexType: String {
    case male
    case female
}

class UserModel: NSObject, NSCoding {
    let name: String
    let surname: String
    let city: String
    let pickerCityRow: Int
    let sex: SexType
    let sexIndex: Int
    
    init(name: String, surname: String, city: String, pickerCityRow: Int, sex: SexType, sexIndex: Int) {
        self.name = name
        self.surname = surname
        self.city = city
        self.pickerCityRow = pickerCityRow
        self.sex = sex
        self.sexIndex = sexIndex
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(surname, forKey: "surname")
        coder.encode(city, forKey: "city")
        coder.encode(pickerCityRow, forKey: "pickerCityRow")
        coder.encode(sex.rawValue, forKey: "sex")
        coder.encode(sexIndex, forKey: "sexIndex")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        surname = coder.decodeObject(forKey: "surname") as? String ?? ""
        city = coder.decodeObject(forKey: "city") as? String ?? ""
        pickerCityRow = coder.decodeInteger(forKey: "pickerCityRow")
        sex = SexType(rawValue: (coder.decodeObject(forKey: "sex") as! String)) ?? SexType.male
        sexIndex = coder.decodeInteger(forKey: "sexIndex")
    }
}
