//
//  ForecastViewController.swift
//  GoToSea
//
//  Created by kpugame on 2017. 5. 24..
//  Copyright © 2017년 Jae Won Yoo. All rights reserved.
//


/*
 POP -강수확률
 단위 : %
 에러 : -1 %
 
 PTY - 강수형태
 단위 : 코드값
 에러 : -1
 
 R06 - 6시간 강수량
 단위 : 범주 (1 mm)
 에러 : -1 mm
 
 REH - 습도
 단위 : %
 에러 : -1 %
 
 S06 - 6시간 신적설
 단위 : 범주(1 cm)
 에러 : -1 cm
 
 SKY - 하늘상태
 단위 : 코드값
 에러 : -1
 
 T3H - 3시간 기온
 단위 : ℃
 에러 : -50 ℃
 
 TMN - 아침 최저기온
 단위 : ℃
 에러 : -50 ℃
 
 TMX - 낮 최고기온
 단위 : ℃
 에러 : -50 ℃
 
 UUU - 풍속(동서성분)
 단위 : m/s
 에러 : -100 m/s
 
 VVV - 풍속(남북성분)
 단위 : m/s
 에러 : -100 m/s
 
 WAV - 파고
 단위 : M
 에러 : -1 m
 
 VEC - 풍향
 단위 : m/s
 에러 : -1
 
 WSD - 풍속
 단위 : 1
 에러 : -1
 
 
 */

import UIKit

class ForecastViewController: UIViewController, XMLParserDelegate {
    var parser = XMLParser()
    
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var nx : String?
    var ny : String?
    var DateString : String?
    var DateTime : String = GetTime()
    
    var url : String?
    
    
    var baseData = NSMutableString()
    var baseTime = NSMutableString()
    var category = NSMutableString()
    var fcstDate = NSMutableString()
    var fcstTime = NSMutableString()
    var fcstValue = NSMutableString()
    
    @IBOutlet weak var label_R06: UILabel! // 6시간 강수량
    @IBOutlet weak var label_S06: UILabel! // 6시간 적설량
    @IBOutlet weak var label_POP: UILabel! // 강수확률
    @IBOutlet weak var label_PTY: UILabel! // 강수형태
    @IBOutlet weak var label_REH: UILabel! // 습도
    @IBOutlet weak var label_SKY: UILabel! // 하늘 상태
    @IBOutlet weak var label_TMN: UILabel! // 최저기온
    @IBOutlet weak var label_TMX: UILabel! // 최고기온
    @IBOutlet weak var label_VEC: UILabel! // 풍향
    @IBOutlet weak var label_WSD: UILabel! // 풍속
    @IBOutlet weak var label_WAV: UILabel! // 파고
    
    
      var fcst_R06 = 0 // 6시간 강수량
      var fcst_S06 = 0 // 6시간 적설량
      var fcst_POP = 0 // 강수확률
      var fcst_PTY = 0 // 강수형태
      var fcst_REH = 0 // 습도
      var fcst_SKY = 0 // 하늘 상태
      var fcst_TMN = 0 // 최저기온
      var fcst_TMX = 0 // 최고기온
      var fcst_VEC = 0 // 풍향
      var fcst_WSD = 0 // 풍속
      var fcst_WAV = 0 // 파고
    @IBOutlet weak var weather_label: UILabel!
    var isToday = true
    @IBAction func pressToday(_ sender: Any) {
        
         fcst_R06 = 0 // 6시간 강수량
         fcst_S06 = 0 // 6시간 적설량
         fcst_POP = 0 // 강수확률
         fcst_PTY = 0 // 강수형태
         fcst_REH = 0 // 습도
         fcst_SKY = 0 // 하늘 상태
         fcst_TMN = 0 // 최저기온
         fcst_TMX = 0 // 최고기온
         fcst_VEC = 0 // 풍향
         fcst_WSD = 0 // 풍속
         fcst_WAV = 0 // 파고
        
        if isToday == false {
            SetData(date: Int(DateString!)!)
            isToday = true
        }
    }
    @IBAction func pressTomorrow(_ sender: Any) {
        
       fcst_R06 = 0 // 6시간 강수량
       fcst_S06 = 0 // 6시간 적설량
       fcst_POP = 0 // 강수확률
       fcst_PTY = 0 // 강수형태
       fcst_REH = 0 // 습도
       fcst_SKY = 0 // 하늘 상태
       fcst_TMN = 0 // 최저기온
       fcst_TMX = 0 // 최고기온
       fcst_VEC = 0 // 풍향
       fcst_WSD = 0 // 풍속
       fcst_WAV = 0 // 파고
       
        if isToday == true{
            SetData(date: Int(DateString!)! + 1)
            isToday = false
        }
        
    }
    

