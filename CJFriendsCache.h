//
//  CJFriendsCache.h
//  CaiJieUnit
//
//  Created by sfm on 2018/7/25.
//  Copyright © 2018年 sfm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
/*为好友的模型
 @property(nonatomic,copy)NSString *memberName;
 @property(nonatomic,copy)NSString *memberNum;
 @property(nonatomic,copy)NSString *memberProfile;

 */
#import "CJContactModel.h"
@interface CJFriendsCache : NSObject
-(void)savePeopleModel:(CJContactModel *)model;
-(void)updatePeopleInfo:(NSString*)name icon:(NSString *)icon userid:(NSString *)userid;
-(void)deletePepleModel:(NSString*)userid;
-(CJContactModel*)getPepleModel:(NSString*)userid;
-(NSMutableArray *)getCachePepleArray;
-(NSMutableArray *)getuseridArray;
-(void)deleteAll;
@end
