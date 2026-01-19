//
//  String+Extension.swift
//  StringCatalogsExample
//
//  Created by Batuhan Ulutürk on 4.04.2025.
//

import Foundation

extension String {
    func localized(
        table: LocalizableTables
    ) -> String {
        NSLocalizedString(
            self, tableName: table.rawValue,
            comment: self
        )
    }

    func localizedWithParameter(
        table: LocalizableTables,
        _ args: CVarArg...
    ) -> String {
        let format = self.localized(table: table)
        return String(
            format: format,
            arguments: args
        )
    }
}