    @IBOutlet weak var Date: UILabel!
    func beginParsing(){
        
        url = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?serviceKey=BUByT3FTeKmSvrCfKDOafDLZsIn%2F3kVwiQ3M8i4K2bnwN0LqxUDoTQ5l7Fxp1OtfMNd5XNbktGRoJhW%2F%2FNOjcQ%3D%3D&numOfRows=228"
        
        var time = Int(DateTime)
        
        var DateString2 : String
        var timeString : String
        
        
        
        if time! < 0210
        {
            DateString2 = String(Int(DateString!)! - 1)
            timeString = "2300"
        } else {
            DateString2 = DateString!
            timeString = "0200"
        }
//        } else if time! < 2310{
//            DateString2 = DateString!
//            timeString = "0200"
//        } else {
//            DateString2 = DateString!
//            timeString = "2300"
//            DateString = String(Int(DateString!)! + 1)
//        }
        //DateString2 = String(Int(DateString!)! - 1)
        url!.append("&base_date=\(DateString2)")
        url!.append("&base_time=\(timeString)")
        url!.append("&nx=\(nx!)")
        url!.append("&ny=\(ny!)")
        
        posts = []
        parser = XMLParser(contentsOf: URL(string: url!)!)!
        parser.delegate = self
        parser.parse()
        
        
        
        
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            elements = NSMutableDictionary()
            elements = [:]
            
            baseData = NSMutableString()
            baseTime = NSMutableString()
            category = NSMutableString()
            fcstDate = NSMutableString()
            fcstTime = NSMutableString()
            fcstValue = NSMutableString()
            
            baseData = ""
            baseTime = ""
            category = ""
            fcstDate = ""
            fcstTime = ""
            fcstValue = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "category") {
            category.append(string)
        }
        
        if element.isEqual(to: "baseData") {
            baseData.append(string)
        }
        
        if element.isEqual(to: "baseTime") {
            baseTime.append(string)
        }
        
        if element.isEqual(to: "fcstDate") {
            fcstDate.append(string)
        }
        
        if element.isEqual(to: "fcstTime") {
            fcstTime.append(string)
        }
        
