//
//  CustomNavigationController.swift
//  Social Media App
//
//  Created on 03/08/19.
//  Copyright © 2019. All rights reserved.
//


import UIKit

// MARK: - UIView Extension
@IBDesignable
extension UIView {
    
    
    func addGradientLayer() {
        
        let gl: CAGradientLayer =  CAGradientLayer()
        gl.colors = [ Color.theme1Color.cgColor, Color.theme2Color.cgColor]
        gl.locations = [ 0.0, 1.0]
        //                       gl.startPoint = CGPoint(x: 0.0, y: 1.0)
        //                       gl.endPoint = CGPoint(x: 1.0, y: 1.0)
        gl.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        
        
        self.layer.insertSublayer(gl, at: 0)
    }
    
    private struct AssociatedKey {
        static var rounded = "UIView.rounded"
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return .clear
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return 0.0
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var rounded: Bool {
        get {
            if let rounded = objc_getAssociatedObject(self, &AssociatedKey.rounded) as? Bool {
                return rounded
            } else {
                return false
            }
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKey.rounded,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            layer.cornerRadius = CGFloat(newValue ? 1.0 : 0.0) * min(bounds.width,
                                                                     bounds.height) / 2
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = color.cgColor
      layer.shadowOpacity = opacity
      layer.shadowOffset = offSet
      layer.shadowRadius = radius

      layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}

extension UIView {
    func addBorder(edge: UIRectEdge,
                   color: UIColor,
                   thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0,
                                  y: 0,
                                  width: frame.width,
                                  height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0,
                                  y: frame.height - thickness,
                                  width: frame.width,
                                  height: thickness)
        case .left:
            border.frame = CGRect(x: 0,
                                  y: 0,
                                  width: thickness,
                                  height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness,
                                  y: 0,
                                  width: thickness,
                                  height: frame.height)
        default:
            break
        }
        
        border.backgroundColor = color.cgColor
        
        layer.addSublayer(border)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius,
                                                    height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        self.layer.masksToBounds = true
    }
    
    class func loadFromNibNamed(_ nibNamed: String,
                                bundle: Bundle? = nil) -> UIView? {
        return UINib(nibName: nibNamed,
                     bundle: bundle).instantiate(withOwner: nil,
                                                 options: nil)[0] as? UIView
    }
    
    class func loadFromNibNamedWithViewIndex(_ nibNamed: String,
                                             bundle: Bundle? = nil,
                                             index: Int) -> UIView? {
        return UINib(nibName: nibNamed,
                     bundle: bundle).instantiate(withOwner: nil,
                                                 options: nil)[index] as? UIView
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20, 20, -20, 20, -10, 10, -5, 5, 0]
        animation.autoreverses = false
        layer.add(animation, forKey: "shake")
    }
}

// MARK: - UIFont Extension
extension UIFont {
    
    class func regularFont(with size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Colfax-Regular",
                             size: size) {
            return font
        }
        fatalError("Not able to use app regular font")
    }
    
    class func mediumFont(with size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Colfax-Medium",
                             size: size) {
            return font
        }
        fatalError("Not able to use app medium font")
    }
    
    class func boldFont(with size: CGFloat) -> UIFont {
        if let font = UIFont(name: "Colfax-Bold",
                             size: size) {
            return font
        }
        fatalError("Not able to use app bold font")
    }
    
}

struct TransitionOptions {
    
    /// Curve of animation
    ///
    /// - linear: linear
    /// - easeIn: ease in
    /// - easeOut: ease out
    /// - easeInOut: ease in - ease out
    enum Curve {
        case linear
        case easeIn
        case easeOut
        case easeInOut
        
        /// Return the media timing function associated with curve
        internal var function: CAMediaTimingFunction {
            var key: String = ""
            switch self {
            case .linear:
                key = CAMediaTimingFunctionName.linear.rawValue
            case .easeIn:
                key = CAMediaTimingFunctionName.easeIn.rawValue
            case .easeOut:
                key = CAMediaTimingFunctionName.easeOut.rawValue
            case .easeInOut:
                key = CAMediaTimingFunctionName.easeInEaseOut.rawValue
            }
            return CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: key))
        }
    }
    
    /// Direction of the animation
    ///
    /// - fade: fade to new controller
    /// - toTop: slide from bottom to top
    /// - toBottom: slide from top to bottom
    /// - toLeft: pop to left
    /// - toRight: push to right
    enum Direction {
        case fade
        case toTop
        case toBottom
        case toLeft
        case toRight
        
        /// Return the associated transition
        ///
        /// - Returns: transition
        internal func transition() -> CATransition {
            let transition = CATransition()
            transition.type = CATransitionType.push
            switch self {
            case .fade:
                transition.type = CATransitionType.fade
                transition.subtype = nil
            case .toLeft:
                transition.subtype = CATransitionSubtype.fromLeft
            case .toRight:
                transition.subtype = CATransitionSubtype.fromRight
            case .toTop:
                transition.subtype = CATransitionSubtype.fromTop
            case .toBottom:
                transition.subtype = CATransitionSubtype.fromBottom
            }
            return transition
        }
    }
    
    /// Background of the transition
    ///
    /// - solidColor: solid color
    /// - customView: custom view
    enum Background {
        case solidColor(_: UIColor)
        case customView(_: UIView)
    }
    
    /// Duration of the animation (default is 0.20s)
    public var duration: TimeInterval = 0.20
    
    /// Direction of the transition (default is `toRight`)
    public var direction: TransitionOptions.Direction = .toRight
    
    /// Style of the transition (default is `linear`)
    public var style: TransitionOptions.Curve = .linear
    
    /// Background of the transition (default is `nil`)
    public var background: TransitionOptions.Background?
    
    /// Initialize a new options object with given direction and curve
    ///
    /// - Parameters:
    ///   - direction: direction
    ///   - style: style
    public init(direction: TransitionOptions.Direction = .toRight, style: TransitionOptions.Curve = .linear) {
        self.direction = direction
        self.style = style
    }
    
    public init() { }
    
    /// Return the animation to perform for given options object
    internal var animation: CATransition {
        let transition = self.direction.transition()
        transition.duration = self.duration
        transition.timingFunction = self.style.function
        return transition
    }
}

