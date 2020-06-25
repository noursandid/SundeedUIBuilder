//
//  ViewBuilder + Horizontal.swift
//  SundeedUI
//
//  Created by Nour Sandid on 6/23/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

import UIKit

extension SundeedUIBuilder {
    @discardableResult
    public func alignLeading(with leftView: UIView? = nil) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            addedView.leadingAnchor.constraint(equalTo: (leftView ?? superView).leadingAnchor)
        ])
        return self
    }
    
    @discardableResult
    public func alignTrailing(with rightView: UIView? = nil) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            (rightView ?? superView).trailingAnchor.constraint(equalTo: addedView.trailingAnchor)
        ])
        return self
    }
    
    @discardableResult
    public func toTheLeft(of rightView: UIView) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            rightView.leadingAnchor.constraint(equalTo: addedView.trailingAnchor)
        ])
        return self
    }
    
    @discardableResult
    public func alwaysToTheLeft(of rightView: UIView) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            rightView.leadingAnchor.constraint(greaterThanOrEqualTo: addedView.trailingAnchor)
        ])
        return self
    }
    
    @discardableResult
    public func toTheRight(of leftView: UIView) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            addedView.leftAnchor.constraint(equalTo: leftView.rightAnchor)
        ])
        return self
    }
    
    @discardableResult
    public func alwaysToTheRight(of leftView: UIView) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            addedView.leftAnchor.constraint(greaterThanOrEqualTo: leftView.rightAnchor)
        ])
        return self
    }
    
    @discardableResult
    public func centerHorizontally(with centerView: UIView? = nil) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            addedView.centerXAnchor.constraint(equalTo: (centerView ?? superView).centerXAnchor)
        ])
        return self
    }
    
    @discardableResult
    public func withWidth(equalTo width: CGFloat) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            addedView.widthAnchor.constraint(equalToConstant: width)
        ])
        return self
    }
    
    @discardableResult
    public func withWidth(equalTo constraint: Constraint? = nil, of view: UIView? = nil) -> Self {
        guard let addedView = addedView else { return self }
        guard let anchor: NSLayoutAnchor<NSLayoutDimension> = {
            switch (constraint ?? .width) {
            case .width: return (view ?? addedView).widthAnchor
            case .height: return (view ?? addedView).heightAnchor
            default: return nil
            }}() else { return self }
        
        activate([
            addedView.widthAnchor.constraint(equalTo: anchor)
        ])
        return self
    }
    
    @discardableResult
    public func withMaximumWidth(_ width: CGFloat) -> Self {
        guard let addedView = addedView else { return self }
        getConstraints(.leading, in: superView.constraints).forEach({$0.priority = .defaultHigh})
        getConstraints(.trailing, in: superView.constraints).forEach({$0.priority = .defaultHigh})
        activate([
            addedView.widthAnchor.constraint(lessThanOrEqualToConstant: width)
        ])
        return self
    }
    
    @discardableResult
    public func withMinimumWidth(_ width: CGFloat) -> Self {
        guard let addedView = addedView else { return self }
        getConstraints(.leading, in: superView.constraints).forEach({$0.priority = .defaultHigh})
        getConstraints(.trailing, in: superView.constraints).forEach({$0.priority = .defaultHigh})
        activate([
            addedView.widthAnchor.constraint(greaterThanOrEqualToConstant: width)
        ])
        return self
    }
    
    
}
