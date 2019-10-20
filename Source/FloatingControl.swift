//
//  FloatingSegmentedControl.swift
//  FloatingSegmentedControl
//
//  Created by Ryuhei Kaminishi on 2019/10/21.
//  Copyright © 2019 catelina777. All rights reserved.
//

import UIKit

open class FloatingSegmentedControl: UIView, NibInstantiatable {
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var backgroundView: UIVisualEffectView!
    @IBOutlet private weak var knob: UIView!
    @IBOutlet private weak var knobXMarginConstraint: NSLayoutConstraint!
    @IBOutlet private weak var knobWidthConstraint: NSLayoutConstraint!

    private var knobXMargin: CGFloat = 0

    var segments: [FloatingSegment] {
        stackView.arrangedSubviews as? [FloatingSegment] ?? []
    }

    open weak var target: NSObject?
    public var action: Selector?

    public var isAnimateFocusMoving = false
    public var focusedIndex: Int = 0 {
        didSet {
            let segmentCount = stackView.arrangedSubviews.count
            if focusedIndex >= segmentCount {
                focusedIndex = (segmentCount > 0) ? segmentCount - 1 : 0
            }
            setNeedsLayout()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    private func setUp() {
        loadNib()
    }

    private func loadNib() {
        let view = FloatingSegmentedControl.fromNib(inBundle: nil, filesOwner: self)
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|",
                                                      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                      metrics: nil,
                                                      views: ["view": view]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                      options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                      metrics: nil,
                                                      views: ["view" : view]))
    }

    open override func awakeFromNib() {
        super.awakeFromNib()

        backgroundView.layer.cornerCurve = .continuous
        backgroundView.clipsToBounds = true
        knob.layer.cornerCurve = .continuous
        knob.clipsToBounds = true
        knobXMargin = knobXMarginConstraint.constant

        setNeedsLayout()
    }

    override open var intrinsicContentSize: CGSize {
        if segments.isEmpty {
            return CGSize(width: frame.height, height: UIView.noIntrinsicMetric)
        }

        let width = stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width + stackView.frame.origin.x * 2
        return CGSize(width: width, height: UIView.noIntrinsicMetric)
    }

    open override func prepareForInterfaceBuilder() {
        invalidateIntrinsicContentSize()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        backgroundView.layer.cornerRadius = backgroundView.bounds.height / 2
    }

    private func updateFocusSegment() {
        knob.layer.cornerRadius = backgroundView.layer.cornerRadius - (backgroundView.bounds.height - knob.bounds.height) / 2
        if focusedIndex < segments.count {
            let targetSegment = segments[focusedIndex]
            let targetFrame = convert(targetSegment.frame, to: targetSegment.superview)

            knob.isHidden = false
            knobWidthConstraint.constant = max(targetFrame.width, knob.frame.height)
            knobXMarginConstraint.constant = targetFrame.origin.x

            if isAnimateFocusMoving {
                UIView.animateWithSystemMotion({
                    self.backgroundView.layoutIfNeeded()
                }, completion: nil)
            }

            targetSegment.setActiveColor()

            for segment in segments where segment != targetSegment {
                segment.setInactiveColor()
            }
        } else {
            knob.isHidden = true
            knobWidthConstraint.constant = knob.frame.height
            knobXMarginConstraint.constant = knobXMargin
        }
    }

    private func index(of segment: FloatingSegment) -> Int? {
        segments.firstIndex(of: segment)
    }

    public func setSegments(with titles: [String]) {
        removeAllSegments()
        titles.forEach {
            let segment: FloatingSegment = FloatingSegment.fromNib()
            segment.floatingSegmentedControl = self
            segment.title = $0
            stackView.addArrangedSubview(segment)
        }
    }

    func removeAllSegments() {
        segments.forEach {
            $0.removeFromSuperview()
        }
    }

    func select(segment: FloatingSegment) {
        if let targetIndex = index(of: segment) {
            focusedIndex = targetIndex
            if let action = action {
                UIApplication.shared.sendAction(action, to: target, from: self, for: nil)
            }
        }
    }
}