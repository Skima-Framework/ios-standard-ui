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

struct ScrollViewProps: WidgetPropsType {
    var axis: String?
    var distribution: String?
    var alignment: String?
    var spacing: Double?
    var children: [Widget]?
}

class StandardScrollView: UIScrollView, UIWidget {
    var widget: Widget
    static var manipulators: [ActionSchema] = [
        ActionSchema(type: "ScrollViewManipulation", actionData: ScrollViewManipulationData.self)
    ]
    private var props: ScrollViewProps?
    private lazy var stack = UIStackView()
    
    required init(from widget: Widget) {
        self.widget = widget
        self.props = widget.props as? ScrollViewProps
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(stack)
        stack.autoPinEdgesToSuperviewEdges()
        stack.autoMatch(.width, to: .width, of: self)
        
        setAxis(props?.axis)
        setDistribution(props?.distribution)
        setAlignment(props?.alignment)
        setSpacing(props?.spacing)
        setChildren(props?.children)
    }
    
    func setAxis(_ value: String?) {
        switch value {
        case "vertical":
            stack.axis = .vertical
        default:
            stack.axis = .horizontal
        }
    }
    
    func setDistribution(_ value: String?) {
        switch value {
        case "fillEqually":
            stack.distribution = .fillEqually
        case "fillProportionally":
            stack.distribution = .fillProportionally
        case "equalSpacing":
            stack.distribution = .equalSpacing
        case "equalCentering":
            stack.distribution = .equalCentering
        default:
            stack.distribution = .fill
        }
    }
    
    func setAlignment(_ value: String?) {
        switch value {
        case "leading":
            stack.alignment = .leading
        case "trailing":
            stack.alignment = .trailing
        case "firstBaseline":
            stack.alignment = .firstBaseline
        case "lastBaseline":
            stack.alignment = .lastBaseline
        case "top":
            stack.alignment = .top
        case "bottom":
            stack.alignment = .bottom
        case "center":
            stack.alignment = .center
        default:
            stack.alignment = .fill
        }
    }
    
    func setSpacing(_ value: Double?) {
        stack.spacing = value ?? 0
    }
    
    func setChildren(_ children: [Widget]?) {
        guard let _widgets = children else { return }
        WidgetsEngine.shared.render(_widgets, in: stack, scopes: widget.scopes)
    }
}
