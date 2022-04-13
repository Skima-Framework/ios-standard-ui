//
//  ScrollViewManipulator.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 11/04/2022.
//

import Skima

final class ScrollViewManipulationData: WidgetManipulatorData {
    var widgetId: String?
    var type: String?
    
    func execute(from scopes: [Scope]?) {
        guard let _widgetId = widgetId,
              let widget = WidgetsEngine.shared.getWidgetBy(id: _widgetId, from: scopes) as? StandardScrollView
        else { return }
        
        switch type {
        default:
            break
        }

    }
}
