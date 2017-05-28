//
//  Date.swift
//  GoToSea
//
//  Created by kpugame on 2017. 5. 24..
//  Copyright © 2017년 Jae Won Yoo. All rights reserved.
//

import Foundation


func GetDate() -> String{
    let date = Date()
    var formatter = DateFormatter();
    formatter.dateFormat = "yyyyMMdd"
    let str = formatter.string(from: date as Date)
    return str
}

func GetTime() -> String {
    let date = Date()
    var formatter = DateFormatter();
    formatter.dateFormat = "HHmm"
    let str = formatter.string(from: date as Date)
    return str
}

func ChangeTimeFromString(string : String) -> String
{
    var mstr = string
    var str = ""
    
    str.append(mstr.characters.popFirst()!)
    str.append(mstr.characters.popFirst()!)
    str.append("시 ")
    
    str.append(mstr.characters.popFirst()!)
    str.append(mstr.characters.popFirst()!)
    str.append("분 ")
    
    str.append(mstr.characters.popFirst()!)
    str.append(mstr.characters.popFirst()!)
    str.append("초 ")
    
    return str
}

func ChangeDateFromString(string : String) ->String{
    var mstr = string
    var str = ""
    
    str.append(mstr.characters.popFirst()!)
    str.append(mstr.characters.popFirst()!)
    str.append(mstr.characters.popFirst()!)
    str.append(mstr.characters.popFirst()!)
    str.append("년 ")
    
    str.append(mstr.characters.popFirst()!)
    str.append(mstr.characters.popFirst()!)
    str.append("월 ")
    
    str.append(mstr.characters.popFirst()!)
    str.append(mstr.characters.popFirst()!)
    str.append("일 ")
    
    return str
    
    
}
