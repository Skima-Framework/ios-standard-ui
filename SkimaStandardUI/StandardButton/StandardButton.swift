//
//  StandardButton.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 17/03/2022.
//

import UIKit
import Skima

struct ButtonProps: WidgetPropsType {
    var initialState: String?
    var text: String?
    var type: String?
    var onClick: [Action]?
    
    enum CodingKeys: String, CodingKey {
        case initialState = "initial_state"
        case text
        case type
        case onClick
    }
}

class StandardButton: UIButton, UIWidget {
    var widget: Widget
    static var manipulators: [ActionSchema] = [
        ActionSchema(type: "buttonManipulation", actionData: ButtonManipulationData.self)
    ]
    private var props: ButtonProps?
    
    required init(from widget: Widget) {
        self.widget = widget
        self.props = widget.props as? ButtonProps
        super.init(frame: .zero)
        configureView()
    }
    
    private func configureView() {
        setTitle(props?.text, for: .normal)
        setInitialState()
        setStyle()
        addTarget(self, action: #selector(onClick), for: .touchUpInside)
    }
    
    private func setInitialState() {
        switch props?.initialState {
        case "disable":
            isEnabled = false
        default:
            isEnabled = true
        }
    }
    
    private func setStyle() {
        switch props?.type {
        case "secondary":
            setSecondaryStyle()
        case "link":
            setLinkStyle()
        default:
            setPrimaryStyle()
        }
    }
    
    func enable() {
        isEnabled = true
        setStyle()
    }
    
    func disable() {
        isEnabled = false
        setStyle()
    }
    
    private func setPrimaryStyle() {
        setTitleColor(.white, for: .normal)
        backgroundColor = isEnabled ? .systemBlue : .gray
        layer.cornerRadius = 16
    }
    
    private func setSecondaryStyle() {
        let txtColor = isEnabled ? UIColor.black : UIColor.gray
        setTitleColor(txtColor, for: .normal)
        backgroundColor = .clear
        layer.cornerRadius = 16
        layer.borderColor = isEnabled ? UIColor.black.cgColor : UIColor.gray.cgColor
        layer.borderWidth = 2
    }
    
    private func setLinkStyle() {
        let txtColor = isEnabled ? UIColor.black : UIColor.gray
        setTitleColor(txtColor, for: .normal)
        backgroundColor = .clear
    }
    
    @objc func onClick() {
        props?.onClick?.execute(from: widget.scopes)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
