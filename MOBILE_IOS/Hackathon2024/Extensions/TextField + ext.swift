//
//  TextField + ext.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 19.04.2024.
//

import UIKit

extension UITextField {
    func setNewCursorPosition(textBeforeEditting:String?,
                              changedText:String,
                              replacementString:String,
                              selectedTextRange: UITextRange?) -> UITextRange? {
      
        
        
        guard let selectedTextRange else { return nil }
        
        if !replacementString.isEmpty,
            let newPosition = getPosition(selectedTextRange: selectedTextRange, offset: 1) {
            
            return self.textRange(from: newPosition, to: newPosition)
        }
        else if replacementString.isEmpty,
                let textBeforeEditting,
                    textBeforeEditting != changedText,
                let newPosition = getPosition(selectedTextRange: selectedTextRange, offset: -1) {
            
            return  self.textRange(from: newPosition, to: newPosition)
        }
        else {
            return selectedTextRange
        }
    }
    
    func getPosition(selectedTextRange:UITextRange,offset:Int) -> UITextPosition? {
        
        if let newPosition = self.position(from: selectedTextRange.start, offset:offset) {
          return  newPosition
        }
        else {
            return nil
        }
    }
}
