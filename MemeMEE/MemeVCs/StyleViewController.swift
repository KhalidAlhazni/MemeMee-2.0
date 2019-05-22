//
//  StyleViewController.swift
//  MemeMEE
//
//  Created by khalid alhazmi on 18/03/2019.
//  Copyright © 2019 khalid alhazmi. All rights reserved.
//

//import Foundation
import UIKit

protocol StyleViewDelegate {
    func moveData(color : UIColor , font : String )
}

class StyleViewController : UIViewController , UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate {
    //delegate
    var delegate: StyleViewDelegate?
    
    //outlet
    @IBOutlet weak var stylePicker: UIPickerView!
    @IBOutlet weak var testTextField: UITextField!
    
    //picker items
    let colorData = ["red","yellow","green","Blue","White"]
    let fontData  = ["HelveticaNeue-CondensedBlack","Helvetica-Neue","Kefa","Arial","Didot"]
    
    // varable
    var color = UIColor.white
    var viewColor = false
    var font = "HelveticaNeue-CondensedBlack"

    
    var styleTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor:UIColor.black ,
        .foregroundColor:UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: -3
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField(testTextField)
        stylePicker.delegate = self
        stylePicker.dataSource = self
        stylePicker.isHidden = true
        testTextField.delegate = self
        

    }
    
    
    func setupTextField(_ textField: UITextField) {
        textField.defaultTextAttributes = styleTextAttributes
        textField.textAlignment = .center
    }

    //picker functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(viewColor){
            return colorData.count}
        else{
            return fontData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(viewColor){
            return colorData[row]}
        else{
            return fontData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(viewColor){
            if(colorData[row] == "red" ){ styleTextAttributes[.foregroundColor]=UIColor.red
                setupTextField(testTextField)
                color=UIColor.red
            }
            else if(colorData[row] == "yellow" ){ styleTextAttributes[.foregroundColor]=UIColor.yellow
                setupTextField(testTextField)
                color=UIColor.yellow
            }
            else if(colorData[row] == "green" ){ styleTextAttributes[.foregroundColor]=UIColor.green
                setupTextField(testTextField)
                color=UIColor.green
            }
            else if(colorData[row] == "Blue" ){ styleTextAttributes[.foregroundColor]=UIColor.blue
                setupTextField(testTextField)
                color=UIColor.blue
            }
            else if(colorData[row] == "White" ){ styleTextAttributes[.foregroundColor]=UIColor.white
                setupTextField(testTextField)
                color=UIColor.white
            }
                    }
            
            
        else{
            styleTextAttributes[.font]=UIFont(name: fontData[row], size: CGFloat(40))
            setupTextField(testTextField)
            font =  fontData[row]
        }
    }
    
    
    //keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    
    
    
    
    @IBAction func colorButton(_ sender: Any) {
        viewColor = true
        stylePicker.isHidden = false
    }
    @IBAction func fontButton(_ sender: Any) {
        viewColor = false
        stylePicker.isHidden = false
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        
            delegate?.moveData(color: color, font: self.font)
            dismiss(animated: true, completion: nil)
        
    }
    
    
    
}




