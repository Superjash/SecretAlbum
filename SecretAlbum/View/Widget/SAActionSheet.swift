//
//  SAActionSheet.swift
//  SecretAlbum
//
//  Created by Jash on 2019/1/17.
//  Copyright © 2019 Jash. All rights reserved.
//

import UIKit

typealias SAActionSheetHandler = (_ action: SAAction?) -> Void

enum SAActionStyle {
    case `default`, cancel, destructive
}

class SAAction {
    let handler: SAActionSheetHandler?
    let title: String
    let style: SAActionStyle
    init(title: String, style: SAActionStyle = .default, handler: SAActionSheetHandler? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}

class SAActionSheet: UIView {
    
    var hideHandler: (() -> Void)?
    
    private var actions: [SAAction] = []
    
    private let backgroundView: UIView
    private let containerView: UIView
    
    public init(title: String? = nil) {
        backgroundView = UIView()
        containerView = UIView()
        super.init(frame: UIScreen.main.bounds)
        
        addSubview(backgroundView)
        addSubview(containerView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        backgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: backgroundView)
        if !containerView.frame.contains(point) {
            hide()
            for action in actions {
                if action.style == .cancel {
                    action.handler?(action)
                    break
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show() {
        
        let windows = UIApplication.shared.windows.filter { NSStringFromClass($0.classForCoder) != "UIRemoteKeyboardWindow" }
        guard let win = windows.last else { return }
        
        buildUI()
        
        win.addSubview(self)
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 1.0
            let y = self.bounds.height - self.containerView.frame.height
            self.containerView.frame.origin = CGPoint(x: 0.0, y: y)
        }
    }
    
    public func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundView.alpha = 0
            let y = self.superview?.frame.height ?? UIScreen.main.bounds.height
            self.containerView.frame.origin = CGPoint(x: 0.0, y: y)
        }) { _ in
            self.hideHandler?()
            self.removeFromSuperview()
        }
    }
    
    public func addAction(_ action: SAAction) {
        actions.append(action)
    }
    
    private func buildUI() {
        
        isUserInteractionEnabled = true
        backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        backgroundView.frame = bounds
        backgroundView.alpha = 0
        containerView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        var y: CGFloat = 0.0
        for (index, action) in actions.enumerated() {
            let actionButton = UIButton(type: .system)
            actionButton.tag = index
            actionButton.addTarget(self, action: #selector(handleActionButtonTapped(_:)), for: .touchUpInside)
            actionButton.backgroundColor = UIColor.white.withAlphaComponent(0.1)
            actionButton.setTitle(action.title, for: .normal)
            actionButton.setTitleColor(UIColor.saGray(1), for: .normal)
            if action.style == .cancel {
                actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            } else {
                actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            }
            containerView.addSubview(actionButton)
            
            if action.style == .cancel {
                y += 10.0
            }
            actionButton.frame = CGRect(x: 0, y: y, width: bounds.width, height: 50)
            
            y += actionButton.frame.height
        }
        if UserInterfaceConstants.isXScreenLayout {
            let holderView = UIView(frame: CGRect(x: 0, y: y, width: bounds.width, height: keyWindowSafeAreaInsets.bottom))
            holderView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
            containerView.addSubview(holderView)
            
            y += keyWindowSafeAreaInsets.bottom
        }
        
        containerView.frame = CGRect(x: 0.0, y: bounds.height, width: bounds.width, height: y)
        
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        effectView.frame = containerView.bounds
        containerView.addSubview(effectView)
        containerView.sendSubviewToBack(effectView)
    }
    
    @objc private func handleActionButtonTapped(_ sender: UIButton) {
        let action = actions[sender.tag]
        action.handler?(action)
        hide()
    }
}
