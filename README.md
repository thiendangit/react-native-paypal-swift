# react-native-paypal-swift

React Native library that implements PayPal [Checkout](https://developers.braintreepayments.com/guides/paypal/checkout-with-paypal/) flow using purely native code (swift).

## Installation

```sh
npm install react-native-paypal-swift or `yarn add react-native-paypal-swift`
```

1. [iOS] Add `pod 'Braintree', '~> 4'` and `pod 'Braintree/DataCollector'` to your Podfile.
1. [iOS] Run `pod install`
1. [iOS] Register a URL scheme in Xcode (**must** always start with your Bundle Identifier and end in `.payments` - e.g. `your.app.id.payments`). See details [here](https://developers.braintreepayments.com/guides/paypal/client-side/ios/v4#register-a-url-type).
1. [iOS] Edit your `AppDelegate.m` as follows:
    ```objc
    #import "BraintreeCore.h"
    #import "BraintreePayPal.h"
    #import "BTDataCollector.h"

    - (BOOL)application:(UIApplication *)application
      didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
      NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
      NSString *urlscheme = [NSString stringWithFormat:@"%@.payments", bundleIdentifier];
      URLScheme = urlscheme;
      BTAppSwitch setReturnURLScheme:urlscheme];
    }

    // if you support only iOS 9+, add the following method
    - (BOOL)application:(UIApplication *)application
        openURL:(NSURL *)url
        sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation
    {
        if ([url.scheme localizedCaseInsensitiveCompare:URLScheme] == NSOrderedSame) {
            return [BTAppSwitch handleOpenURL:url sourceApplication:sourceApplication];
        }
        return NO;
    }

    // otherwise, if you support iOS 8, add the following method
      - (BOOL)application:(UIApplication *)application
          openURL:(NSURL *)url
          options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
      {
          if ([url.scheme localizedCaseInsensitiveCompare:URLScheme] == NSOrderedSame) {
              return [BTAppSwitch handleOpenURL:url options:options];
          }
          return NO;
      }
    ```

At this point you should be able to build both Android and iOS.



## Usage

First you need to get a valid token from your server. Refer to [this](https://developers.braintreepayments.com/start/hello-client/ios/v3#get-a-client-token).

Then you can execute the following code, for example reacting to a button press.


```js
import {Paypal} from "react-native-paypal-swift";

// ...

Paypal.requestOneTimePayment((result : string) => console.log({ result }));
```

## Creating/Finding client token
Note that the client token should be served via a backend service but can be hardcoded:
1. Go to https://www.braintreegateway.com or https://sandbox.braintreegateway.com/ and login or create an account
2. Click the gear at the top and select to API
3. You can find your token under `Tokenization Keys`.  You will need to create one if none exists

## Backend implementation
For an overview of the braintree payment flow see https://developers.braintreepayments.com/start/overview

This library covers the client setup here: https://developers.braintreepayments.com/start/hello-client

It does NOT however cover the server portion here: https://developers.braintreepayments.com/start/hello-server

You will need the server portion in order to complete your transactions.  See a simple example of this server in /exampleServer.  The example app is pointed to this on default


## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
