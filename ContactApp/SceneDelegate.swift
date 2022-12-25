//
//  SceneDelegate.swift
//  ContactApp
//
//  Created by rishab-13586 on 08/12/22.
//

import UIKit
import ZCCoreFramework

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set <UIOpenURLContext> ) {
        if let context = URLContexts.first {
            let _ = ZohoAuth.handleURL(context.url, sourceApplication: context.options.sourceApplication, annotation: context.options.annotation)
        }
    }
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
//        guard let _ = (scene as? UIWindowScene) else { return }
//        guard let windowScene = (scene as? UIWindowScene) else { return }

    
        configureApp()
        Creator.configure(delegate: self)
        
        // To verify if the app is already logged in

        ZohoAuth.getOauth2Token { [self] (token, error) in
            if token == nil {
                ZohoAuth.presentZohoSign(in: { (token, error) in
                    dump(token)
                    self.showInitialController()
                })
            }
            else {
                print("App is already logged in")
                self.showInitialController()
            }
        }
        
        

//        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//        window?.windowScene = windowScene
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}


extension SceneDelegate {
    
    func configureApp() {
        //ZohoAuth Configuration
        
        let scope = ["aaaserver.profile.READ","zohocontacts.userphoto.READ","ZohoContacts.contactapi.READ","ZohoCreator.meta.CREATE","ZohoCreator.meta.READ","ZohoCreator.meta.UPDATE","ZohoCreator.meta.DELETE","ZohoCreator.data.CREATE","ZohoCreator.data.READ","ZohoCreator.data.UPDATE","ZohoCreator.data.DELETE","Stratus.stratusop.READ"]
       
//        let clientID = "1000.G32N9XV4G9VWJLDCOGQ5FGLBM5N5WQ"
//        let clientSecret = "fea6160e3a9bedc183f272930c13eb724653a007ee"
//        let urlScheme = "rishab.contactapp://"
//
//        let accountsUrl = "https://accounts.localzoho.com"
        
        let clientId = "1000.OTXRGGQYB3Y3CBTR2YDM365AU69VSI"
        let clientSecret = "c0f620f79f28c34d1c34c683d699241def77bad68c"
        let urlScheme = "thangaayyanarat0.utility://"
        
        let accountsUrl = "https://accounts.zoho.com"
        
        ZohoAuth.initWithClientID(clientId, clientSecret: clientSecret, scope: scope, urlScheme: urlScheme, mainWindow: window, accountsURL: accountsUrl)
    }
    
    func showInitialController() {
        ZCAPIWrapper.fetchMyUserInfo(shouldCacheResponse: false, completionHandler: {(result) in
            switch result {
            case .success(let userInfo):
                dump(userInfo)
                
                let contactListTVC = ContactListTVC()
                let navController = UINavigationController(rootViewController: contactListTVC)
                
                
                if #available(iOS 13.0, *) {
                    let appearance = UINavigationBarAppearance()
                    appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                    appearance.configureWithOpaqueBackground()
                    appearance.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0x39A0FF)
                    navController.navigationBar.standardAppearance = appearance;
                    
                    navController.navigationBar.scrollEdgeAppearance = navController.navigationBar.standardAppearance
                }
                else {
        //            navController.navigationBar.prefersLargeTitles = true
                    navController.navigationBar.backgroundColor = UIColor.getUIColorFromHex(rgbValue: 0x39A0FF)
                    navController.navigationBar.barTintColor = UIColor.getUIColorFromHex(rgbValue: 0x39A0FF)
                    navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                }
                
                navController.view.addSubview(contactListTVC.getAddButton())
                
                navController.navigationBar.tintColor = .white
                
                self.window?.rootViewController = navController
                self.window?.makeKeyAndVisible()
            case .failure(_):
                ZohoAuth.presentZohoSign(in: { (token, error) in
                    dump(token)
                })
            }
        })
        
    }
    
}



extension SceneDelegate: ZCCoreFrameworkDelegate {
    
    func oAuthToken(with completion: @escaping ZCCoreFramework.AccessTokenCompletion) {
        
        if ZohoAuth.isUserSignedIn() {
            print("Already signed in")
        }
        
        ZohoAuth.getOauth2Token { (token, error) in
            if token == nil {
                ZohoAuth.presentZohoSign(in: { (token, error) in
                    completion(token, error)
                })
            }
            else {
                completion(token, error)
            }
        }
    }
    
    func configuration() -> CreatorConfiguration {
        return CreatorConfiguration(creatorURL: "https://creator.zoho.com")
    }
    
}


extension SceneDelegate {
    
    func logout() {
        
        ZohoAuth.revokeAccessToken { (error) in
            if error == nil {
                print("Logged out successfully !!")
            }
            else {
                print("Error occurred !")
                dump(error)
            }
        }
        
    }
    
}
