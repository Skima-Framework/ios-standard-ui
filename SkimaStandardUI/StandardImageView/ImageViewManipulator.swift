//
//  ImageViewManipulator.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 29/03/2022.
//

import Skima

final class ImageViewManipulationData: WidgetManipulatorData {
    var widgetId: String?
    var type: String?
    var value: String?
    
    func execute(from scopes: [Scope]?) {
        guard let _widgetId = widgetId,
              let widget = WidgetsEngine.shared.getWidgetBy(id: _widgetId, from: scopes) as? StandardImageView
        else { return }
        
        switch type {
        case "change_image":
            guard let _value = value else { return }
            widget.setImage(url: _value)
        default:
            break
        }

    }
}
