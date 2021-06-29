//
//  Paypal.swift
//  MyModule
//
//  Created by Tibb on 27/06/2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

import Foundation
import UIKit

@objc(Paypal)
class Paypal: UIViewController {
    
    private let count = 1
    var braintreeClient: BTAPIClient!
    
    @objc(requestOneTimePayment:requestOptions:resolver:rejecter:)
    func requestOneTimePayment( _ clientToken: String,
                                requestOptions options: NSDictionary,
                                resolver resolve: @escaping RCTPromiseResolveBlock,
                                rejecter reject: @escaping RCTPromiseRejectBlock
    ) {
        self.braintreeClient = BTAPIClient(authorization: clientToken)
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
        payPalDriver.viewControllerPresentingDelegate = self
        payPalDriver.appSwitchDelegate = self
        let amount = options["amount"] as? String?
        let request = BTPayPalRequest(amount: (amount ?? "0")!)
        if let billingAgreementDescription = (options["billingAgreementDescription"] as? String?) {
            request.billingAgreementDescription = billingAgreementDescription
        }
        if let currencyCode = options["currencyCode"] as? String? {
            request.currencyCode = currencyCode
        }
        if let displayName = options["displayName"] as? String? {
            request.displayName = displayName
        }
        if let intent = options["intent"] as? String? {
            if(intent == "order"){
                request.intent = .order
            }else if(intent == "sale"){
                request.intent = .sale
            }
        }
        if let landingPageType = options["landingPageType"] as? String? {
            if(landingPageType == "login"){
                request.landingPageType = .login
            }else if(landingPageType == "billing"){
                request.landingPageType = .billing
            }
        }
        if let localeCode = options["localeCode"] as? String? {
            request.localeCode = localeCode
        }
        if let offerCredit = options["offerCredit"] as? Bool? {
            request.offerCredit = (offerCredit != nil)
        }
        if let shippingAddressOverride = options["shippingAddressOverride"] as? NSDictionary? {
            let shippingAddress = BTPostalAddress()
            shippingAddress.streetAddress = (shippingAddressOverride?["streetAddress"] ?? "") as? String
            shippingAddress.extendedAddress = (shippingAddressOverride?["extendedAddress"] ?? "") as? String
            shippingAddress.locality = (shippingAddressOverride?["locality"] ?? "") as? String
            shippingAddress.region = (shippingAddressOverride?["region"] ?? "") as? String
            shippingAddress.postalCode = (shippingAddressOverride?["postalCode"] ?? "") as? String
            shippingAddress.countryCodeAlpha2 = (shippingAddressOverride?["countryCodeAlpha2"] ?? "") as? String
            shippingAddress.recipientName = (shippingAddressOverride?["recipientName"] ?? "") as? String
            request.shippingAddressOverride = shippingAddress
            request.isShippingAddressEditable = true
        }
        
        if let isShippingAddressRequired = options["isShippingAddressRequired"] as? Bool? {
            request.isShippingAddressRequired = (isShippingAddressRequired != nil)
        }
        if let userAction = options["userAction"] as? String? {
            if(userAction == "commit"){
                request.userAction = .commit
            }
        }
        if(amount != "0"){
            payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
                guard let tokenizedPayPalAccount = tokenizedPayPalAccount else {
                    if let error = error {
                        reject("request_billing_agreement_error", "Error requesting billing agreement", error)
                    } else {
                        let e = NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey: "User cancelled billing agreement request"])
                        reject("user_cancellation", "User cancelled billing agreement request", e)
                    }
                    return
                }
                // if let address = tokenizedPayPalAccount.billingAddress {
                // }
                let billingAddress: [String : String] = [
                    "recipientName" : (tokenizedPayPalAccount.billingAddress?.recipientName ?? ""),
                    "streetAddress" : (tokenizedPayPalAccount.billingAddress?.streetAddress ?? ""),
                    "extendedAddress" : (tokenizedPayPalAccount.billingAddress?.extendedAddress ?? ""),
                    "locality" : (tokenizedPayPalAccount.billingAddress?.locality ?? ""),
                    "countryCodeAlpha2" : (tokenizedPayPalAccount.billingAddress?.countryCodeAlpha2 ?? ""),
                    "postalCode" : (tokenizedPayPalAccount.billingAddress?.postalCode ?? ""),
                    "region" : (tokenizedPayPalAccount.billingAddress?.region ?? ""),
                ]
                
                let shippingAddress: [String : String] = [
                    "recipientName" : (tokenizedPayPalAccount.shippingAddress?.recipientName ?? ""),
                    "streetAddress" : (tokenizedPayPalAccount.shippingAddress?.streetAddress ?? ""),
                    "extendedAddress" : (tokenizedPayPalAccount.shippingAddress?.extendedAddress ?? ""),
                    "locality" : (tokenizedPayPalAccount.shippingAddress?.locality ?? ""),
                    "countryCodeAlpha2" : (tokenizedPayPalAccount.shippingAddress?.countryCodeAlpha2 ?? ""),
                    "postalCode" : (tokenizedPayPalAccount.shippingAddress?.postalCode ?? ""),
                    "region" : (tokenizedPayPalAccount.shippingAddress?.region ?? ""),
                ]
                
                let result: NSDictionary = [
                    "nonce" : (tokenizedPayPalAccount.nonce),
                    "payerId" : (tokenizedPayPalAccount.payerId ?? ""),
                    "email" : (tokenizedPayPalAccount.email ?? ""),
                    "firstName" : (tokenizedPayPalAccount.firstName ?? ""),
                    "lastName" : (tokenizedPayPalAccount.lastName ?? ""),
                    "phone" : (tokenizedPayPalAccount.phone ?? ""),
                    "billingAddress": billingAddress,
                    "shippingAddress": shippingAddress
                ]
                
                print("resut \(result)")
                resolve(result)
            }
        }
    }
    
    @objc(requestBillingAgreement:requestOptions:resolver:rejecter:)
    func requestBillingAgreement( _ clientToken: String,
                                requestOptions options: NSDictionary,
                                resolver resolve: @escaping RCTPromiseResolveBlock,
                                rejecter reject: @escaping RCTPromiseRejectBlock
    ) {
        
    }
    
    private func jsonToDic(json: String) -> [String: Any]? {
        if let jsonData = json.data(using: .utf8){
            do {
                return try JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil;
    }
    
    //required for ReactNative
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

// MARK: - BTViewControllerPresentingDelegate
extension UIViewController : BTViewControllerPresentingDelegate {
    
    public func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    public func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - BTAppSwitchDelegate
extension UIViewController : BTAppSwitchDelegate {
    // Optional - display and hide loading indicator UI
    
    public func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
    }
    
    public func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
    }
    
    public func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    public func showLoadingUI() {
    }
    
    public func hideLoadingUI() {
    }
}
