# UITextView

## textView.textStorage

## UITextViewDelegate
        
        textViewDidChange

## Find and return the ranges of all the occurrences of a given string in Swift

## UITextFieldDelegate
        
        textFieldDidBeginEditing()
        textFieldDidEndEditing()
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool

## Open and Close Keyboard

    UIResponder.becomeFirstResponder()
    UIResponder.resignFirstResponder()

## UIResponder Methods to close keyboard
        //to detect touch events on the screen
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                super.touchesBegan(touches, with: event)
                
                //UIResponder.endEditing(Bool) == .resignFirstResponder() to dismiss keyboard
                way 1: textView.resignFirstResponder()
                way 2: view.endEditing(true)
        }


## UIColor(patternImage: UIImage)

        if let myPattern = UIImage(named: "oranges") {
            view.backgroundColor = UIColor(patternImage: myPattern)
        }
