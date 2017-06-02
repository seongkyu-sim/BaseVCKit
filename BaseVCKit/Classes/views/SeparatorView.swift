//
//  SeparatorView.swift
//  BaseVCKit
//
//  Created by frank on 2016. 5. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

class SeparatorView: UIView {

    var lineColor: UIColor {
        didSet {
            if dashedLine {
                setNeedsDisplay()
            }else {
                backgroundColor = lineColor
            }
        }
    }
    var lineWidth: CGFloat
    var dashedLine: Bool
    var isVerticalLine: Bool
    init(lineColor lineColor_: UIColor, lineWidth lineWidth_: CGFloat? = nil, dashedLine dashedLine_: Bool = false, isVerticalLine isVerticalLine_: Bool = false) {
        if let h = lineWidth_ {
            lineWidth = h
        }else {
            //            if isRetinaDisplay() {
            //                lineWidth = 0.5
            //            }else {
            lineWidth = 1
            //            }
        }

        lineColor = lineColor_
        dashedLine = dashedLine_
        isVerticalLine = isVerticalLine_
        super.init(frame: CGRect.zero)

        commonInit()
        configureConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func draw(_ rect: CGRect) {
        super.draw(rect)

        if dashedLine {
            let path = UIBezierPath()

            if isVerticalLine {
                path.move(to: CGPoint(x: rect.midX, y: 0))
                path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            }else {
                path.move(to: CGPoint(x: 0, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            }
            path.lineWidth = lineWidth
            let dashSpace = CGFloat(4)
            let dashes: [CGFloat] = [lineWidth * 2, lineWidth * (dashSpace+1)]
            path.setLineDash(dashes, count: dashes.count, phase: 0)
            path.lineCapStyle = CGLineCap.round

            lineColor.setStroke()
            path.stroke()
        }else {
            if isVerticalLine {
                layer.cornerRadius = rect.width / 2
            }else {
                layer.cornerRadius = rect.height / 2
            }
        }
    }


    // MARK: - Layout

    func configureConstraints() {
        if isVerticalLine {
            self.snp.makeConstraints { (make) in
                make.width.equalTo(lineWidth)
            }
        }else {
            self.snp.makeConstraints { (make) in
                make.height.equalTo(lineWidth)
            }
        }
    }


    // MARK: - Init

    func commonInit() {

        isUserInteractionEnabled = false

        clipsToBounds = true
        if dashedLine {
            backgroundColor = UIColor.clear
        }else {
            backgroundColor = lineColor
        }
    }
}
