//
//  NetworkManager.h
//  Prism
//
//  Created by HanYoungsoo on 2017. 3. 19..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString const *WEB_BOARD_API = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/web/";
static NSString const *MOBILE_BOARD_API = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/mobile/";
static NSString const *BIGDATA_BOARD_API = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/bigdata/";
static NSString const *DESIGN_BOARD_API = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/design/";
static NSString const *ETC_BOARD_API = @"http://ec2-52-78-247-21.ap-northeast-2.compute.amazonaws.com/board/etc/";

typedef void(^CompletionBlock)(BOOL isSucess, id result);

@interface NetworkManager : NSObject

-(void)getWebContents:(NSString *)token completion:(CompletionBlock)completion;
-(void)getMobileContents:(NSString *)token completion:(CompletionBlock)completion;
-(void)getBigDataContents:(NSString *)token completion:(CompletionBlock)completion;
-(void)getDesignContents:(NSString *)token completion:(CompletionBlock)completion;
-(void)getEtcContents:(NSString *)token completion:(CompletionBlock)completion;

@end
