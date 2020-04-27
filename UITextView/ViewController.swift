//
//  ViewController.swift
//  UITextView
//
//  Created by leslie on 4/24/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var originalBGColor: UIColor!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var subTitleInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message.delegate = self
        titleInput.delegate = self
        subTitleInput.delegate = self
    }

    @IBAction func selection(_ sender: UIButton) {
        let attributedText = message.textStorage
        attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: message.selectedRange)
        message.selectedTextRange = nil
        
        message.resignFirstResponder()
    }
    
    @IBAction func changeTitle(_ sender: UIButton) {
        if titleInput.text != "" && subTitleInput.text != "" {
            titleLabel.text = titleInput.text! + "-" + subTitleInput.text!
            titleInput.text = ""
            subTitleInput.text = ""
            
//UIResponder.endEditing(Bool) == .resignFirstResponder() to dismiss keyboard
            titleInput.endEditing(true)
            subTitleInput.endEditing(true)
            
//textField resigns first respondder to close keyboard
            titleInput.resignFirstResponder()
        } else {
//textField resigns first respondder to close keyboard
            titleInput.becomeFirstResponder()
        }
    }

//UIResponder.touchesBegan() to detect touch events on screen
//Dismissing the keyboard when the user touches the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
//        titleInput.resignFirstResponder() //refactored by UIResponder.endEditing(Bool)
//UIResponder.endEditing(Bool) == .resignFirstResponder() to dismiss keyboard
        view.endEditing(true)
    }
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let text = textView.text
        let attributedText = textView.textStorage
        let originColor = textView.textColor

//Finds and returns the range of the [first occurrence] of a given string
//        if let range = text?.range(of: "John", options: .caseInsensitive) {
//            let attributedText = textView.textStorage
//            attributedText.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(range,in: text!))
//        }
        
        //Find and return the ranges of [all the occurrences] of a given string in Swift
        if let ranges = text?.rangesOf(string: "John", options: .caseInsensitive) {
            for range in ranges {
                attributedText.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(range, in: text!))
            }
            
            //return from the custom attribute config of key word to the original attrubute config
            let lastRange = ranges[ranges.count - 1]
            let startIndex = lastRange.upperBound
            let endIndex = text?.endIndex
            attributedText.addAttribute(.foregroundColor, value: originColor!, range: NSRange(startIndex..<endIndex!, in: text!))
        }
    }
    
}

extension String {
    
    func rangesOf(string: String, options: NSString.CompareOptions) -> [Range<String.Index>] {
        
        var ranges: [Range<String.Index>] = []
        var searchStartIndex = self.startIndex
        
        while searchStartIndex < self.endIndex,
            let range = self.range(of: string, options: options, range: searchStartIndex..<self.endIndex){
                
                ranges.append(range)
                
                searchStartIndex = range.upperBound
        }
        
        return ranges
    }
    

}

extension ViewController: UITextFieldDelegate {
    
    
    //self tells delegate that editing began in the specified text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.originalBGColor = textField.backgroundColor
        textField.backgroundColor = UIColor.lightGray
    }
    
    //self tells the delegate that editing stopped for the specified text field
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = self.originalBGColor
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maximum = 0
        if textField.tag == 1 {
            maximum = 10
        } else {
            maximum = 15
        }
        if let text = textField.text {
            let total = text.count + string.count - range.length
            print("Text: \(text.count)")
            print("string: \(string.count)")
            print("range: \(range.length)")
            print("total: \(total)")

            if total > maximum {
                return false
            }
        }
        
        return true
    }

}

