//
//  ViewController.swift
//  Web Content
//
//  Created by Kwame Bryan on 2014-11-23.
//  Copyright (c) 2014 3e Interactive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var city: UITextField!
    
    @IBOutlet var message: UILabel!
    
    @IBAction func weatherButton(sender: AnyObject) {
        // resign text editing
        self.view.endEditing(true);
        // create a string and replace text with 
        // text from city text field
        var weather = ""
        var urlString = "http://www.weather-forecast.com/locations/" + city.text.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest";
        // An NSURL object represents a URL that can potentially contain the location of a resource on a remote server
        var url = NSURL(string: urlString);
        //The NSURLSession class and related classes provide an API for 
        //downloading content via HTTP.
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data,reponse,error) in
            // take the content of the data returned
            // then encode it as UTF8
            var urlContent:NSString = NSString(data: data, encoding:NSUTF8StringEncoding)!;
            // manipulate the HTML span class
            var contentArray:Array = urlContent.componentsSeparatedByString("<span class=\"phrase\">");
            // create an array of content seperated by the closing 
            // span tag
            var newContentArray = contentArray[1].componentsSeparatedByString("</span>");
            var weather = newContentArray[0] as String
            weather = weather.stringByReplacingOccurrencesOfString("&deg", withString: "º" )
                // print out the contents
                println(newContentArray[0]);
                // perform and async operation from the array as a String
                // update message.text
                dispatch_async(dispatch_get_main_queue()){
                    self.message.text = weather
                }
        }
        task.resume();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

