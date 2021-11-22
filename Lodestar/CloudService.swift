//
//  CloudService.swift
//  Lodestar
//
//  Created by Bailey on 11/20/21.
//

import Foundation
import UIKit
import Amplify
import AWSCognitoAuthPlugin

struct AuthMetadata {
    var username: String?
}

class CloudService {
    // Singleton Pattern
    static let shared = CloudService()
    static func initialize() -> CloudService {
        return .shared
    }
    
    var authData = AuthMetadata()
    
    private init() {
        do {
          //Amplify.Logging.logLevel = .verbose
          try Amplify.add(plugin: AWSCognitoAuthPlugin())
          try Amplify.configure()
          print("Initialized Amplify");
        } catch {
          print("Could not initialize Amplify: \(error)")
          return
        }
        
        // listen to auth events.
        // see https://github.com/aws-amplify/amplify-ios/blob/master/Amplify/Categories/Auth/Models/AuthEventName.swift
        _ = Amplify.Hub.listen(to: .auth) { (payload) in

            switch payload.eventName {

            case HubPayload.EventName.Auth.signedIn:
                print("==HUB== User signed In, update UI")
                self.updateUserData(withSignInStatus: true)

            case HubPayload.EventName.Auth.signedOut:
                print("==HUB== User signed Out, update UI")
                self.updateUserData(withSignInStatus: false)

            case HubPayload.EventName.Auth.sessionExpired:
                print("==HUB== Session expired, show sign in UI")
                self.updateUserData(withSignInStatus: false)

            default:
                //print("==HUB== \(payload)")
                break
            }
            
            print("HUB payload", payload)
        }
    }
    
    // MARK: - User Authentication

    public func signUp(email: String, password: String, completion: @escaping (Result<AuthSignUpResult, AuthError>) -> Void) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        
        Amplify.Auth.signUp(username: email, password: password, options: options) { result in
            debugPrint(result)
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
                
                self.authData.username = email
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
            
            completion(result)
        }
    }
    
    public func confirmSignUp(with confirmationCode: String, completion: @escaping () -> Void) {
        guard let username = self.authData.username else {
            print("missing username")
            return
        }
        
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
                completion()
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
            }
        }
    }
    
    public func login(email: String, password: String, completion: @escaping (Result<AuthSignInResult, AuthError>) -> Void) {
        Amplify.Auth.signIn(username: email, password: password) { result in
            completion(result)
        }
    }
    
    public func fetchSession() {
        // let's check if user is signedIn or not
         Amplify.Auth.fetchAuthSession { (result) in
             do {
                 let session = try result.get()
                        
                 // let's update UserData and the UI
                 print("is user signed in?", session.isSignedIn)
                 self.updateUserData(withSignInStatus: session.isSignedIn)
             } catch {
                  print("Fetch auth session failed with error - \(error)")
                  return
            }
        }
    }

    public func signOut() {
        Amplify.Auth.signOut() { (result) in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }

    // change our internal state, this triggers an UI update on the main thread
    func updateUserData(withSignInStatus status: Bool) {
        DispatchQueue.main.async() {
            let userData: UserData = .shared
            userData.isSignedIn = status
        }
    }
}
