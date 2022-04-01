//
//  StandardImageView.swift
//  SkimaStandardUI
//
//  Created by Joaquin Bozzalla on 20/03/2022.
//

import UIKit
import Skima

struct ImageProps: WidgetPropsType {
    var url: String?
    var localResource: Int?
    var contentMode: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case localResource = "local_resource"
        case contentMode = "content_mode"
    }
}

class StandardImageView: UIImageView, UIWidget {
    static var manipulators: [ActionSchema] = [ActionSchema(type: "imageViewManipulation", actionData: ImageViewManipulationData.self)]
    
    var widget: Widget
    private var props: ImageProps?
    
    required init(from widget: Widget) {
        self.widget = widget
        self.props = widget.props as? ImageProps
        super.init(frame: .zero)
        contentMode = resolveContentMode()
        load()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(url: String) {
        props?.url = url
        load()
    }
    
    private func resolveContentMode() -> UIView.ContentMode {
        switch props?.contentMode {
        case "scaleToFill":
            return .scaleToFill
        case "scaleAspectFill":
            return .scaleAspectFill
        case "center":
            return .center
        default:
            return .scaleAspectFit
        }
    }
    
    private func load() {
        guard let str = props?.url, let url = URL(string: str) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