extension UIScreen {
    static var hasTopNotch: Bool {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    static var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    static var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    var width: CGFloat {
        return self.bounds.size.width
    }
    var height: CGFloat {
        return self.bounds.size.height
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}

extension UIButton {
    
    @objc func removeGradient(){
        if self.layer.sublayers != nil {
            if self.layer.sublayers!.count > 0 {
                for layer1 in self.layer.sublayers ?? []{
                    if layer1 is CAGradientLayer {
                        layer1.removeFromSuperlayer()
                    }
                }
                
            }
            // forEach { $0.removeFromSuperlayer() }
        }
    }
    @objc func addGradient() {
        //self.removeGradient()
        
        let gl: CAGradientLayer =  CAGradientLayer()
        
        gl.colors = [ Color.theme1Color.cgColor, Color.theme2Color.cgColor]
        gl.locations = [ 0.0, 1.0]
        gl.startPoint = CGPoint(x: 0.0, y: 1.0)
        gl.endPoint = CGPoint(x: 1.0, y: 1.0)
        gl.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        
        
        self.layer.insertSublayer(gl, at: 0)
    }
    
    @objc func addGradient(wdh:CGFloat) {
        //self.removeGradient()
        
        let gl: CAGradientLayer =  CAGradientLayer()
        
        gl.colors = [ Color.theme1Color.cgColor, Color.theme2Color.cgColor]
        gl.locations = [ 0.0, 1.0]
        gl.startPoint = CGPoint(x: 0.0, y: 1.0)
        gl.endPoint = CGPoint(x: 1.0, y: 1.0)
        gl.frame = CGRect(x: 0.0, y: 0.0, width: wdh, height: self.frame.size.height)
        
        
        self.layer.insertSublayer(gl, at: 0)
    }
    

    
    func alignVertical(spacing: CGFloat = 6.0) {
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else { return }
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0,
                                            left: -imageSize.width,
                                            bottom: -(imageSize.height + spacing),
                                            right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing),
                                            left: 0.0,
                                            bottom: 0.0,
                                            right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset,
                                              left: 0.0,
                                              bottom: edgeOffset,
                                              right: 0.0)
    }
}

extension UITableView {
    
    var isTableHeaderViewVisible: Bool {
        guard let tableHeaderView = tableHeaderView else {
            return false
        }
        
        let currentYOffset = self.contentOffset.y
        let headerHeight = tableHeaderView.frame.size.height
        
        return currentYOffset < headerHeight
    }
    
}

extension Notification.Name {
    static let reachabilityChanged = Notification.Name("reachabilityChanged")
    static let pendindSurveyCountChanged = Notification.Name("pendindSurveyCountChanged")
    static let triggerSurvey = NSNotification.Name(rawValue: "TRIGGER SURVEY?")
    static let askTriggerSurvey = NSNotification.Name(rawValue: "SURVEY TRIGGER")
    static let pushSurveyWebview = NSNotification.Name(rawValue: "SURVEY WEBVIEW")
    static let rewardPoints = NSNotification.Name(rawValue: "SURVEY REWARD POINTS")
}

extension Dictionary {
    mutating func merge(_ dict: [Key: Value]) {
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}



extension NSDictionary {
    
    func objectForKeyIsNull(key:String) -> Bool {
        if self.object(forKey:key) is NSNull{
            return true
        }
        if (self.object(forKey:key) == nil) {
            return true
        }
        return false
    }
    
    
    func objectForKeyAsString(key:String) -> String {
        
        if (self.object(forKey:key) == nil) {
            return ""
        }
        
        if self.object(forKey:key) is NSNull{
            return ""
        }
        return String(format:"%@",self.object(forKey:key) as! CVarArg)
    }
    
    
    func objectForKeyAsDouble(key:String) -> Double {
        if self.object(forKey:key) is NSNull{
            return 0
        }
        
        if (self.object(forKey:key) == nil) {
            return 0
        }
        
        return Double(String(format:"%@",self.object(forKey:key) as! CVarArg))!
    }
    
    
    func objectForKeyAsInt(key:String) -> Int {
        if self.object(forKey:key) is NSNull{
            return 0
        }
        
        if (self.object(forKey:key) == nil) {
            return 0
        }
        return Int(String(format:"%@",self.object(forKey:key) as! CVarArg))!
    }
}

