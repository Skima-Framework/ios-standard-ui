//
//  LabelManipulator.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 29/03/2022.
//

import Skima

final class LabelManipulationData: WidgetManipulatorData {
    
    override func execute(from scopes: [Scope]?) {
        guard let _widgetId = widgetId,
              let widget = WidgetsEngine.shared.getWidgetBy(id: _widgetId, from: scopes) as? StandardLabel
        else { return }
        
        switch type {
        case "change_text":
            widget.setText(text: value)
        case "change_text_color":
            widget.setTextColor(hex: value)
        case "change_font_size":
            if let _value = value, let float = Float(_value) {
                widget.setFontSize(size: CGFloat(float))
            }
        default:
            break
        }

    }
}