        if element.isEqual(to: "fcstValue") {
            fcstValue.append(string)
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "item"){
           if !category.isEqual(nil){
                elements.setObject(category, forKey: "category" as NSCopying)
            }
            if !baseData.isEqual(nil){
                elements.setObject(baseData, forKey: "baseData" as NSCopying)
            }
            if !baseTime.isEqual(nil){
                elements.setObject(baseTime, forKey: "baseTime" as NSCopying)
            }
            if !fcstDate.isEqual(nil){
                elements.setObject(fcstDate, forKey: "fcstDate" as NSCopying)
            }
            if !fcstTime.isEqual(nil){
                elements.setObject(fcstTime, forKey: "fcstTime" as NSCopying)
            }
            if !fcstValue.isEqual(nil){
                elements.setObject(fcstValue, forKey: "fcstValue" as NSCopying)
            }
            
            
            
            posts.add(elements)
        }
        
    }
    
    func SetData(date: Int)
    {
        for index in 0..<posts.count {
            let category = (posts.object(at: index) as AnyObject).value(forKey: "category") as! NSString as String
            
            
            let fcstDate = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstDate") as! NSString as String)
            if fcstDate == date {
                
                
                switch(category)
                {
                case "POP": //강수확률
                  
                        let time = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstTime") as! NSString as String)
                        if fcst_POP < time!
                        {
                            label_POP.text = (": \((posts.object(at: index) as AnyObject).value(forKey: "fcstValue") as! NSString as String)%")
                            fcst_POP = time!
                        }
                    break
                case "TMN"://최저기온
                        let time = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstTime") as! NSString as String)
                        if fcst_TMN < time!
                        {
                            label_TMN.text = (": \((posts.object(at: index) as AnyObject).value(forKey: "fcstValue") as! NSString as String)℃")
                            fcst_TMN = time!
                        }
                    break
                case "TMX"://최저기온
                        let time = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstTime") as! NSString as String)
                        if fcst_TMX < time!
                        {
                            label_TMX.text = (": \((posts.object(at: index) as AnyObject).value(forKey: "fcstValue") as! NSString as String)℃")
                            fcst_TMX = time!
                        }
                    break
                case "REH": // 습도
                    
                        let time = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstTime") as! NSString as String)
                        if fcst_REH < time!
                        {
                            label_REH.text = (": \((posts.object(at: index) as AnyObject).value(forKey: "fcstValue") as! NSString as String)%")
                            fcst_REH = time!
                        }
                    
                    break
                case "WAV": // 파고
                    
                        let time = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstTime") as! NSString as String)
                        if fcst_WAV < time!
                        {
                            label_WAV.text = (": \((posts.object(at: index) as AnyObject).value(forKey: "fcstValue") as! NSString as String)M")
                            fcst_WAV = time!
                        }
                    
                    break
                case "WSD": // 풍속
                        let time = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstTime") as! NSString as String)
                        if fcst_WSD < time!
                        {
                            label_WSD.text = (": \((posts.object(at: index) as AnyObject).value(forKey: "fcstValue") as! NSString as String)m/s")
                            fcst_WSD = time!
                        }
                    
                    break
                case "PTY":
                    
                        let time = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstTime") as! NSString as String)
                        if fcst_PTY < time!
                        {
                            let text = (posts.object(at: index) as AnyObject).value(forKey: "fcstValue") as! NSString as String
                            if text == "0"
                            {
                                label_PTY.text = "없음"
                            } else if text == "1"{
                                label_PTY.text = "비"//rain
                            } else if text == "2"{
                                label_PTY.text = "진눈깨비"//snow/rain
                            } else if text == "3"{
                                label_PTY.text = "눈"//snow
                            }
                            
                            fcst_PTY = time!
                        }
                        
                    
                    break
                case "R06":
                        let time = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstTime") as! NSString as String)
                        if fcst_R06 < time!
                        {
                            label_R06.text = (": \((posts.object(at: index) as AnyObject).value(forKey: "fcstValue") as! NSString as String)mm")
                            fcst_R06 = time!
                        }
                    
                    
                    break
                case "S06":
                   
                        let time = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstTime") as! NSString as String)
                        if fcst_S06 < time!
                        {
                            label_S06.text = (": \((posts.object(at: index) as AnyObject).value(forKey: "fcstValue") as! NSString as String)cm")
                            fcst_S06 = time!
                        }
                    
                    break
                case "VEC":
                   
                        let time = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstTime") as! NSString as String)
                        if fcst_VEC < time!
                        {
                            var vec = Float((posts.object(at: index) as AnyObject).value(forKey: "fcstValue") as! NSString as String)
                            vec = (vec! + 11.25) / 22.5
                            let ret = Int(vec!)
                            if ret == 0 {
                                label_VEC.text = "N"
                            } else if ret == 1 {
                                label_VEC.text = "NNE"
                            } else if ret == 2 {
                                label_VEC.text = "NE"
                            } else if ret == 3 {
                                label_VEC.text = "ENE"
                            } else if ret == 4 {
                                label_VEC.text = "E"
                            } else if ret == 5 {
                                label_VEC.text = "ESE"
                            } else if ret == 6 {
                                label_VEC.text = "SE"
                            } else if ret == 7 {
                                label_VEC.text = "SSE"
                            } else if ret == 8 {
                                label_VEC.text = "S"
                            } else if ret == 9 {
                                label_VEC.text = "SSW"
                            } else if ret == 10 {
                                label_VEC.text = "SW"
                            } else if ret == 11 {
                                label_VEC.text = "WSW"
                            } else if ret == 12 {
                                label_VEC.text = "W"
                            } else if ret == 13 {
                                label_VEC.text = "WNW"
                            } else if ret == 14 {
                                label_VEC.text = "NW"
                            } else if ret == 15 {
                                label_VEC.text = "NNW"
                            } else {
                                label_VEC.text = "N"
                            }
                            
                            fcst_VEC = time!
                        }
                    
                    
                    break
                case "SKY":
                   
                        let time = Int((posts.object(at: index) as AnyObject).value(forKey: "fcstTime") as! NSString as String)
                        if fcst_SKY < time!
                        {
                            let text = (posts.object(at: index) as AnyObject).value(forKey: "fcstValue") as! NSString as String
                            if label_PTY.text == "없음"
                            {
                                if text == "1" {
                                    label_SKY.text = "맑음"
                                    weather_label.text = "☀️"
                                } else if text == "2"{
                                    label_SKY.text = "구름조금"
                                    weather_label.text = "🌤"
                                } else if text == "3" {
                                    label_SKY.text = "구름많음"
                                    weather_label.text = "⛅️"
                                } else if text == "4" {
                                    label_SKY.text = "흐림"
                                    weather_label.text = "🌥"
                                }
                            } else {
                                if label_PTY.text == "비"{
                                    weather_label.text = "🌧"
                                } else if label_PTY.text == "진눈깨비"{
                                    weather_label.text = "🌧"
                                    
                                } else if label_PTY.text == "🌨"{
                                }

                            }
                            
                            
                            fcst_SKY = time!
                        }
                    
                    
                    break
                default:
                    break
                }

                
            }
            
            
            
            
        }
        Date.text = ChangeDateFromString(string: String(date))
       print(url!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        //print(posts.count)
        SetData(date: Int(DateString!)!)
        //print(GetDay(string: DateString!))
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
