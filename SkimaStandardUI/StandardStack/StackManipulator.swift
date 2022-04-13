//
//  StackManipulator.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 04/04/2022.
//

import Skima

final class StackManipulationData: WidgetManipulatorData {
    var widgetId: String?
    var type: String?
    
    func execute(from scopes: [Scope]?) {
        guard let _widgetId = widgetId,
              let widget = WidgetsEngine.shared.getWidgetBy(id: _widgetId, from: scopes) as? StandardStack
        else { return }
        
        switch type {
        default:
            break
        }

    }
}
