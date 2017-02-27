//
//  DataCenter.m
//  Prism
//
//  Created by HanYoungsoo on 2017. 2. 25..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

#import "DataCenter.h"

@implementation DataCenter

+(instancetype)sharedInstance{
    
    static DataCenter *dataCenter;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataCenter = [[DataCenter alloc] init];
    });
    
    return dataCenter;
}

@end

