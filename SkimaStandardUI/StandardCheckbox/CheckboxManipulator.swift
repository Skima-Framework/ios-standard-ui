//
//  CheckboxManipulator.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 30/03/2022.
//

import Skima

final class CheckboxManipulationData: WidgetManipulatorData {

    override func execute(from scope: Scope?) {
        guard let _widgetId = widgetId,
              let _ = WidgetsEngine.shared.getWidgetBy(id: _widgetId, from: scope) as? StandardCheckbox
        else { return }
        
        switch type {
        default:
            break
        }

    }
}
