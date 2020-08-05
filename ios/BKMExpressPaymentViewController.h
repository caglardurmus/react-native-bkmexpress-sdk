//
//  BKMExpressPairViewController.h
//  BKMExpressSDK
//
//  Created by BKM
//  Copyright © 2016 Bankalararası Kart Merkezi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BKMPOSResult;

@protocol BKMExpressPaymentDelegate <NSObject>

@required
- (void)bkmExpressPaymentDidCompleteWithPOSResult:(BKMPOSResult *)posResult;
- (void)bkmExpressPaymentDidCancel;
- (void)bkmExpressPaymentDidFail:(NSError *)error;

@end

@interface BKMExpressPaymentViewController : UINavigationController

@property (nonatomic, weak, readonly) id<BKMExpressPaymentDelegate> paymentDelegate;

-(void)setEnableDebugMode:(BOOL)isEnableDebugMode;

- (instancetype)initWithPaymentToken:(NSString *)token delegate:(id<BKMExpressPaymentDelegate>)delegate;

@end


@interface BKMPOSResult : NSObject

@property (nonatomic, strong) NSString *posMessage;
@property (nonatomic, strong) NSString *md;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *xid;

@end

