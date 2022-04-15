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
