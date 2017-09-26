//
//  ViewController.swift
//  TjbotTeleop
//
//  Created by Marek Sadowski on 9/25/17.
//  Copyright © 2017 Marek Sadowski. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var speakTextField: UITextField!
    @IBOutlet weak var labelInfo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func speakButtonPressed(_ sender: Any) {
        NSLog("speak button pressed with text \(speakTextField.text as! String)")
        
        var textToSpeak : String = speakTextField.text!
        textToSpeak =  textToSpeak.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        NSLog("text to speak: " + textToSpeak)
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        //let session = URLSession.shared
        let webserviceURL = "https://service.us.apiconnect.ibmcloud.com/gws/apigateway/api/8b432466d8e127b8331a6f753d98f7008ba87c4fe679b50e238cd03b555f0ab8/api/tjbot/speak"
        print(webserviceURL)
        let url = URL(string: webserviceURL)
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "id=january&text=\(textToSpeak)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            if error != nil {
                
                //get response
                print(error!.localizedDescription)
                //update the label with the error result
                self.labelInfo.text = "exception while calling RESTful API"
                
            } else {
                do {
                    if let data = data {
                        print(data)
                        let results = JSON(data: data)
                        print(results)
                    }
                    
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    {
                        
                        //Implement your logic
                        print(json)
                        if (json["err"] != nil) {
                            DispatchQueue.main.async {
                                self.labelInfo.text = json["err"] as? String
                            }
                        } else {
                            //got response!
                            //update the label with the result and filtering some responses (color and command)
                            var responseString = ""
                            if (json["tjbot"] != nil) {
                                responseString = json["tjbot"] as! String
                                responseString = ": " + responseString + ", "
                            }
                            if (json["command"] != nil) {
                                responseString = responseString.appending( json["command"] as! String )
                            }
                            
                            DispatchQueue.main.async {
                                self.labelInfo.text = "speak - got some response" + responseString
                            }
                        }
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    self.labelInfo.text = "error in JSONSerialization"
                }
            }
        })
        task.resume()
    }
    
    @IBAction func shineButtonPressed(_ sender: Any) {
        NSLog("shine button pressed")
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let webserviceURL = "https://service.us.apiconnect.ibmcloud.com/gws/apigateway/api/8b432466d8e127b8331a6f753d98f7008ba87c4fe679b50e238cd03b555f0ab8/api/tjbot/shine"
            
        print(webserviceURL)
        let url = URL(string: webserviceURL)
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let paramString = "id=january&color=red"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            if error != nil {
               
                //get response
                print(error!.localizedDescription)
                //update the label with the error result
                self.labelInfo.text = "exception while calling RESTful API"
                
            } else {
                do {
                    if let data = data {
                        print(data)
                        let results = JSON(data: data)
                        print(results)
                    }
                    
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    {
                        
                        //Implement your logic
                        print(json)
                        if (json["err"] != nil) {
                            DispatchQueue.main.async {
                                self.labelInfo.text = json["err"] as? String
                            }
                        } else {
                            //got response!
                            //update the label with the result and filtering some responses (color and command)
                            var responseString = ""
                            if (json["tjbot"] != nil) {
                                responseString = json["tjbot"] as! String
                                responseString = ": " + responseString + ", "
                            }
                            if (json["command"] != nil) {
                                responseString = responseString.appending( json["command"] as! String )
                                responseString = responseString + ", "
                            }
                            if (json["color"] != nil) {
                                responseString = responseString.appending( json["color"] as! String )
                            }
                            
                            DispatchQueue.main.async {
                                self.labelInfo.text = "yay! got some response" + responseString
                            }
                        }
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    self.labelInfo.text = "error in JSONSerialization"
                }
                
                

            }
        })
        task.resume()
    }
    
    @IBAction func takePhotoButtonPressed(_ sender: Any) {
        NSLog("take photo button pressed")
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        //let session = URLSession.shared
        let webserviceURL = "https://service.us.apiconnect.ibmcloud.com/gws/apigateway/api/8b432466d8e127b8331a6f753d98f7008ba87c4fe679b50e238cd03b555f0ab8/api/tjbot/take_photo"
        
        print(webserviceURL)
        let url = URL(string: webserviceURL)
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "id=january"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            if error != nil {
                
                //get response
                print(error!.localizedDescription)
                //update the label with the error result
                self.labelInfo.text = "exception while calling RESTful API"
                
            } else {
                do {
                    if let data = data {
                        print(data)
                        let results = JSON(data: data)
                        print(results)
                    }
                    
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    {
                        
                        //Implement your logic
                        print(json)
                        if (json["err"] != nil) {
                            DispatchQueue.main.async {
                                self.labelInfo.text = json["err"] as? String
                            }
                        } else {
                            //got response!
                            //update the label with the result and filtering some responses
                            var responseString = ""
                            if (json["tjbot"] != nil) {
                                responseString = json["tjbot"] as! String
                                responseString = ": " + responseString + ", "
                            }
                            if (json["command"] != nil) {
                                responseString = responseString.appending( json["command"] as! String )
                                responseString = responseString + ", "
                            }
                            
                            //TODO: add the event JSON retrival of the Watson results
                            
                            DispatchQueue.main.async {
                                self.labelInfo.text = "photo? got some response" + responseString
                            }
                        }
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    self.labelInfo.text = "error in JSONSerialization"
                }
            }
        })
        task.resume()
        
    }
    
    @IBAction func waveButtonPressed(_ sender: Any) {
        NSLog("wave button pressed")
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        //let session = URLSession.shared
        let webserviceURL = "https://service.us.apiconnect.ibmcloud.com/gws/apigateway/api/8b432466d8e127b8331a6f753d98f7008ba87c4fe679b50e238cd03b555f0ab8/api/tjbot/wave"
        
        print(webserviceURL)
        let url = URL(string: webserviceURL)
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "id=january"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            if error != nil {
                
                //get response
                print(error!.localizedDescription)
                //update the label with the error result
                self.labelInfo.text = "exception while calling RESTful API"
                
            } else {
                do {
                    if let data = data {
                        print(data)
                        let results = JSON(data: data)
                        print(results)
                    }
                    
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    {
                        
                        //Implement your logic
                        print(json)
                        if (json["err"] != nil) {
                            DispatchQueue.main.async {
                                self.labelInfo.text = json["err"] as? String
                            }
                        } else {
                            //got response!
                            //update the label with the result and filtering some responses
                            var responseString = ""
                            if (json["tjbot"] != nil) {
                                responseString = json["tjbot"] as! String
                                responseString = ": " + responseString + ", "
                            }
                            if (json["command"] != nil) {
                                responseString = responseString.appending( json["command"] as! String )
                                responseString = responseString + ", "
                            }
                            if (json["motion"] != nil) {
                                responseString = responseString.appending( json["motion"] as! String )
                            }
                            
                            DispatchQueue.main.async {
                                self.labelInfo.text = "waved? got some response" + responseString
                            }
                        }
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    self.labelInfo.text = "error in JSONSerialization"
                }
            }
        })
        task.resume()
        
    }
    
    @IBAction func analyzeToneButtonPressed(_ sender: Any) {
        NSLog("analyze Tone button pressed")
        
        var textToAnalyze : String = speakTextField.text!
        textToAnalyze =  textToAnalyze.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        NSLog("text to analyse the tone: " + textToAnalyze)
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        //let session = URLSession.shared
        let webserviceURL = "https://service.us.apiconnect.ibmcloud.com/gws/apigateway/api/8b432466d8e127b8331a6f753d98f7008ba87c4fe679b50e238cd03b555f0ab8/api/tjbot/analyze_tone"
        print(webserviceURL)
        let url = URL(string: webserviceURL)
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "id=january&text=\(textToAnalyze)"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            if error != nil {
                
                //get response
                print(error!.localizedDescription)
                //update the label with the error result
                self.labelInfo.text = "exception while calling RESTful API"
                
            } else {
                do {
                    if let data = data {
                        print(data)
                        let results = JSON(data: data)
                        print(results)
                    }
                    
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    {
                        
                        //Implement your logic
                        print(json)
                        if (json["err"] != nil) {
                            DispatchQueue.main.async {
                                self.labelInfo.text = json["err"] as? String
                            }
                        } else {
                            //got response!
                            //update the label with the result and filtering some responses (color and command)
                            var responseString = ""
                            if (json["tjbot"] != nil) {
                                responseString = json["tjbot"] as! String
                                responseString = ": " + responseString + ", "
                            }
                            if (json["command"] != nil) {
                                responseString = responseString.appending( json["command"] as! String )
                            }
                            //TODO: add the event JSON retrival of the Watson results
                            
                            DispatchQueue.main.async {
                                self.labelInfo.text = "analyze_tone - got some response" + responseString
                            }
                        }
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    self.labelInfo.text = "error in JSONSerialization"
                }
            }
        })
        task.resume()
        
    }
    @IBAction func seeButtonPressed(_ sender: Any) {
        NSLog("see button pressed")
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        
        //let session = URLSession.shared
        let webserviceURL = "https://service.us.apiconnect.ibmcloud.com/gws/apigateway/api/8b432466d8e127b8331a6f753d98f7008ba87c4fe679b50e238cd03b555f0ab8/api/tjbot/see"
        
        print(webserviceURL)
        let url = URL(string: webserviceURL)
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "id=january"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (data, response, error) in
            if error != nil {
                
                //get response
                print(error!.localizedDescription)
                //update the label with the error result
                self.labelInfo.text = "exception while calling RESTful API"
                
            } else {
                do {
                    if let data = data {
                        print(data)
                        let results = JSON(data: data)
                        // loop through results
                        print(results)
                    }
                    
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    {
                        
                        //Implement your logic
                        print(json)
                        if (json["err"] != nil) {
                            DispatchQueue.main.async {
                                self.labelInfo.text = json["err"] as? String
                            }
                        } else {
                            //got response!
                            //update the label with the result and filtering some responses (color and command)
                            var responseString = ""
                            if (json["tjbot"] != nil) {
                                responseString = json["tjbot"] as! String
                                responseString = ": " + responseString + ", "
                            }
                            if (json["command"] != nil) {
                                responseString = responseString.appending( json["command"] as! String )
                            }
                            //TODO: add the event JSON retrival of the Watson results
                            
                            DispatchQueue.main.async {
                                self.labelInfo.text = "saw - got some response" + responseString
                            }
                        }
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    self.labelInfo.text = "error in JSONSerialization"
                }
            }
        })
        task.resume()
    }
    

}

