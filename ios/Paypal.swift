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

    @objc
    func requestOneTimePayment(_ callback: RCTResponseSenderBlock) {
        self.braintreeClient = BTAPIClient(authorization: "sandbox_v29bk2j6_7t2b5cz5s3m5gj8v")
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient)
        payPalDriver.viewControllerPresentingDelegate = self
        payPalDriver.appSwitchDelegate = self
        let request = BTPayPalRequest(amount: "1.00")

        payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
            guard let tokenizedPayPalAccount = tokenizedPayPalAccount else {
                //                guard let error = error {
                //                    // Handle error
                //                } else {
                //                    // User canceled
                //                }
                return
            }
            //            callback(["Got a nonce!"])
            print("Got a nonce! \(tokenizedPayPalAccount.nonce)")
            //            if let address = tokenizedPayPalAccount.billingAddress {
            //                callback(["Got a nonce!"])
            //            }
            //            callback([tokenizedPayPalAccount])
        }
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
