//
//  SundeedUI.swift
//  SundeedUI
//
//  Created by Nour Sandid on 6/23/20.
//  Copyright © 2020 LUMBERCODE. All rights reserved.
//

import UIKit

open class SundeedUIBuilder {
    public enum Constraint {
        case leading
        case trailing
        case top
        case bottom
        case height
        case width
    }
    
    var superView: UIView
    var addedView: UIView?
    var lastAddedConstraints: [NSLayoutConstraint] = []
    public init(_ view: UIView) {
        self.superView = view
    }
    
    @discardableResult
    public func add(_ view: UIView) -> Self {
        addedView = view
        superView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    public func fill(_ parentView: UIView? = nil) -> Self {
        guard let addedView = addedView else { return self }
        activate([
            addedView.leadingAnchor.constraint(equalTo: (parentView ?? superView).leadingAnchor),
            (parentView ?? superView).trailingAnchor.constraint(equalTo: addedView.trailingAnchor),
            (parentView ?? superView).bottomAnchor.constraint(equalTo: addedView.bottomAnchor),
            addedView.topAnchor.constraint(equalTo: (parentView ?? superView).topAnchor)
        ])
        return self
    }
    
    @discardableResult
    public func orAtleastTry() -> Self {
        lastAddedConstraints.forEach({
            $0.priority = .defaultLow
        })
        return self
    }
    
    @discardableResult
    public func except(_ constraint: Constraint) -> Self {
        guard let addedView = addedView else { return self }
        getConstraints(constraint, in: lastAddedConstraints).forEach({
            removeConstraint(with: addedView, specifically: $0)
        })
        return self
    }
    
    @discardableResult
    public func withPadding(_ padding: CGFloat) -> Self {
        lastAddedConstraints.forEach({ $0.constant = padding })
        superView.layoutIfNeeded()
        return self
    }
    
    @discardableResult
    public func withRatio(_ ratio: CGFloat) -> Self {
        lastAddedConstraints.forEach({addedView?.removeConstraint($0)})
        activate(lastAddedConstraints.compactMap({
            guard let item = $0.firstItem else { return nil }
            let constraint = NSLayoutConstraint(item: item,
                                      attribute: $0.firstAttribute,
                                      relatedBy: $0.relation,
                                      toItem: $0.secondItem,
                                      attribute: $0.secondAttribute,
                                      multiplier: ratio,
                                      constant: $0.constant)
            constraint.priority = $0.priority
            return constraint
        }))
        superView.layoutIfNeeded()
        return self
    }
    
    @discardableResult
    public func removeConstraint(with second: UIView,
                          specifically: NSLayoutConstraint? = nil) -> Self {
        guard let addedView = addedView else { return self }
        getConstraint(specifically, in: lastAddedConstraints).forEach {
            superView.removeConstraint($0)
            addedView.removeConstraint($0)
            second.removeConstraint($0)
        }
        return self
    }
    
    
    func activate(_ constraints: [NSLayoutConstraint]) {
        self.lastAddedConstraints = constraints
        NSLayoutConstraint.activate(constraints)
        superView.layoutIfNeeded()
    }
    
    func getConstraint(_ specifically: NSLayoutConstraint?,
                               in constraints: [NSLayoutConstraint]) -> [NSLayoutConstraint]{
        
        guard let specifically = specifically else { return constraints }
        return constraints.filter({
            (($0.firstAnchor == specifically.firstAnchor)
            || ($0.firstAnchor == specifically.secondAnchor)
            || ($0.secondAnchor == specifically.firstAnchor)
            || ($0.secondAnchor == specifically.secondAnchor))
        })
    }
    
    func getConstraints(_ constraint: Constraint, in constraints:[NSLayoutConstraint]) -> [NSLayoutConstraint] {
        guard let addedView = addedView else { return [] }
        return constraints.filter({
            switch constraint {
            case .leading:
                return ![$0.firstAnchor, $0.secondAnchor].filter{$0 == addedView.leadingAnchor}.isEmpty
            case .trailing:
                return ![$0.firstAnchor, $0.secondAnchor].filter{$0 == addedView.trailingAnchor}.isEmpty
            case .top:
                return ![$0.firstAnchor, $0.secondAnchor].filter{$0 == addedView.topAnchor}.isEmpty
            case .bottom:
                return ![$0.firstAnchor, $0.secondAnchor].filter{$0 == addedView.bottomAnchor}.isEmpty
            case .height:
                return ![$0.firstAnchor, $0.secondAnchor].filter{$0 == addedView.heightAnchor}.isEmpty
            case .width:
                return ![$0.firstAnchor, $0.secondAnchor].filter{$0 == addedView.widthAnchor}.isEmpty
            }
        })
    }
    
}
