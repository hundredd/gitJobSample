//
//  User.m
//  特种车调度
//
//  Created by 陈宇 on 15/9/2.
//
//

#import "User.h"

@implementation LoginInfo

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _AccessToken = [aDecoder decodeObjectForKey:@"_AccessToken"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    if (![BMUtils isEmptyString:_AccessToken]) {
        [aCoder encodeObject:_AccessToken forKey:@"_AccessToken"];
    }
}

@end

@implementation StationInfo

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
      
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
}

@end

@implementation User

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _ID = [aDecoder decodeIntegerForKey:@"_ID"];
        _name = [aDecoder decodeObjectForKey:@"_name"];
        _UserId = [aDecoder decodeObjectForKey:@"_UserId"];
        _MenuId = [aDecoder decodeObjectForKey:@"_MenuId"];
        _MenuName = [aDecoder decodeObjectForKey:@"_MenuName"];
        _MenuCode = [aDecoder decodeObjectForKey:@"_MenuCode"];
        _isLog = [aDecoder decodeBoolForKey:@"_isLog"];
        _userName = [aDecoder decodeObjectForKey:@"_userName"];
        _password = [aDecoder decodeObjectForKey:@"_password"];
}
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if (_ID) {
        [aCoder encodeInteger:_ID forKey:@"_ID"];
    }
    if (![BMUtils isEmptyString:_UserId]) {
        [aCoder encodeObject:_UserId forKey:@"_UserId"];
    }
    if (![BMUtils isEmptyString:_MenuId]) {
        [aCoder encodeObject:_MenuId forKey:@"_MenuId"];
    }
    if (![BMUtils isEmptyString:_MenuName]) {
        [aCoder encodeObject:_MenuName forKey:@"_MenuName"];
    }
    if (![BMUtils isEmptyString:_MenuCode]) {
        [aCoder encodeObject:_MenuCode forKey:@"_MenuCode"];
    }
    [aCoder encodeBool:_isLog forKey:@"_isLog"];
    if (![BMUtils isEmptyString:_userName]) {
        [aCoder encodeObject:_userName forKey:@"_userName"];
    }
    if (![BMUtils isEmptyString:@"_password"]) {
        [aCoder encodeObject:_password forKey:@"_password"];
    }
}


@end


