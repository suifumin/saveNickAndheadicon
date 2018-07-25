//
//  CJFriendsCache.m
//  CaiJieUnit
//
//  Created by sfm on 2018/7/25.
//  Copyright © 2018年 sfm. All rights reserved.
//

#import "CJFriendsCache.h"

@implementation CJFriendsCache
static FMDatabase *_db;
+(void)initialize{
  //打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"friends.sqlite"] ;
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    //创建表
    BOOL flag = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_friends(id integer PRIMARY KEY,userid text,username text,usericon text)"];
    if(flag){
        NSLog(@"创建表成功");
    }
}
-(void)savePeopleModel:(CJContactModel *)model{
     [_db open];
    BOOL flag = [_db executeUpdateWithFormat:@"insert into t_friends (userid,username,usericon) values(%@,%@,%@);",model.memberNum,model.memberName,model.memberProfile];
    if(flag){
        NSLog(@"加入成功");
    }
    [_db close];
}
-(void)updatePeopleInfo:(NSString *)name icon:(NSString *)icon userid:(NSString *)userid{
    
    [_db open];
    [_db executeUpdateWithFormat:@"update t_friends set username = %@ where userid = %@",name,userid];
    [_db executeUpdateWithFormat:@"update t_friends set usericon = %@ where userid = %@",icon,userid];
    [_db close];
}
-(void)deletePepleModel:(NSString *)userid{
    [_db open];
    [_db executeUpdateWithFormat:@"delete from t_friends where userid = %@",userid];
    [_db close];
}
-(CJContactModel*)getPepleModel:(NSString*)userid{
    [_db open];
    FMResultSet *set = [_db executeQueryWithFormat:@"select *from t_friends where userid = %@",userid];
    CJContactModel *model = [[CJContactModel alloc]init];
    while ([set next]) {
        model.memberNum = [set stringForColumn:@"userid"];
        model.memberProfile = [set stringForColumn:@"usericon"];
        model.memberName = [set stringForColumn:@"username"];
    }
    [_db close];
    return model;
    
}
- (NSMutableArray *)getCachePepleArray{
    [_db open];
    NSMutableArray *modelA = [[NSMutableArray alloc]init] ;
    FMResultSet *set = [_db executeQuery:@"select *from t_friends"];
    while ([set next]) {
        CJContactModel *model = [[CJContactModel alloc]init];
        model.memberNum = [set stringForColumn:@"userid"];
        model.memberProfile = [set stringForColumn:@"usericon"];
        model.memberName = [set stringForColumn:@"username"];
        [modelA addObject:model];
    }
    [_db close];
    return modelA;
    
}
-(NSMutableArray *)getuseridArray{
     [_db open];
    NSMutableArray *useridArray = [[NSMutableArray alloc]init] ;
    FMResultSet *set = [_db executeQuery:@"select *from t_friends"];
    while ([set next]) {
        
        NSString *userid = [set stringForColumn:@"userid"];
        
        [useridArray addObject:userid];
    }
    
     [_db close];
    return useridArray;
}
-(void)deleteAll{
    BOOL success =  [_db executeUpdate:@"DELETE FROM t_friends"];
    if(success){
        NSLog(@"删除表成功");
    }
}
@end
