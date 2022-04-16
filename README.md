The Standard UI Library contains a bunch of basic Widgets that are enough to create a simple app or are used to create more complex ones.

# Installation

```bash title="Podfile"
pod 'SkimaStandardUI'
```

# Registration

```js title="AppDelegate.swift"
import Skima
import SkimaStandardUI

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    WidgetsEngine.shared.registerOrReplace(SkimaStandardUI.self)
    return true
}
```

# Standard Widgets

## Button

#### Type
`button`

#### Props
* **initial_state** (string): `enable`, `disable`, `loading`. Default is `enable`.
* **text** (string)
* **type** (string): `primary`, `secondary`, `link`. Default is `primary`.
* **onClick**: ([Action])

#### Example
```json title="Widget"
{
    "type": "button",
    "id": "button_1",
    "props": {
        "text": "Press me!"
    }
}
```

#### Manipulator
* **widgetId** (string): Identifier of the button to manipulate.
* **type** (string): `change_state`, `change_text`.
* **value** (string):
    * If `change_state` then value could be `enable`, `disable`, `loading`.
    * If `change_text` then value is the new text.

#### Example
```json title="Action"
{
    "type": "buttonManipulation",
    "data": {
        "widgetId": "button_1",
        "type": "change_state",
        "value": "disable"
    }
}
```

## Label

#### Type
`label`

#### Props
* **text** (string)
* **max_lines** (integer)
* **text_alignment** (string): `left`, `right`, `center`, `justified`. Default is `left`.
* **text_color** (string): must be hexadecimal, eg `#FF0000`
* **font_size** (number)

#### Example
```json title="Widget"
{
    "type": "label",
    "id": "label_1",
    "props": {
        "text": "This is a label!",
        "text_alignment": "center",
        "text_color": "#FF0000",
        "font_size": 24
    }
}
```

#### Manipulator
* **widgetId** (string): Identifier of the label to manipulate.
* **type** (string): `change_text`, `change_text_color`, `change_font_size`.
* **value** (string):
    * If `change_text` then value is the new text.
    * If `change_text_color` then value must be an hexadecimal color, eg `#FF0000`
    * If `change_font_size` then value must be a number but as string, eg `"16"`

#### Example
```json title="Action"
{
    "type": "labelManipulation",
    "data": {
        "widgetId": "label_1",
        "type": "change_text",
        "value": "This is a changed label!"
    }
}
```

## Image

#### Type
`image`

#### Props
* **url** (string)
* **local_resource** (string): Not implemented yet
* **content_mode** (string): `scaleToFill`, `caleAspectFit`, `scaleAspectFill`, `center`

#### Example
```json title="Widget"
{
    "type": "image",
    "id": "image_1",
    "props": {
        "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Apple_logo_black.svg/814px-Apple_logo_black.svg.png",
        "content_mode": "scaleAspectFit"
    }
}
```

#### Manipulator
* **widgetId** (string): Identifier of the image to manipulate.
* **type** (string): `change_image`
* **value** (string):
    * If `change_image` then value is the url of the new image.

#### Example
```json title="Action"
{
    "type": "imageManipulation",
    "data": {
        "widgetId": "image_1",
        "type": "change_image",
        "value": "https://source.android.com/setup/images/Android_symbol_green_RGB.png"
    }
}
```

## Textfield

#### Type
`textfield`

#### Props
* **variableId** (string): Is the Identifier of the variable where the content of the textfield will be saved.
* **placeholder** (string)

#### Example
```json title="Widget"
{
    "type": "textfield",
    "id": "textfield_1",
    "props": {
        "variableId": "name_textfield_value",
        "placeholder": "Name"
    }
}
```

#### Manipulator
* **widgetId** (string): Identifier of the textfield to manipulate.
* **type** (string): `change_text`
* **value** (string):
    * If `change_text` then value is the new text

#### Example
```json title="Action"
{
    "type": "textfieldManipulation",
    "data": {
        "widgetId": "textfield_1",
        "type": "change_image",
        "value": ""
    }
}
```

## Checkbox

#### Type
`checkbox`

#### Props
* **variableId** (string): Is the Identifier of the variable where the state of the checkbox will be saved.
* **initial_state** (string): `enable`, `disable`. Default is `enable`.
* **initial_condition** (boolean): if `true` then the checkbox will start checked.
* **color**: (string): must be hexadecimal, eg `#FF0000`
* **onActivated** ([Action]): Actions that are executed when the checkbox is checked.
* **onDeactivated** ([Action]): Actions that are executed when the checkbox is unchecked.

#### Example
```json title="Widget"
{
    "type": "checkbox",
    "id": "checkbox_1",
    "props": {
        "variableId": "checkbox_value",
        "initial_condition": false
    }
}
```

#### Manipulator
* **widgetId** (string): Identifier of the checkbox to manipulate.
* **type** (string): `activate`, `deactivate`, `toggle`

#### Example
```json title="Action"
{
    "type": "checkboxManipulation",
    "data": {
        "widgetId": "checkbox_1",
        "type": "activate"
    }
}
```

## Container

#### Type
`container`

#### Props
* **backgroundColor** (string): Must be hexadecimal, eg `#FF0000`
* **borderColor** (string): Must be hexadecimal, eg `#FF0000`
* **BorderWidth** (number)
* **cornerRadius**: (number)
* **children** ([Widget]): Array of Widgets to render inside the container.
* **onClick** ([Action]): Actions that are executed when the container is tapped.

#### Example
```json
{
    "type": "container",
    "props": {
        "backgroundColor": "#FF0000",
        "borderColor": "#00FF00",
        "borderWidth": 4,
        "cornerRadius": 16
    }
}
```

## Stack

#### Type
`stack`

#### Props
* **children** ([Widget]): Array of Widgets to render inside the stack.
* **axis** (string): `horizontal`, `vertical`
* **spacing** (number)
* **alignment** (string): `fill`, `leading`, `firstBaseline`, `center`, `trailing`, `bottom`, `top`, `lastBaseline`. Default is `fill`.
* **distribution** (string): `fill`, `fillEqually`, `fillProportionally`, `equalSpacing`, `equalCentering`. Default is `fill`.

#### Example
```json
{
    "type": "stack",
    "props": {
        "axis": "vertical",
        "spacing": 8,
        "children": []
    }
}
```

## ScrollView

#### Type
`scrollview`

#### Props
* **children** ([Widget]): Array of Widgets to render inside the stack.
* **axis** (string): `horizontal`, `vertical`
* **spacing** (number)
* **alignment** (string): `fill`, `leading`, `firstBaseline`, `center`, `trailing`, `bottom`, `top`, `lastBaseline`. Default is `fill`.
* **distribution** (string): `fill`, `fillEqually`, `fillProportionally`, `equalSpacing`, `equalCentering`. Default is `fill`.

#### Example
```json
{
    "type": "scrollview",
    "props": {
        "axis": "vertical",
        "spacing": 8,
        "children": []
    }
}
```
