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
