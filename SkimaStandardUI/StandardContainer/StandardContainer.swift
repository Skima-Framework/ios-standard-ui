//
//  StandardContainer.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 01/04/2022.
//

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
