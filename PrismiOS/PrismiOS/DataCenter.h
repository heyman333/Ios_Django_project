//
//  DataCenter.h
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 25..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCenter : NSObject
@property NSString *serverToken;
@property NSDictionary *contentsInfo;
@property NSDictionary *writingInfos;
+(instancetype)sharedInstance;
@end
