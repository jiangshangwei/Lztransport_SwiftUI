//
//  Extension.swift
//  lztrans
//
//  Created by jsw_cool on 2023/7/4.
//

import Foundation

import SwiftUI
 
extension Color {
    
    public init?(hexString: String, alpha: CGFloat? = nil) {
        if let rgbaArr = hexString.RGBAArr(alpha), rgbaArr.count == 4 {
            self.init(red: rgbaArr[0], green: rgbaArr[1], blue: rgbaArr[2], opacity: rgbaArr[3])
        } else {
            return nil
        }
    }
    
    public init?(r: Double, g: Double, b: Double) {
        self.init(red: r, green: g, blue: b)
    }
    
    public init?(r: Double, g: Double, b: Double, a: Double = 1) {
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    /// Color转十六进制颜色字符串，包含alpha。
    public func RGBAHex() -> String? {
        let components = self.cgColor?.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        let a: CGFloat = components?[3] ?? 0.0
        let hexString = String(format: "#%02lX%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)), lroundf(Float(a * 255)))
        return hexString
    }
    
    /// Color转十六进制颜色字符串，忽略alpha。
    public func RGBHex() -> String? {
        let components = self.cgColor?.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
    
}
 
extension String {
    
    /// 十六进制颜色转RGBA数组
    /// 若priorityAlpha有传值，就算十六进制字符串中带有alpha也优先使用priorityAlpha。
    func RGBAArr(_ priorityAlpha: CGFloat? = nil) -> [CGFloat]? {
        let hex = self
        var formatted = hex.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        guard formatted.count == 6 || formatted.count == 8 else { return nil }
        
        var r: Int = 0
        var g: Int = 0
        var b: Int = 0
        var a: Int = 255
        let hexStr = formatted as NSString
        let rHex = hexStr.substring(with: NSRange(location: 0, length: 2))
        let gHex = hexStr.substring(with: NSRange(location: 2, length: 2))
        let bHex = hexStr.substring(with: NSRange(location: 4, length: 2))
        guard let rTen = Int(rHex, radix: 16), let gTen = Int(gHex, radix: 16), let bTen = Int(bHex, radix: 16)  else {
            return nil
        }
        r = rTen
        g = gTen
        b = bTen
        if formatted.count == 8 {
            let aHex = hexStr.substring(with: NSRange(location: 6, length: 2))
            guard let aTen = Int(aHex, radix: 16) else { return nil }
            a = aTen
        }
 
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        var alpha = CGFloat(a) / 255.0
        if let priorityAlpha = priorityAlpha {
            alpha = priorityAlpha
        }
        return [red, green, blue, alpha]
    }
    
}
