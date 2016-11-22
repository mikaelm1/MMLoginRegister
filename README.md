# MMLoginRegister

![Build Status](https://travis-ci.org/mikaelm1/MMLoginRegister.svg?branch=master)

<img src="https://cloud.githubusercontent.com/assets/16492296/20511815/21d4a5dc-b030-11e6-8dc7-29900e3366d7.png" height="380" width="200"/>
<span/>
<img src="https://cloud.githubusercontent.com/assets/16492296/20511818/244c2362-b030-11e6-9e09-b38c08f1bf2e.png" height="380" width="200"/>

## Installing

### Install Using Carthage

1. Add `github "mikaelm1/MMLoginRegister"` to your Cartfile.
2. Run `carthage update --platform iOS --no-use-binaries`
3. Follow [these steps](https://github.com/Carthage/Carthage#getting-started) to add the framework to your project
4. Import the framework.

  ```swift
  import MMLoginRegister
  ``` 
  
### Install Manually 

1. Clone or download the repo
2. Drag the files inside `/Sources` to your project

## Usage

Setup is done programatically inside the view controller that will handle the login and registration.

#### Declare the variable inside your view controller
```swift 
lazy var login: LogRegView = {
    let l = LogRegView(frame: .zero)
    l.translatesAutoresizingMaskIntoConstraints = false
    l.delegate = self
    return l
}()
```

#### Setup the login view as a child of the view controller's view
```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(login)
    login.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    login.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    login.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    login.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
}
```

#### View Controller needs to conform to LogRegViewDelegate
```swift
class ViewController: UIViewController, LogRegViewDelegate {
    func login(withPassword password: String, username: String) {
        print("Login password: \(password) username: \(username)")
    }
    
    func register(withPassword password: String, username: String, email: String) {
        print("Registering password: \(password) username: \(username) email: \(email)")
    }
}
```

### Customise background colors
You can change the colors of the whole view and buttons
```swift 
lazy var login: LogRegView = {
    let l = LogRegView(frame: .zero)
    l.translatesAutoresizingMaskIntoConstraints = false
    l.registerButton.backgroundColor = .red
    l.fieldColor = .white // The background of the text fields 
    l.backgroundColor = .purple
    l.delegate = self
    return l
}()
```

## Note

The delegate methods ensure that text is returned from the text fields. If the user doesn't enter text in any of the fields, the delegate methods won't be called and a red "error" border will appear around the emtpy text field.
