//
//  DateViewController.swift
//  GoToSea
//
//  Created by kpugame on 2017. 5. 24..
//  Copyright © 2017년 Jae Won Yoo. All rights reserved.
//

import UIKit

class DateViewController: UIViewController, XMLParserDelegate {
    var parser = XMLParser()
    var locate : String?
    var locate_utf8 : String = ""
    var url : String? = ""
    
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var location = NSMutableString() // 지역
    var sunrise = NSMutableString() // 일출
    var sunset = NSMutableString() // 일몰
    var moonrise = NSMutableString() // 월출
    var moonset = NSMutableString() //  월몰
    var nautm = NSMutableString() // 항해박명(아침)
    var naute = NSMutableString() // 항해박명(저녁)
    var longitude = NSMutableString() // nx
    var latitude = NSMutableString() //ny
    
    var dateString = GetDate()
    
    @IBOutlet weak var label_nautm: UILabel!
    @IBOutlet weak var label_naute: UILabel!
    @IBOutlet weak var label_moonset: UILabel!
    @IBOutlet weak var label_moonrise: UILabel!
    @IBOutlet weak var label_sunset: UILabel!
    @IBOutlet weak var label_sunrise: UILabel!
    @IBOutlet weak var label_location: UILabel!
    
    @IBAction func SearchForecast(_ sender: Any) {
        
       performSegue(withIdentifier: "showForecast", sender: self) 
        
    }
    func beginParsing(){
        
        url = "http://apis.data.go.kr/B090041/openapi/service/RiseSetInfoService/getAreaRiseSetInfo?serviceKey=BUByT3FTeKmSvrCfKDOafDLZsIn%2F3kVwiQ3M8i4K2bnwN0LqxUDoTQ5l7Fxp1OtfMNd5XNbktGRoJhW%2F%2FNOjcQ%3D%3D"
        locate_utf8 = (locate?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed))!
        url!.append("&location=\(locate_utf8)")
        url!.append("&locdate=\(dateString)")
        
        posts = []
        parser = XMLParser(contentsOf: URL(string: url!)!)!
        parser.delegate = self
        parser.parse()
        label_location.text = "지역 : \((posts.object(at: 0) as AnyObject).value(forKey: "location") as! NSString as String)"
        label_sunrise.text = "일출 : \(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "sunrise") as! NSString as String))"
        label_sunset.text = "일몰 : \(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "sunset") as! NSString as String))"
        label_moonrise.text = "월출 : \(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "moonrise") as! NSString as String))"
        label_moonset.text = "월몰 : \(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "moonset") as! NSString as String))"
        label_nautm.text = "항해박명(아침) : \(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "nautm") as! NSString as String))"
        label_naute.text = "항해박명(저녁) : \(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "naute") as! NSString as String))"
    }

    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item"){
            elements = NSMutableDictionary()
            elements = [:]
            
            
            location = NSMutableString()
            sunrise = NSMutableString()
            sunset = NSMutableString()
            moonrise = NSMutableString()
            moonset = NSMutableString()
            nautm = NSMutableString()
            naute = NSMutableString()
            longitude = NSMutableString()
            latitude = NSMutableString()
            
            location = ""
            sunrise = ""
            sunset = ""
            moonrise = ""
            moonset = ""
            nautm = ""
            naute = ""
            longitude = ""
            latitude = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "location") {
            location.append(string)
        }
        if element.isEqual(to: "sunrise") {
            sunrise.append(string)
        }
        if element.isEqual(to: "sunset") {
            sunset.append(string)
        }
        if element.isEqual(to: "moonrise") {
            moonrise.append(string)
        }
        if element.isEqual(to: "moonset") {
            moonset.append(string)
        }
        if element.isEqual(to: "nautm") {
            nautm.append(string)
        }
        if element.isEqual(to: "naute") {
            naute.append(string)
        }
        if element.isEqual(to: "longitude"){
            longitude.append(string)
        }
        if element.isEqual(to: "latitude") {
            latitude.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "item"){
            if !location.isEqual(nil){
                elements.setObject(location, forKey: "location" as NSCopying)
            }
            if !sunrise.isEqual(nil){
                elements.setObject(sunrise, forKey: "sunrise" as NSCopying)
            }
            if !sunset.isEqual(nil){
                elements.setObject(sunset, forKey: "sunset" as NSCopying)
            }
            if !moonrise.isEqual(nil){
                elements.setObject(moonrise, forKey: "moonrise" as NSCopying)
            }
            if !moonset.isEqual(nil){
                elements.setObject(moonset, forKey: "moonset" as NSCopying)
            }
            if !nautm.isEqual(nil){
                elements.setObject(nautm, forKey: "nautm" as NSCopying)
            }
            if !naute.isEqual(nil){
                elements.setObject(naute, forKey: "naute" as NSCopying)
            }
            if !longitude.isEqual(nil) {
                elements.setObject(longitude, forKey: "longitude" as NSCopying)
            }
            if !latitude.isEqual(nil) {
                elements.setObject(latitude, forKey: "latitude" as NSCopying)
            }
            
            
            posts.add(elements)
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
       beginParsing()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if(segue.identifier == "showForecast")
        {
            if let forecastView = segue.destination as? ForecastViewController{
                var nx = ""
                var ny = ""
                nx = (posts.object(at: 0) as AnyObject).value(forKey: "latitude") as! NSString as String
                ny = (posts.object(at: 0) as AnyObject).value(forKey: "longitude") as! NSString as String
                
                nx.characters.popLast()
                nx.characters.popLast()
                
                ny.characters.popLast()
                ny.characters.popLast()
                
               // print("nx: " + nx + ", ny: " + ny)
                
                forecastView.nx = nx
                forecastView.ny = ny
                
                
                forecastView.DateString = dateString
            }
        }
        
    }

  

}
