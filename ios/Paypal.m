//
//  Paypal.m
//  MyModule
//
//  Created by Tibb on 27/06/2021.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(Paypal, UIViewController)
    RCT_EXTERN_METHOD(requestOneTimePayment:
                      (NSString *)clientToken
                      requestOptions:(NSDictionary *)options
                      resolver: (RCTPromiseResolveBlock)resolve
                      rejecter:(RCTPromiseRejectBlock)reject)
    RCT_EXTERN_METHOD(requestBillingAgreement:
                  (NSString *)clientToken
                  requestOptions:(NSDictionary *)options
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
    RCT_EXTERN_METHOD(requestDeviceData:
                  (NSString *)clientToken
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
@end

