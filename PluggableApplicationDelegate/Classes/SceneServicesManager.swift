//
//  SceneServicesManager.swift
//  PluggableApplicationDelegate
//
//  Created by Ralf Kralicek on 05.01.22.
//

import UIKit
import SwiftUI
import Foundation

/// This is only a tagging protocol.
/// It doesn't add more functionalities yet.

@available(iOS 13.0, tvOS 13.0, *)
public protocol SceneService: UIWindowSceneDelegate {}

@available(iOS 13.0, tvOS 13.0, *)
open class PluggableSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - Properties
    
    public var window: UIWindow?
    
    open var services: [SceneService] { return [] }
    
    private lazy var __services: [SceneService] = {
        return self.services
    }()
    
    // /////////////////////////////////////////////////////////////////////////
    // MARK: - UIWindowSceneDelegate
    // /////////////////////////////////////////////////////////////////////////
    
    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        self.__services.forEach({ $0.scene?(scene, willConnectTo: session, options: connectionOptions) })
    }
    
    public func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
        self.__services.forEach({ $0.sceneDidDisconnect?(scene) })
    }
    
    public func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        self.__services.forEach({ $0.sceneDidBecomeActive?(scene) })
    }
    
    public func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
        self.__services.forEach({ $0.sceneWillResignActive?(scene) })
    }

    public func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        self.__services.forEach({ $0.sceneWillEnterForeground?(scene) })
    }

    public func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        self.__services.forEach({ $0.sceneDidEnterBackground?(scene) })
    }
    
    public func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        self.__services.forEach({ $0.scene?(scene, openURLContexts: URLContexts) })
    }
    
    
    /// This function will be called when an Associated Domain is forwarded into the app.
    /// - Parameters:
    ///   - scene: The UIScene that will be used when the app reconnects
    ///   - userActivity: The userActivity containing the webPageURL that was forwarded into the application.
    public func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        self.__services.forEach({ $0.scene?(scene, continue: userActivity) })
    }
}
