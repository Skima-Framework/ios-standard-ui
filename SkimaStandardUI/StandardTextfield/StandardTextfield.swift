//
//  StandardTextfield.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 24/03/2022.
//

import UIKit
import Skima

struct TextfieldProps: WidgetPropsType {
    let variableId: String?
    let placeholder: String?
    
    enum CodingKeys: String, CodingKey {
        case variableId
        case placeholder
    }
}

final class StandardTextfield: UITextField, UIWidget {
    static var manipulators = [ActionSchema(type: "textfieldManipulation", actionData: TextfieldManipulationData.self)]
    
    var widget: Widget
    private var props: TextfieldProps?
    
    required init(from widget: Widget) {
        self.widget = widget
        self.props = widget.props as? TextfieldProps
        super.init(frame: .zero)
        delegate = self
        configureView()
    }
    
    func setText(text: String?) {
        self.text = text
    }
    
    func enable() {
        isEnabled = true
    }
    
    func disable() {
        isEnabled = false
    }
    
    private func configureView() {
        placeholder = props?.placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StandardTextfield: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let variableId = props?.variableId {
            let newValue = (text as NSString).replacingCharacters(in: range, with: string)
            DataEngine.shared.createOrModify(VariableModel(id: variableId, scopes: widget.scopes, type: "string", value: newValue), from: widget.scopes)
        }
        return true
    }
}
