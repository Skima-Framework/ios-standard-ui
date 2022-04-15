/**
*  Skima Framework
*  Copyright (C) 2022 Joaquin Bozzalla
*
*  This program is free software: you can redistribute it and/or modify
*  it under the terms of the GNU Affero General Public License as published by
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU Affero General Public License for more details.
*
*  You should have received a copy of the GNU Affero General Public License
*  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import Skima

final class LabelManipulationData: WidgetManipulatorData {
    var widgetId: String?
    var type: String?
    var value: String?
    
    func execute(from scopes: [Scope]?) {
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
