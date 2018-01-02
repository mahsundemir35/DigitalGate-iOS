import Foundation
import DigitalGate

protocol LoginCoordinatorDelegate: class {
    func loginSucceeded(_ token: String)
    func loginFailure(_ reason: String, errorMessage: String)
    func loginConfigurationFailure(configError: String)
}

class LoginCoordinator: DigitalGate.DGLoginCoordinator {

    // MARK: - LoginCoordinator

    weak var delegate: LoginCoordinatorDelegate?
    override func start(dgFlow: DGFlow) {
        appID = "2"
        useTestServer = true
        disableAutoLogin = false
        autoLoginOnly = false
        disableCell = false
        language = DGLanguage(from: "EN")
        //accessGroup = "F49E5GW326.com.smobi.login.suite"
        super.start(dgFlow: dgFlow)
        configureAppearance()
    }
//
//    override func finish() {
//        super.finish()
//    }

    // MARK: - Setup

    func configureAppearance() {
        
        // Customize the look with background & logo images
        //theme.mainLogoImage = #imageLiteral(resourceName: "Background")
        // mainLogoImage =
        // secondaryLogoImage =
        theme.descriptionTextColor = .green
    }

    // MARK: - Completion Callbacks

    override func login(token: String) {
        // Handle login via your API
        delegate?.loginSucceeded(token)
        print("Login with: email =\(token)")
    }

    override func configurationFailure(configError: String) {
        print(configError)
        delegate?.loginConfigurationFailure(configError: configError)
    }
    
    override func failure(_ reason: String, errorMessage: String) {
        
        if reason == dgKSessionTimeout as String {
            print(errorMessage)
        } else if reason == dgKUserExit as String {
            print(errorMessage)
        } else if reason == dgKNotLoginToLoginSDK as String {
            print(errorMessage)
        }
        delegate?.loginFailure(reason, errorMessage: errorMessage)
    }
}
