//
//  SkimaStandardUI.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 17/03/2022.
//

import Skima

public class SkimaStandardUI: UIModule {
    public static let widgets: [WidgetSchema] = [
        WidgetSchema(type: "label", view: StandardLabel.self, props: LabelProps.self),
        WidgetSchema(type: "button", view: StandardButton.self, props: ButtonProps.self),
        WidgetSchema(type: "image", view: StandardImageView.self, props: ImageProps.self),
        WidgetSchema(type: "textfield", view: StandardTextfield.self, props: TextfieldProps.self),
        WidgetSchema(type: "checkbox", view: StandardCheckbox.self, props: CheckboxProps.self),
        WidgetSchema(type: "container", view: StandardContainer.self, props: ContainerProps.self),
        WidgetSchema(type: "stack", view: StandardStack.self, props: StackProps.self),
        WidgetSchema(type: "scrollview", view: StandardScrollView.self, props: ScrollViewProps.self)
    ]
}
