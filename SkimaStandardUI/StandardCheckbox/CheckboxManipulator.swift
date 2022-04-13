//
//  CheckboxManipulator.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 30/03/2022.
//

import Skima

final class CheckboxManipulationData: WidgetManipulatorData {
    var widgetId: String?
    var type: String?
    
    func execute(from scopes: [Scope]?) {
        guard let _widgetId = widgetId,
              let _widget = WidgetsEngine.shared.getWidgetBy(id: _widgetId, from: scopes) as? StandardCheckbox
        else { return }
        
        switch type {
        case "activate":
            _widget.activate()
        case "deactivate":
            _widget.deactivate()
        case "toggle":
            _widget.toggle()
        default:
            break
        }

    }
}
