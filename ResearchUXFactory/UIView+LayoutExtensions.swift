//
//  UIView+LayoutExtensions.swift
//  ResearchUXFactory
//
//  Copyright © 2016 Sage Bionetworks. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// 1.  Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer.
//
// 2.  Redistributions in binary form must reproduce the above copyright notice,
// this list of conditions and the following disclaimer in the documentation and/or
// other materials provided with the distribution.
//
// 3.  Neither the name of the copyright holder(s) nor the names of any contributors
// may be used to endorse or promote products derived from this software without
// specific prior written permission. No license is granted to the trademarks of
// the copyright holders even if such marks are included in this software.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

import UIKit

extension UIView {
    
    func constrainToFillSuperview(insets: UIEdgeInsets = UIEdgeInsets()) {
        guard let superview = self.superview else {
            assertionFailure("Trying to set constraints without first setting superview")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: superview, attribute: .topMargin, multiplier: 1.0, constant: insets.top)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: superview, attribute: .bottomMargin, multiplier: 1.0, constant: insets.bottom)
        let leftConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: superview, attribute: .leadingMargin, multiplier: 1.0, constant: insets.left)
        let rightConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: superview, attribute: .trailingMargin, multiplier: 1.0, constant: insets.right)
        
        superview.addConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
    }
    
    /**
     * Locks child to its parent with value of horizontalPad for leading, trailing and
     * verticalPad for top, and bottom
     * @param view to add the constraints to
     * @param horizontalPad padding for leading and trailing constraints
     * @param verticalPad padding for top and bottom constraints
     */
    public func constrainToFillSuperviewVisual()
    {
        guard let superview = self.superview else {
            assertionFailure("Trying to set constraints without first setting superview")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-hp-[v]-hp-|",
            options: [],
            metrics: ["hp" : 0],
            views:   ["v"  : self]))
        
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-vp-[v]-vp-|",
            options: [],
            metrics: ["vp" : 0],
            views:   ["v"  : self]))
        
        superview.addConstraints(constraints)
    }

    
    /**
     * Locks child to its parent in top right corner, with top and right padding
     * @param view to add the constraints to
     * @param aspectRatio the aspect ratio for width/height to the superview
     * @param rightPad padding for trailing constraint
     * @param topPad padding for top constraint
     */
    public func constrainToSuperviewAspectInTopRight(aspectRatio: CGFloat, rightPad: CGFloat, topPad: CGFloat)
    {
        guard let superview = self.superview else {
            assertionFailure("Trying to set constraints without first setting superview")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "H:[v]-hp-|",
            options: [],
            metrics: ["hp" : rightPad],
            views:   ["v"  : self]))
        
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-vp-[v]",
            options: [],
            metrics: ["vp" : topPad],
            views:   ["v"  : self]))
        
        constraints.append(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: superview, attribute: .height, multiplier: aspectRatio, constant: 0))
        
        constraints.append(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: superview, attribute: .width, multiplier: aspectRatio, constant: 0))
        
        superview.addConstraints(constraints)
    }
}
