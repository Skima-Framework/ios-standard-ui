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

struct ContainerProps: WidgetPropsType {
    let backgroundColor: String?
    let borderColor: String?
    let borderWidth: Double?
    let cornerRadius: Double?
    let children: [Widget]?
    let onClick: [Action]?
}

class StandardContainer: UIView, UIWidget {
    var widget: Widget
    static var manipulators: [ActionSchema] = [
        ActionSchema(type: "containerManipulation", actionData: ContainerManipulationData.self)
    ]
    private var props: ContainerProps?
    
    required init(from widget: Widget) {
        self.widget = widget
        self.props = widget.props as? ContainerProps
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        setBackgroundColor(hex: props?.backgroundColor)
        setBorderColor(hex: props?.borderColor)
        setBorderWidth(width: props?.borderWidth)
        setCornerRadius(radius: props?.cornerRadius)
        addChildren(props?.children)
        addTapGesture()
    }
    
    func setBackgroundColor(hex: String?) {
        if let _color = hex {
            backgroundColor = UIColor.init(hex: _color)
        }
    }
    
    func setBorderColor(hex: String?) {
        if let _color = hex {
            layer.borderColor = UIColor.init(hex: _color)?.cgColor
        }
    }
    
    func setBorderWidth(width: Double?) {
        if let _value = width {
            layer.borderWidth = CGFloat(_value)
        }
    }
    
    func setCornerRadius(radius: Double?) {
        if let _value = radius {
            layer.cornerRadius = CGFloat(_value)
        }
    }
    
    func addChildren(_ children: [Widget]?) {
        guard let _widgets = children else { return }
        WidgetsEngine.shared.render(_widgets, in: self, scopes: widget.scopes)
    }
    
    func addTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        addGestureRecognizer(gesture)
    }
    
    @objc private func onTap() {
        props?.onClick?.execute(from: widget.scopes)
    }
}
