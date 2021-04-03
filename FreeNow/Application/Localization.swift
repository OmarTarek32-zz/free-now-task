//
//  Localization.swift
//  FreeNow
//
//  Created by Omar Tarek on 4/3/21.
//

import Foundation

struct Localization {
    
    enum LocalizationKey: String {
        
        case errorMessageGeneric = "error_message_generic"
        case errorMessageCanNotSendRequest = "error_message_can_not_send_request"
        case errorMessageCanNotReadData = "error_message_can_not_read_data"
        case driversMapDismiss = "drivers_map_dismiss"
        case driversMapShow = "drivers_map_show"
        case driversMapHide = "drivers_map_hide"
        case encounteredProblem = "encountered_problem"
        case driversListEmptyData = "drivers_list_empty_data"
    }
    
    static func string(for key: LocalizationKey) -> String {
        NSLocalizedString(key.rawValue, comment: "")
    }
}
