//
//  EnableManipulation.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 29/03/2022.
//

import Skima

final class ButtonManipulationData: WidgetManipulatorData {
    var widgetId: String?
    var type: String?
    var value: String?
    
    func execute(from scopes: [Scope]?) {
        guard let _widgetId = widgetId,
              let widget = WidgetsEngine.shared.getWidgetBy(id: _widgetId, from: scopes) as? StandardButton
        else { return }
        
        switch type {
        case "change_state":
            switch value {
            case "enable":
                widget.enable()
            case "disable":
                widget.disable()
            default:
                break
            }
        case "change_text":
            widget.setTitle(value, for: .normal)
        default:
            break
        }

    }
}
