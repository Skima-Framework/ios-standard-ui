//
//  ContainerManipulator.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 01/04/2022.
//

import Skima

final class ContainerManipulationData: WidgetManipulatorData {
    var widgetId: String?
    
    func execute(from scopes: [Scope]?) {
        guard let _widgetId = widgetId,
              let _ = WidgetsEngine.shared.getWidgetBy(id: _widgetId, from: scopes) as? StandardButton
        else { return }

    }
}
