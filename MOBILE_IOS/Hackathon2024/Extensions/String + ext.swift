//
//  String + ext.swift
//  Hackathon2024
//
//  Created by Николай Прощалыкин on 19.04.2024.
//
import Foundation
import UIKit

extension String{
  func extractYoutubeId() -> String? {
    let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/)|(?<=shorts/))([\\w-]++)"
    if let matchRange = self.range(of: pattern, options: .regularExpression) {
        return String(self[matchRange])
    } else {
        return .none
    }
  }
    
    func vacantRoom() -> String {
        if self == "Помещение свободного назначения / Пустой кабинет" {
            return "Пустой кабинет"
        }
        else {
            return self
        }
    }
    
    func toCurrencyFormat() -> String {
        
        let counter = self.count
        
        if counter >= 4 {
            var result = ""
            let point = counter - 4
            self.enumerated().forEach { char in
                if char.offset == point {
                    result += String(char.element) + " "
                }
                else {
                    result += String(char.element)
                }
            }
            return result + " ₽"
        }
        
        else {
             return self + " ₽"
        }
    }
 }


extension String {
    
    public func convertHtmlToAttributedStringWithCSS(font: UIFont?,grayColor:Bool = false) -> NSAttributedString? {
        guard let font = font else {
            return nil
        }

        var isItalic = false
        var isBold = false
        
        var fontname = font.fontName

        
        if self.contains("<strong") {
            isBold = true
        }
        if self.contains("<em") {
            isItalic = true
        }
        
        if isBold && isItalic {
            fontname = font.familyName + "-" + "SemiBoldItalic"
        }
        else if isBold {
            fontname = font.familyName + "-" + "Bold"
        }
        else if isItalic {
            fontname = font.familyName + "-" + "Italic"
        }
        
        var colorString = ""
        
        if grayColor {
            colorString = " color:Gray;"
        }
    
        let modifiedString = "<style>body{font-family: '\(fontname)'; font-size:\(font.pointSize)px;\(colorString)} .ql-align-center {text-align: center;}.ql-align-right {text-align: right;}.ql-align-justify {text-align: justify;}</style>\(self)"
        
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {

            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)

         
            return attributed
            
        }
        catch {
            debugPrint(error)
            return nil
        }
    }
}

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}

//https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift
extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>)               -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}
extension LosslessStringConvertible {
    var string: String { .init(self) }
}
extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}

