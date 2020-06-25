![Sundeed](https://raw.githubusercontent.com/noursandid/SundeedUIBuilder/master/SundeedLogo.png)

# SundeedUIBuilder

![Example1](https://raw.githubusercontent.com/noursandid/SundeedUIBuilder/master/screenshots/Example1.png)

# Features
###### General
- **add(_ view: UIView)**: adds the view in the parent view selected
- **fill(_ parentView: UIView? = nil)**: adds all the necessary constraints to let the subview cover the parent view
- **except(_ constraint: Constraint)**: removes one constraint from the already added, this is mainly used after filling
- **orAtleastTry()**: lowers the priority of the constraint added
- **withPadding(_ padding: CGFloat)**: adds a padding for the constraints added
- **withRatio(_ ratio: CGFloat)**: adds a multiplier for the constraints added
- **removeConstraint(with second: UIView, specifically: NSLayoutConstraint? = nil)**: removes either all the constraints between the view added and the second view, or you can specify which one exactly

###### Horizontal
- **alignLeading(with leftView: UIView? = nil)**: aligns the view either with the parent, or you can specify another view to align to its leading
- **alignTrailing(with rightView: UIView? = nil)**: aligns the view either with the parent, or you can specify another view to align to its trailing
- **toTheLeft(of rightView: UIView)**: adds a constraint between the added view and a view to its right
- **alwaysToTheLeft(of rightView: UIView)**: adds a constraint to make sure that what ever happens with the added view, it will always be to the left of a view
- **toTheRight(of leftView: UIView)**: adds a constraint between the added view and a view to its left
- **alwaysToTheRight(of leftView: UIView)**: adds a constraint to make sure that what ever happens with the added view, it will always be to the right of a view
- **centerHorizontally(with centerView: UIView? = nil)**: adds a constraint to center horizontally the added view with another view
- **withWidth(equalTo width: CGFloat)**: sets the width of the added view equal to a constant
- **withWidth(equalTo constraint: Constraint? = nil, of view: UIView? = nil)**: adds a constraint to make the added wiew's width equal to another view's constraint (e.g: equal to another view's width), or equal to its own height constraint
- **withMaximumWidth(_ width: CGFloat)**: adds a constraint to make sure that what ever happens with the added view, it will always have the width less than a value
- **withMinimumWidth(_ width: CGFloat)**: adds a constraint to make sure that what ever happens with the added view, it will always have the width greater than a value

###### Vertical
- **alignTop(with topView: UIView? = nil)**: aligns the view either with the parent, or you can specify another view to align to its top
- **alignBottom(with bottomView: UIView? = nil)**: aligns the view either with the parent, or you can specify another view to align to its bottom
- **onTop(of bottomView: UIView)**: adds a constraint between the added view and a view under it
- **alwaysOnTop(of bottomView: UIView)**: adds a constraint to make sure that what ever happens with the added view, it will always be on top of a view
- **under(of topView: UIView)**: adds a constraint between the added view and a view above it
- **alwaysUnder(of topView: UIView)**: adds a constraint to make sure that what ever happens with the added view, it will always be under a view
- **centerVertically(with centerView: UIView? = nil)**: adds a constraint to center vertically the added view with another view
- **withHeight(equalTo height: CGFloat)**: sets the height of the added view equal to a constant
- **withHeight(equalTo constraint: Constraint? = nil, of view: UIView? = nil)**: adds a constraint to make the added wiew's height equal to another view's constraint (e.g: equal to another view's height), or equal to its own width constraint
- **withMaximumHeight(_ height: CGFloat)**: adds a constraint to make sure that what ever happens with the added view, it will always have the height less than a value
- **withMinimumHeight(_ height: CGFloat)**: adds a constraint to make sure that what ever happens with the added view, it will always have the height greater than a value

# Example
You can see the output in the screenshot above
```swift
import UIKit

class ViewController: UIViewController {
    let scrollView: UIScrollView = UIScrollView()
    let logoImageView: UIImageView = UIImageView()
    let loginButton: UIButton = UIButton()
    let credentialsView: UIView = UIView()
    let usernameTextField: UITextField = UITextField()
    let passwordTextField: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageView.image = UIImage(named: "logo")
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemGreen
        usernameTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        
        SundeedUIBuilder(view).add(scrollView)
            .fill()
            .except(.bottom)
            .except(.top)
            .alignTop()
            .withPadding(74)
        
        SundeedUIBuilder(scrollView).add(logoImageView)
            .alignTop()
            .withHeight(equalTo: 200)
            .alignTrailing()
            .alignLeading()
            .withMaximumWidth(450)
            .centerHorizontally()
        
        SundeedUIBuilder(view).add(loginButton)
            .under(scrollView)
            .alignLeading().withPadding(16)
            .alignTrailing().withPadding(16)
            .alignBottom().withPadding(64)
            .withHeight(equalTo: 64)
        
        SundeedUIBuilder(scrollView).add(credentialsView)
            .alignLeading().withPadding(16)
            .alignTrailing().withPadding(16)
            .withWidth(of: view).withPadding(-32).orAtleastTry()
            .withMaximumWidth(950)
            .centerHorizontally()
            .under(logoImageView).withPadding(64)
            .alignBottom().withPadding(32)
        
        SundeedUIBuilder(credentialsView).add(usernameTextField)
            .alignLeading().withPadding(8)
            .alignTrailing().withPadding(8)
            .withHeight(equalTo: 74)
            .alignTop().withPadding(8)
        
        SundeedUIBuilder(credentialsView).add(passwordTextField)
            .alignLeading().withPadding(8)
            .alignTrailing().withPadding(8)
            .under(usernameTextField).withPadding(32)
            .withHeight(equalTo: 74)
            .alignBottom()
            .withHeight(equalTo: .height, of: usernameTextField)
    }
}
```
