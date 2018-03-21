//
//  ZFNetworkManager+Extension.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/9.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFNetworkManager.h"

@interface ZFNetworkManager (Extension)

-(void) statusList: (UInt64) since_id max_id: (UInt64) max_id completion: (void(^)(NSString* list, BOOL isSuccess)) completion;

-(void) loadAccessToken: (NSString *) code completion: (void(^)(BOOL isSuccess)) completion;

@end
