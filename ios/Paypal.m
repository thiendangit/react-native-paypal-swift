//
//  Paypal.m
//  MyModule
//
//  Created by Tibb on 27/06/2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(Paypal, UIViewController)
    RCT_EXTERN_METHOD(requestOneTimePayment: (RCTResponseSenderBlock)callback)
@end
