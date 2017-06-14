//
//  SatelliteView.swift
//  GoToSea
//
//  Created by kpugame on 2017. 5. 10..
//  Copyright © 2017년 Jae Won Yoo. All rights reserved.
//

import UIKit

class SatelliteView: UIViewController, XMLParserDelegate {
    var parser = XMLParser()
    var url : String?

    var data : String? = "ir1"
    
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var satImg = NSMutableString()
    
    var str = "satImgC-file"
    var dateString : String = ""
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var label: UILabel!
    @IBAction func SliderValueChanged(_ sender: Any) {
        
        setImage(index: Int(slider.value))
        //textBox.text = String(slider.value)
    }
    func setImage(index: Int)
    {
        if posts.count > 0{
            var data : Data?
            let imageUrl: URL? = URL(string: (posts.object(at: index) as AnyObject).value(forKey: "satImgC-file") as! NSString as String)
            do{
                data = try Data(contentsOf : imageUrl!)
            } catch{
                
            }
            
            let image = UIImage(data : data!)
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "NoImage.png")
        }
    }
    
   
    
    func beginParsing(){
        
        url = "http://newsky2.kma.go.kr/FileService/SatlitVideoInfoService/InsightSatelite?serviceKey=BUByT3FTeKmSvrCfKDOafDLZsIn%2F3kVwiQ3M8i4K2bnwN0LqxUDoTQ5l7Fxp1OtfMNd5XNbktGRoJhW%2F%2FNOjcQ%3D%3D&sat=C&data=ir1&area=lk&time="
       url?.append(dateString)
        
        posts = []
        parser = XMLParser(contentsOf: URL(string: url!)!)!
        //parser = XMLParser(contentsOf: (URL(string: url!))!)!
        parser.delegate = self
        parser.parse()
        setImage(index: 0)
        label.text = String(posts.count)
        slider.maximumValue = Float(posts.count - 1)
        slider.minimumValue = 0
        slider.value = 0

    }
       
    @IBAction func YesterdayClick(_ sender: Any) {
        var str = GetDate()
        var dat: Int = Int(str)!
        dat = dat - 1
        dateString = String(describing: dat)
        beginParsing()
        print(dat)
    }
   
    @IBAction func TodayClick(_ sender: Any) {
        dateString = GetDate()
        beginParsing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dateString = GetDate()
        beginParsing()
        
        
        
        
    }


    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "satImgC-file"){
            elements = NSMutableDictionary()
            elements = [:]
            satImg = NSMutableString()
            satImg = ""
           
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "satImgC-file") {
            satImg.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName as NSString).isEqual(to: "satImgC-file"){
            if !satImg.isEqual(nil){
                elements.setObject(satImg, forKey: "satImgC-file" as NSCopying)
            }
            
            
            posts.add(elements)
        }
        
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if(segue.identifier == "GoBack")
        {
            imageView.removeFromSuperview()
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
