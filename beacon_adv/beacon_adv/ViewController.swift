//
//  ViewController.swift
//  beacon_adv
//
//  Created by 若尾あすか on 2014/08/21.
//  Copyright (c) 2014年 若尾あすか. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    
    
    let UUID:NSUUID!
    
    var _peripheralManager:CBPeripheralManager!
    
    
    
    //outlet
    @IBOutlet weak var majornum: UITextField!
    @IBOutlet weak var minornum: UITextField!
    
    @IBOutlet weak var powerValue: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _peripheralManager = CBPeripheralManager(delegate: self, queue: queue)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        //        getBeaconID()
        //        [self, beaconing:YES];
        
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        
    }
    
    func beaconing(flag: Bool){
        let uuid = NSUUID(UUIDString :"B9407F30-F5F8-466E-AFF9-25556B57FE6D")
        
        
        var majorint:Int! = self.majornum.text.toInt()!
        var major:CLBeaconMajorValue = UInt16(majorint)
        
        var minorint:Int! = self.minornum.text.toInt()!
        var minor:CLBeaconMinorValue = UInt16(minorint)
        
        var region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: "\(uuid)")
        
        var peripheralData : NSDictionary!
        
        var length = countElements("\(self.powerValue.text)")
        
        if (length > 0){
            var power = self.powerValue.text.toInt()
            peripheralData = region.peripheralDataWithMeasuredPower(power)
        }
        else{
            peripheralData = region.peripheralDataWithMeasuredPower(nil)
            
        }
        
        switch(flag){
        case true:
            _peripheralManager.startAdvertising(peripheralData)
            UIApplication.sharedApplication().idleTimerDisabled = true
            break
            
        case false:
            _peripheralManager.stopAdvertising()
            UIApplication.sharedApplication().idleTimerDisabled = false
            break
        default:
            break
        }
    }
    
    @IBAction func majorEditEnd(sender: AnyObject){
//        self.beaconing(false)
//        self.beaconing(true)
//        self.setBeaconID()
    }
    @IBAction func minorEditEnd(sender: AnyObject){
//        self.beaconing(false)
//        self.beaconing(true)
//        self.setBeaconID()
        
    }
    @IBAction func powerEditEdn(sender: AnyObject){
        self.beaconing(false)
        self.beaconing(true)
        self.setBeaconID()
    }
    
    
    //func textFieldShoudReturn:(Bool)
    
    
    func setBeaconID(){
        var defaults:NSUserDefaults = NSUserDefaults()//データ保持のメゾット
        //例)"\(self.majornum.text)"を”majorNumber”で保存
        defaults.setObject(self.majornum.text, forKey: "majorNumber")
        defaults.setObject(self.minornum.text, forKey: "minorNumber")
        defaults.setObject(self.powerValue.text, forKey: "powerValue")
    }
    
    func getBeaconID(){
        var defaults:NSUserDefaults = NSUserDefaults()        
        var Major:String = defaults.objectForKey("majorNumber") as String
        var ma_length = countElements(Major)
        if(ma_length > 0 ){
            self.majornum.text = Major
            
        }
        var Minor:String = defaults.objectForKey("minorNumber") as String
        var mi_length = countElements(Minor)
        if(mi_length > 0 ){
            self.minornum.text = Minor
            
        }
        var Power:String = defaults.objectForKey("powerValue") as String
        var pa_length = countElements(Power)
        if(pa_length > 0 ){
            self.powerValue.text = Power
            
        }
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        self.view.endEditing(true)
    }
}




