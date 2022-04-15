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

import UIKit
import Skima

struct StackProps: WidgetPropsType {
    var axis: String?
    var distribution: String?
    var alignment: String?
    var spacing: Double?
    var children: [Widget]?
}

class StandardStack: UIStackView, UIWidget {
    var widget: Widget
    static var manipulators: [ActionSchema] = [
        ActionSchema(type: "stackManipulation", actionData: StackManipulationData.self)
    ]
    private var props: StackProps?
    
    required init(from widget: Widget) {
        self.widget = widget
        self.props = widget.props as? StackProps
        super.init(frame: .zero)
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        setAxis(props?.axis)
        setDistribution(props?.distribution)
        setAlignment(props?.alignment)
        setSpacing(props?.spacing)
        setChildren(props?.children)
    }
    
    func setAxis(_ value: String?) {
        switch value {
        case "vertical":
            axis = .vertical
        default:
            axis = .horizontal
        }
    }
    
    func setDistribution(_ value: String?) {
        switch value {
        case "fillEqually":
            distribution = .fillEqually
        case "fillProportionally":
            distribution = .fillProportionally
        case "equalSpacing":
            distribution = .equalSpacing
        case "equalCentering":
            distribution = .equalCentering
        default:
            distribution = .fill
        }
    }
    
    func setAlignment(_ value: String?) {
        switch value {
        case "leading":
            alignment = .leading
        case "trailing":
            alignment = .trailing
        case "firstBaseline":
            alignment = .firstBaseline
        case "lastBaseline":
            alignment = .lastBaseline
        case "top":
            alignment = .top
        case "bottom":
            alignment = .bottom
        case "center":
            alignment = .center
        default:
            alignment = .fill
        }
    }
    
    func setSpacing(_ value: Double?) {
        spacing = value ?? 0
    }
    
    func setChildren(_ children: [Widget]?) {
        guard let _widgets = children else { return }
        WidgetsEngine.shared.render(_widgets, in: self, scopes: widget.scopes)
    }
}
