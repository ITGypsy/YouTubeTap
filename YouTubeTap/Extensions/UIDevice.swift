//
//  UIDevice.swift
//  YouTubeTap
//
//  Created by Kutarba Arthur on 16.03.2022.
//

import UIKit

extension UIDevice {
    static var currentWindowSize: CGSize {
        window?.bounds.size ?? UIScreen.main.bounds.size
    }
    
    static var window: UIWindow? {
        UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
    }
    
    static var scale: CGFloat { UIScreen.main.scale }
}
