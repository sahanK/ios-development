//
//  Double.swift
//  UberSwiftUIClone
//
//  Created by Sahan Walpita on 2023-01-24.
//

import Foundation

extension Double {
  private var currencyFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }
  
  func toCurrency() -> String {
    return currencyFormatter.string(for: self) ?? ""
  }
}
