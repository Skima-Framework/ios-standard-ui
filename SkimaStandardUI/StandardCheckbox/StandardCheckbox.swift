//
//  StandardCheckbox.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 30/03/2022.
//

import UIKit
import Skima

struct CheckboxProps: WidgetPropsType {
    var variableId: String?
    var initialState: String?
    var initialCondition: Bool?
    var color: String?
    var onActivated: [Action]?
    var onDeactivated: [Action]?
    
    enum CodingKeys: String, CodingKey {
        case variableId
        case initialState = "initial_state"
        case initialCondition = "initial_condition"
        case color
        case onActivated
        case onDeactivated
    }
}

public final class StandardCheckbox: UIView, UIWidget {
    public var widget: Widget
    
    public static var manipulators = [ActionSchema(type: "checkboxManipulation", actionData: CheckboxManipulationData.self)]
    
    private var props: CheckboxProps?
    
    required public init(from widget: Widget) {
        self.widget = widget
        self.props = widget.props as? CheckboxProps
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        autoSetDimensions(to: CGSize(width: 16, height: 16))
        setColor(hex: props?.color)
        setInitialCondition()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapView(_ sender: UITapGestureRecognizer) {
        toggle()
    }
    
    func activate() {
        DataEngine.shared.createOrModify(VariableModel(id: props?.variableId, scopes: widget.scopes, type: "string", value: "true"), from: widget.scopes)
        let img = UILabel()
        img.text = "✅"
        addSubview(img)
        img.autoCenterInSuperview()
    }
    
    func deactivate() {
        DataEngine.shared.createOrModify(VariableModel(id: props?.variableId, scopes: widget.scopes, type: "string", value: "false"), from: widget.scopes)
        subviews.forEach{ $0.removeFromSuperview() }
    }
    
    func toggle() {
        if let _variableId = props?.variableId,
           let condition = DataEngine.shared.getValue(of: _variableId, from: widget.scopes),
           condition == "false" {
            activate()
            props?.onActivated?.execute(from: widget.scopes)
        } else {
            deactivate()
            props?.onDeactivated?.execute(from: widget.scopes)
        }
    }
    
    func setColor(hex: String?) {
        guard let _hex = hex else { return }
        backgroundColor = UIColor(hex: _hex)
    }
    
    private func setInitialCondition() {
        if let condition = props?.initialCondition, condition == false {
            deactivate()
        } else {
            activate()
        }
    }
    
}
