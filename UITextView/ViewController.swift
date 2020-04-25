//
//  ViewController.swift
//  UITextView
//
//  Created by leslie on 4/24/20.
//  Copyright © 2020 leslie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var message: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message.delegate = self
    }

    @IBAction func selection(_ sender: UIButton) {
        let attributedText = message.textStorage
        attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: message.selectedRange)
        message.selectedTextRange = nil
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
                //because textStorage: NSTextStorage class is the reference type
                //As assigned the textStorage property to attributedText variable
                //means that both of attributedText and textStorage variables share the same object
                //to change any of one is the same thing.
                //That's the different between class and structure
                let attributedText = textView.textStorage
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



