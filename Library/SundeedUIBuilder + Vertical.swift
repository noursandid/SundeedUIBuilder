//
//  ViewBuilder + Vertical.swift
//  SundeedUI
//
//  Created by Nour Sandid on 6/23/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

import UIKit

extension SundeedUIBuilder {
    @discardableResult
    func alignTop(with topView: UIView? = nil) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            addedView.topAnchor.constraint(equalTo: (topView ?? superView).topAnchor)
        ])
        return self
    }
    
    @discardableResult
    func alignBottom(with bottomView: UIView? = nil) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            (bottomView ?? superView).bottomAnchor.constraint(equalTo: addedView.bottomAnchor)
        ])
        return self
    }
    
    @discardableResult
    func onTop(of bottomView: UIView) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            bottomView.topAnchor.constraint(equalTo: addedView.bottomAnchor)
        ])
        return self
    }
    
    @discardableResult
    func alwaysOnTop(of bottomView: UIView) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            bottomView.topAnchor.constraint(greaterThanOrEqualTo: addedView.bottomAnchor)
        ])
        return self
    }
    
    @discardableResult
    func under(_ topView: UIView) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            addedView.topAnchor.constraint(equalTo: topView.bottomAnchor)
        ])
        return self
    }
    
    @discardableResult
    func alwaysUnder(_ topView: UIView) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            addedView.topAnchor.constraint(greaterThanOrEqualTo: topView.bottomAnchor)
        ])
        return self
    }
    
    @discardableResult
    func centerVertically(with centerView: UIView? = nil) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            addedView.centerYAnchor.constraint(equalTo: (centerView ?? superView).centerYAnchor)
        ])
        return self
    }
    
    @discardableResult
    func withHeight(equalTo height: CGFloat) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            addedView.heightAnchor.constraint(equalToConstant: height)
        ])
        return self
    }
    
    @discardableResult
    func withHeight(equalTo constraint: Constraint? = nil, of view: UIView? = nil) -> Self {
        guard let addedView = addedView else { return self }
        guard let anchor: NSLayoutAnchor<NSLayoutDimension> = {
            switch (constraint ?? .height) {
            case .width: return (view ?? addedView).widthAnchor
            case .height: return (view ?? addedView).heightAnchor
            default: return nil
            }}() else { return self }
        
        activate([
            addedView.heightAnchor.constraint(equalTo: anchor)
        ])
        return self
    }
    
    @discardableResult
    func withMaximumHeight(_ height: CGFloat) -> Self {
        guard let addedView = addedView else { return self }
        getConstraints(.top, in: superView.constraints).forEach({$0.priority = .defaultHigh})
        getConstraints(.bottom, in: superView.constraints).forEach({$0.priority = .defaultHigh})
        activate([
            addedView.heightAnchor.constraint(lessThanOrEqualToConstant: height)
        ])
        return self
    }
    
    @discardableResult
    func withMinimumHeight(_ height: CGFloat) -> Self {
        guard let addedView = addedView else { return self }
        getConstraints(.top, in: superView.constraints).forEach({$0.priority = .defaultHigh})
        getConstraints(.bottom, in: superView.constraints).forEach({$0.priority = .defaultHigh})
        activate([
            addedView.heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        ])
        return self
    }
}
