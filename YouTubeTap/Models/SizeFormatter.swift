//
//  SizeFormatter.swift
//  YouTubeTap
//
//  Created by Kutarba Arthur on 16.03.2022.
//

import UIKit

struct SizeFormatter {
    var iFrameSize: CGSize {
        let rawiFrameSize = CGSize(
            width: 560,
            height: 315
        )
        let ratio = rawiFrameSize.height / rawiFrameSize.width
        let windowSize = UIDevice.currentWindowSize
        return CGSize(
            width: windowSize.width,
            height: windowSize.width * ratio
        )
    }
    
    var iFrameSizePixels: CGSize {
        let size = iFrameSize
        let scale = UIDevice.scale
        return CGSize(
            width: size.width * scale,
            height: size.height * scale
        )
    }
}
