//
//  EditText.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 19.04.2024.
//

import UIKit
import TLCustomMask
import AnyFormatKit

protocol EditTextDelegate: AnyObject {
    func hideNextButton()
    func showNextButton()
    
}

class EditText: UIView, UITextFieldDelegate {
    
    weak var delegate: EditTextDelegate?
    
    var maxLength: Int?
    
    let customMask = TLCustomMask()
    
    var placeholder: String?
    
    var isPhoneField = false
    
    var isPassword = false
    
    var isSocial = false
    
    var isVK = false
    
    var isFb = false
    
    var isIG = false
    
    var isTG = false
    
    var socilaType = ""
    
    let showPasswordButton = UIButton()
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var placeholderLabel: UILabel!
    
    @IBOutlet var placeholderHeight: NSLayoutConstraint!
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("EditText", owner: self, options: nil)
        view.fixInView(self)
        textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        
        customMask.formattingPattern = "+7 ($$$) $$$-$$-$$"
    }
    
    func set(placeholder: String, isPassword: Bool = false) {
        self.placeholder = placeholder
        textField.placeholder = placeholder
        placeholderLabel.text = placeholder
        if isPassword {
            showPasswordButton.setImage(UIImage(named: "ShowPassword"), for: .normal)
            showPasswordButton.sizeToFit()
            showPasswordButton.addTarget(self,
                                         action: #selector(showPasswordAction(sender:)),
                                         for: .touchUpInside)
            
            textField.rightView = showPasswordButton
            textField.rightViewMode = .always
            
            if #available(iOS 12, *) {
                textField.textContentType = .oneTimeCode
            } else {
                textField.textContentType = .init(rawValue: "")
            }
        }
    }
    
    @objc func showPasswordAction(sender: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
        
        showPasswordButton.setImage(UIImage(named: textField.isSecureTextEntry ? "ShowPassword" : "HidePassword"),
                                    for: .normal)
    }
    
    @objc func textChanged(_ textField: UITextField) {
        if let text = textField.text {
            if text.count > 0 {
                delegate?.showNextButton()
                placeholderLabel.isHidden = false
                placeholderHeight.isActive = false
                placeholderLabel.setNeedsLayout()
            } else {
                delegate?.hideNextButton()
                placeholderLabel.isHidden = true
                placeholderHeight.isActive = true
                placeholderLabel.setNeedsLayout()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func getFormattedPhone(phone:String) -> String {
        let textPattern = "+7 (###) ###-##-##"

        let phoneFormatter = DefaultTextInputFormatter(textPattern: textPattern)
    
        let nsText = phone as NSString
        let textRange = NSRange(location: 0, length: nsText.length)

        let result = phoneFormatter.formatInput(currentText: phone, range: textRange, replacementString: phone)

       return result.formattedText
    }
    
    func deleteMoreThanOneChar(textField:UITextField?,range:NSRange,text:String) -> (newRange:NSRange,newText:String) {
        
        let location = range.location
        
        let lastPart = text[(location + 1)...].string
        
        let firstPart = text[...location].string
        
        var stop = false
        var deleteLast = 0
        
        firstPart.enumerated().reversed().forEach { obj in
            if !stop {
                let element = obj.element.string
                
                if element == " " ||
                    element == "(" ||
                    element == ")" ||
                    element == "-" {
                    
                    deleteLast += 1
                }
                else {
                    stop = true
                }
            }
        }
        
        let newFirstPart = firstPart.dropLast(deleteLast)
        let newRange = NSRange(location: range.location - deleteLast, length: 1)
        let newText = String(newFirstPart) + lastPart
        
        return (newRange,newText)
    }
   
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        var string = string
        
        if isPhoneField {
            string = string.digits
            if string.count >= 11 {
                string.remove(at: string.startIndex)
            }
        }
        
        guard let selectedTextRange = textField.selectedTextRange else { return false }
        var currentText = textField.text
        var range = range
        let isEndPoint = textField.endOfDocument == selectedTextRange.end
 
        if isPhoneField {
            
            let textPattern = "+7 (###) ###-##-##"
            
            if let currentText,currentText.count == textPattern.count, !string.isEmpty {
      
                return false
            }
            
            //Для возможности удаления символов в центре маски
            else if let text = currentText,string.isEmpty{
               let result = deleteMoreThanOneChar(textField: textField,range: range,text: text)
                range = result.newRange
                currentText = result.newText
                
            }
 
            let phoneFormatter = DefaultTextInputFormatter(textPattern: textPattern)
            let result = phoneFormatter.formatInput(currentText: textField.text ?? "", range: range, replacementString: string)
            
            textField.text = result.formattedText

            if !isEndPoint {
                //Изменение положения курсора (требуется при работе с маской)
                textField.selectedTextRange = textField.setNewCursorPosition(
                    textBeforeEditting: currentText,
                    changedText: result.formattedText,
                    replacementString: string,
                    selectedTextRange: selectedTextRange)
            }
    
            return false
        }
        
        else if isVK {
            
            let textPattern = "https://vk.com/##############################"
            
            if let currentText,currentText.count == textPattern.count, !string.isEmpty {
      
                return false
                
            }
            
            let phoneFormatter = DefaultTextInputFormatter(textPattern: textPattern)
            let result = phoneFormatter.formatInput(currentText: textField.text ?? "", range: range, replacementString: string)
            
            textField.text = result.formattedText
            
            if !isEndPoint {
                //Изменение положения курсора (требуется при работе с маской)
                textField.selectedTextRange = textField.setNewCursorPosition(
                    textBeforeEditting: currentText,
                    changedText: result.formattedText,
                    replacementString: string,
                    selectedTextRange: selectedTextRange)
            }

            return false
        }
        else if isIG {
            
            let textPattern = "https://instagram.com/#####################"
            
            if let currentText,currentText.count == textPattern.count, !string.isEmpty {
      
                return false
                
            }
            
            let phoneFormatter = DefaultTextInputFormatter(textPattern:textPattern )
            let result = phoneFormatter.formatInput(currentText: textField.text ?? "", range: range, replacementString: string)
            
            textField.text = result.formattedText
            
            if !isEndPoint {
                //Изменение положения курсора (требуется при работе с маской)
                textField.selectedTextRange = textField.setNewCursorPosition(
                    textBeforeEditting: currentText,
                    changedText: result.formattedText,
                    replacementString: string,
                    selectedTextRange: selectedTextRange)
            }
            
            return false
        }
        else if isFb {
            
            let textPattern = "https://fb.com/#####################"
            
            if let currentText,currentText.count == textPattern.count, !string.isEmpty {
      
                return false
                
            }
            
            let phoneFormatter = DefaultTextInputFormatter(textPattern: textPattern)
            let result = phoneFormatter.formatInput(currentText: textField.text ?? "", range: range, replacementString: string)
            
            textField.text = result.formattedText
            
            if !isEndPoint {
                //Изменение положения курсора (требуется при работе с маской)
                textField.selectedTextRange = textField.setNewCursorPosition(
                    textBeforeEditting: currentText,
                    changedText: result.formattedText,
                    replacementString: string,
                    selectedTextRange: selectedTextRange)
            }
            
            return false
        }
        else if isTG {
            
            let textPattern = "https://t.me/##############################"
            
            if let currentText,currentText.count == textPattern.count, !string.isEmpty {
      
                return false
                
            }
            
            let phoneFormatter = DefaultTextInputFormatter(textPattern:textPattern)
            let result = phoneFormatter.formatInput(currentText: textField.text ?? "", range: range, replacementString: string)
            
            textField.text = result.formattedText

            if !isEndPoint {
                //Изменение положения курсора (требуется при работе с маской)
                textField.selectedTextRange = textField.setNewCursorPosition(
                    textBeforeEditting: currentText,
                    changedText: result.formattedText,
                    replacementString: string,
                    selectedTextRange: selectedTextRange)
            }
            
            return false
        }
        else {
            
            let currentText = textField.text ?? ""
            
            guard let stringRange = Range(range, in: currentText) else { return false }
            
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            if let maxLength = maxLength {
                return updatedText.count <= maxLength
            }
            
            else {
                
                return true
            }
            
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if isPhoneField || isPassword {
            if let text = textField.text {
                if text.count > 0 {
                    delegate?.showNextButton()
                    placeholderLabel.isHidden = false
                    placeholderHeight.isActive = false
                    placeholderLabel.setNeedsLayout()
                } else {
                    delegate?.hideNextButton()
                    placeholderLabel.isHidden = true
                    placeholderHeight.isActive = true
                    placeholderLabel.setNeedsLayout()
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if isSocial {
            addButtonToTextfield()
            
            if isVK {
                guard let text = textField.text else { return }
                if text.isEmpty {
                    textField.text = "https://vk.com/"
                }
            }
            
            if isFb {
                guard let text = textField.text else { return }
                if text.isEmpty {
                    textField.text = "https://fb.com/"
                }
            }
            if isIG {
                guard let text = textField.text else { return }
                if text.isEmpty {
                    let pattern = "https://instagram.com/"
                    textField.text = pattern
                }
            }
            
           
        }
        if isPhoneField  {
            guard let text = textField.text else { return }
            if text.isEmpty {
                textField.text = "+7 ("
            }
            let endPosition = textField.endOfDocument
            textField.selectedTextRange = textField.textRange(from: endPosition, to: endPosition)
        }
    }
}

// Если выбраны соцсети
extension EditText {
    func addButtonToTextfield() {
        if isSocial {
            let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
            keyboardToolbar.sizeToFit()
            keyboardToolbar.barStyle = .default
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneBarButton = UIBarButtonItem(title: "Перейти по ссылке", style: .done, target: self,action: #selector(tapAction))
            
            keyboardToolbar.items = [flexBarButton, doneBarButton]
            textField.inputAccessoryView = keyboardToolbar
        }
       
    }

    @objc func tapAction() {
        
        }
    
}

