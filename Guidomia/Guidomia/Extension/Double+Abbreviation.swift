//
//  Double+Abbreviation.swift
//  Guidomia
//
//  Created by michael.p.siapno on 11/14/21.
//

import UIKit

extension Double {
    var formatAbreviation: String {

        if self >= 10000, self <= 999999 {
            return String(format: "%.0fK", locale: Locale.current,self/1000).replacingOccurrences(of: ".0", with: "")
        }

        if self > 999999 {
            return String(format: "%.0fM", locale: Locale.current,self/1000000).replacingOccurrences(of: ".0", with: "")
        }

        return String(format: "%.0f", locale: Locale.current,self)
    }
}
