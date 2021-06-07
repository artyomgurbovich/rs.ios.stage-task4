import Foundation

public extension Int {
    var roman: String? {
        guard self >= 1 && self <= 3999 else { return nil }
        var result = ""
        let intValues = String(self).compactMap{Int(String($0))}
        let numbers = [1   :   "I",
                       4   :  "IV",
                       5   :   "V",
                       6   :  "VI",
                       7   : "VII",
                       8   :"VIII",
                       9   :  "IX",
                       10  :   "X",
                       40  :  "XL",
                       50  :   "L",
                       60  :  "LX",
                       70  : "LXX",
                       80  :"LXXX",
                       90  :  "XC",
                       100 :   "C",
                       400 :  "CD",
                       500 :   "D",
                       600 :  "DC",
                       700 : "DCC",
                       800 :"DCCC",
                       900 :  "CM",
                       1000:   "M"]
        for i in 0..<intValues.count {
            let digit = intValues[i]
            let position = Int(pow(Double(10), Double(intValues.count-i-1)))
            let value = digit * position
            if numbers[value] != nil {
                result += numbers[value]!
            } else {
                for _ in 0..<digit {
                    result += numbers[position]!
                }
            }
        }
        return result
    }
}
