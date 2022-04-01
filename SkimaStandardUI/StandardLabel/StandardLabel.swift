//
//  StandardLabel.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 17/03/2022.
//

import UIKit
import Skima

struct LabelProps: WidgetPropsType {
    var text: String?
    var maxLines: Int?
    var textAlignment: String?
    var textColor: String?
    var fontSize: Double?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case maxLines = "max_lines"
        case textAlignment = "text_alignment"
        case textColor = "text_color"
        case fontSize = "font_size"
    }
}

class StandardLabel: UILabel, UIWidget {
    static var manipulators: [ActionSchema] = [ActionSchema(type: "labelManipulation", actionData: LabelManipulationData.self)]

    var widget: Widget    
    private var props: LabelProps?
    
    required init(from widget: Widget) {
        self.widget = widget
        self.props = widget.props as? LabelProps
        super.init(frame: .zero)
        configureView()
    }
    
    private func configureView() {
        numberOfLines = props?.maxLines ?? 0
        textAlignment = resolveTextAlignment(props?.textAlignment)
        setText(text: props?.text)
        setTextColor(hex: props?.textColor)
        setFontSize(size: props?.fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextColor(hex: String?) {
        guard let _hex = hex else { return }
        textColor = UIColor(hex: _hex)
    }
    
    func setFontSize(size: Double?) {
        guard let _size = size else { return }
        font = font.withSize(CGFloat(_size))
    }
    
    func setText(text: String?) {
        self.text = text
    }
    
    private func resolveTextAlignment(_ textAligment: String?) -> NSTextAlignment {
        switch textAligment {
        case "right":
            return .right
        case "center":
            return .center
        case "justified":
            return .justified
        default:
            return .left
        }
    }
}
