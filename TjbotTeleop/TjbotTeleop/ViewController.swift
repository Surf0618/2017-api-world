//
//  ViewController.swift
//  TjbotTeleop
//
//  Created by Marek Sadowski on 9/25/17.
//  Copyright © 2017 Marek Sadowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var speakTextField: UITextField!
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
    }
    @IBAction func shineButtonPressed(_ sender: Any) {
        NSLog("shine button pressed")
    }
    @IBAction func takePhotoButtonPressed(_ sender: Any) {
        NSLog("take photo button pressed")
    }
    @IBAction func waveButtonPressed(_ sender: Any) {
        NSLog("wave button pressed")
    }
    @IBAction func analyzeToneButtonPressed(_ sender: Any) {
        NSLog("analyze Tone button pressed")
    }
    @IBAction func seeButtonPressed(_ sender: Any) {
        NSLog("see button pressed")
    }
    

}

