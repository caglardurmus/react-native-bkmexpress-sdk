//
//  BKMExpressSDK.m
//  FileMobile
//
//  Created by Çağlar Durmuş on 27.05.2020.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "BkmExpressSdk.h"
#import <BKMExpressPaymentViewController.h>
#import <BKMExpressPairViewController.h>

@implementation BkmExpressSdk

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXPORT_MODULE()

RCTResponseSenderBlock _callback;

RCT_EXPORT_METHOD(payment:(NSString *)TOKEN
                  ENVIRONMENT:(NSString *)ENVIRONMENT
                  callback:(RCTResponseSenderBlock)callback)
{
    if (TOKEN == (id)[NSNull null] || TOKEN.length == 0 ) NSLog(@"BKMExpress Log TOKEN is null");

    NSLog(@"BKMExpress Log TOKEN = %@", TOKEN);
    NSLog(@"BKMEXPRESS - MYLOG ENVIRONMENT = %@", ENVIRONMENT);
    
    BKMExpressPaymentViewController *vc = [[BKMExpressPaymentViewController alloc] initWithPaymentToken:TOKEN delegate:self];
    
    _callback = [callback copy];
    
    // if debug mode is enabled, this sdk connect to preprod otherwise connect to prod.
    if([ENVIRONMENT isEqual:(@"PREPROD")]) {
        NSLog(@"BKMEXPRESS - MYLOG ENVIRONMENT PREPROD ON");
        [vc setEnableDebugMode:YES];
    }
    
    // Present view controller
    UIViewController *rootController = UIApplication.sharedApplication.keyWindow.rootViewController;
    
    while (rootController.presentedViewController != nil)
    {
        rootController = rootController.presentedViewController;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [rootController presentViewController:vc animated:YES completion:nil];
    });
}

- (void)bkmExpressPaymentDidCompleteWithPOSResult:(BKMPOSResult *)posResult{
    NSLog(@"Successful payment = %@",posResult);
    NSString *result = @"0";
    _callback(@[posResult, result]);
}

- (void)bkmExpressPaymentDidFail:(NSError *)error{
    NSLog(@"An error has occurred on payment = %@", error.localizedDescription);
    NSString *result = @"2";
    _callback(@[[NSNull null], result]);
}

- (void)bkmExpressPaymentDidCancel{
    NSLog(@"Payment is canceled by user");
    NSString *result = @"1";
    _callback(@[[NSNull null], result]);
}

RCT_EXPORT_METHOD(submitConsumer:(NSString *)TOKEN
                  ENVIRONMENT:(NSString *)ENVIRONMENT
                  callback:(RCTResponseSenderBlock)callback)
{
    if (TOKEN == (id)[NSNull null] || TOKEN.length == 0 ) NSLog(@"BKMExpress Log TOKEN is null");

    NSLog(@"BKMExpress Log BKM_TICKET_TOKEN = %@", TOKEN);
    NSLog(@"BKMEXPRESS - MYLOG ENVIRONMENT = %@", ENVIRONMENT);
    
    // instantiate view controller with custom constructor
    BKMExpressPairViewController *vc = [[BKMExpressPairViewController alloc] initWithToken:TOKEN delegate:self];
    
    _callback = [callback copy];
    
    // if debug mode is enabled, this sdk connect to preprod otherwise connect to prod.
    if([ENVIRONMENT isEqual:(@"PREPROD")]) {
        NSLog(@"BKMEXPRESS - MYLOG ENVIRONMENT PREPROD ON");
        [vc setEnableDebugMode:YES];
    }
    
    // Present view controller
    UIViewController *rootController = UIApplication.sharedApplication.keyWindow.rootViewController;
    
    while (rootController.presentedViewController != nil)
    {
        rootController = rootController.presentedViewController;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [rootController presentViewController:vc animated:YES completion:nil];
    });
}

RCT_EXPORT_METHOD(resubmitConsumer:(NSString *)TICKET
                  ENVIRONMENT:(NSString *)ENVIRONMENT
                  callback:(RCTResponseSenderBlock)callback)
{
    if (TICKET == (id)[NSNull null] || TICKET.length == 0 ) NSLog(@"BKMExpress Log TICKET is null");

    NSLog(@"BKMExpress Log TICKET = %@", TICKET);
    NSLog(@"BKMEXPRESS - MYLOG ENVIRONMENT = %@", ENVIRONMENT);
    
    // instantiate view controller with custom constructor
    BKMExpressPairViewController *vc = [[BKMExpressPairViewController alloc] initWithTicket:TICKET withDelegate:self];

    _callback = [callback copy];
    
    // if debug mode is enabled, this sdk connect to preprod otherwise connect to prod.
    if([ENVIRONMENT isEqual:(@"PREPROD")]) {
        NSLog(@"BKMEXPRESS - MYLOG ENVIRONMENT PREPROD ON");
        [vc setEnableDebugMode:YES];
    }
    
    // Present view controller
    UIViewController *rootController = UIApplication.sharedApplication.keyWindow.rootViewController;
    
    while (rootController.presentedViewController != nil)
    {
        rootController = rootController.presentedViewController;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [rootController presentViewController:vc animated:YES completion:nil];
    });
}

- (void)bkmExpressPairingDidComplete:(NSString *)first6Digits withLast2Digits:(NSString *)last2Digits{
    NSLog(@"Successful first6Digits = %@, last2Digits =  %@",first6Digits,last2Digits);
    NSString *result = @"0";
    _callback(@[[NSString stringWithFormat:@"%@********%@", first6Digits, last2Digits], result]);
}

- (void)bkmExpressPairingDidFail:(NSError *)error{
    NSLog(@"An error has occurred on payment = %@", error.localizedDescription);
    NSString *result = @"2";
    _callback(@[[NSNull null], result]);
}

- (void)bkmExpressPairingDidCancel{
    NSLog(@"Payment is canceled by user");
    NSString *result = @"1";
    _callback(@[[NSNull null], result]);
}


- (NSDictionary *)constantsToExport
{
    return @{ @"getMethod": @"1" };
}


@end

