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
        label_location.text = "\((posts.object(at: 0) as AnyObject).value(forKey: "location") as! NSString as String)"
        label_sunrise.text = "\(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "sunrise") as! NSString as String))"
        label_sunset.text = "\(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "sunset") as! NSString as String))"
        label_moonrise.text = "\(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "moonrise") as! NSString as String))"
        label_moonset.text = "\(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "moonset") as! NSString as String))"
        label_nautm.text = "\(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "nautm") as! NSString as String))"
        label_naute.text = "\(ChangeTimeFromString(string: (posts.object(at: 0) as AnyObject).value(forKey: "naute") as! NSString as String))"
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
    var strX = ""
    var strY = ""
    var RE = 6371.00877; // 지구 반경(km)
    var GRID = 5.0; // 격자 간격(km)
    var SLAT1 = 30.0; // 투영 위도1(degree)
    var SLAT2 = 60.0; // 투영 위도2(degree)
    var OLON = 126.0; // 기준점 경도(degree)
    var OLAT = 38.0; // 기준점 위도(degree)
    var XO = 43; // 기준점 X좌표(GRID)
    var YO = 136; // 기1준점 Y좌표(GRID)
    let PI = 3.14159265358979
    func MakeXY(lat: Double, long: Double ){
        var DEGRAD = PI / 180.0;
        var RADDEG = 180.0 / PI;
        
        var re = RE / GRID;
        var slat1 = SLAT1 * DEGRAD;
        var slat2 = SLAT2 * DEGRAD;
        var olon = OLON * DEGRAD;
        var olat = OLAT * DEGRAD;
        
        var sn = tan(PI * 0.25 + slat2 * 0.5) / tan(PI * 0.25 + slat1 * 0.5);
        sn = log(cos(slat1) / cos(slat2)) / log(sn);
        var sf = tan(PI * 0.25 + slat1 * 0.5);
        sf = pow(sf, sn) * cos(slat1) / sn;
        var ro = tan(PI * 0.25 + olat * 0.5);
        ro = re * sf / pow(ro, sn);
        
        //strX = String(lat);
        //strY = long;
        var ra = tan(PI * 0.25 + (lat) * DEGRAD * 0.5);
        ra = re * sf / pow(ra, sn);
        var theta = long * DEGRAD - olon;
        if (theta > PI)
        {
         theta -= 2.0 * PI;
        }
        if (theta < -PI){
         theta += 2.0 * PI;
        }
        theta *= sn;
        
        strX = String(floor(ra * sin(theta) + Double(XO) + 0.5));
        strY = String(floor(ro - ra * cos(theta) + Double(YO) + 0.5));
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if(segue.identifier == "showForecast")
        {
            if let forecastView = segue.destination as? ForecastViewController{
                var nx = ""
                var ny = ""
                nx = (posts.object(at: 0) as AnyObject).value(forKey: "latitude") as! NSString as String
                ny = (posts.object(at: 0) as AnyObject).value(forKey: "longitude") as! NSString as String
                
                
                
                var tx = nx
                var ty = ny
                var x = ""
                var y = ""
                
                
                x.append(tx.characters.popFirst()!)
                x.append(tx.characters.popFirst()!)
                x.append(".")
                x.append(tx.characters.popFirst()!)
                x.append(tx.characters.popFirst()!)
                
                y.append(ty.characters.popFirst()!)
                y.append(ty.characters.popFirst()!)
                y.append(ty.characters.popFirst()!)
                y.append(".")
                y.append(ty.characters.popFirst()!)
                y.append(ty.characters.popFirst()!)
                
                MakeXY(lat: Double(x)!, long: Double(y)!)
                print("nx: " + strX + ", ny: " + strY)
                
                
                strX.characters.popLast()
                strX.characters.popLast()
                
                strY.characters.popLast()
                strY.characters.popLast()
                
                
                
                forecastView.nx = strX
                forecastView.ny = strY
                
                
                forecastView.DateString = dateString
            }
        }
        
    }

  

}
