//
//  SeparatorView.swift
//  BaseVCKit
//
//  Created by frank on 2016. 5. 10..
//  Copyright © 2016년 colavo. All rights reserved.
//

import UIKit

public class SeparatorView: UIView {

    public var lineColor: UIColor {
        didSet {
            if dashedLine {
                setNeedsDisplay()
            }else {
                backgroundColor = lineColor
            }
        }
    }
    public var lineWidth: CGFloat
    public var dashedLine: Bool
    public var isVerticalLine: Bool
    public init(
        lineColor: UIColor,
        lineWidth: CGFloat? = nil,
        dashedLine: Bool = false,
        isVerticalLine: Bool = false
        ) {
        self.lineWidth = lineWidth ?? 1
        self.lineColor = lineColor
        self.dashedLine = dashedLine
        self.isVerticalLine = isVerticalLine
        super.init(frame: CGRect.zero)

        commonInit()
        configureConstraints()
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    public override func draw(_ rect: CGRect) {
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

    private func configureConstraints() {
        if isVerticalLine {
            self.snp.makeConstraints {
                $0.width.equalTo(lineWidth)
            }
        }else {
            self.snp.makeConstraints {
                $0.height.equalTo(lineWidth)
            }
        }
    }


    // MARK: - Init

    private func commonInit() {
        isUserInteractionEnabled = false

        clipsToBounds = true
        if dashedLine {
            backgroundColor = UIColor.clear
        }else {
            backgroundColor = lineColor
        }
    }
}
