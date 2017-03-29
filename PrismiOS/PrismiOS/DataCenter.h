//
//  DataCenter.h
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 25..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkManager.h"

@interface DataCenter : NSObject
@property NSString *serverToken; //민구서버 토큰
@property NSDictionary *contentsInfo; //
@property NSDictionary *writingInfos; //
@property NSString *primary_ID;
@property NSString *loginUserPrimary_ID;
@property NSNumber *board_ID;
@property NSDictionary *userInfos;
@property NetworkManager *nMaager;
+(instancetype)sharedInstance;
@end
