//
//  BKMExpressPairViewController.h
//  BKMExpressSDK
//
//  Created by BKM
//  Copyright © 2016 Bankalararası Kart Merkezi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BKMExpressPairingDelegate <NSObject>

@required
- (void)bkmExpressPairingDidComplete:(NSString *)first6Digits withLast2Digits:(NSString *)last2Digits;
- (void)bkmExpressPairingDidCancel;
- (void)bkmExpressPairingDidFail:(NSError *)error;

@end


@interface BKMExpressPairViewController : UINavigationController

@property (nonatomic, weak, readonly) id<BKMExpressPairingDelegate> pairingDelegate;

-(void)setEnableDebugMode:(BOOL)isEnableDebugMode;

- (instancetype)initWithToken:(NSString *)token delegate:(id<BKMExpressPairingDelegate>)delegate;

- (instancetype)initWithTicket:(NSString *)ticket withDelegate:(id<BKMExpressPairingDelegate>)delegate;

@end
