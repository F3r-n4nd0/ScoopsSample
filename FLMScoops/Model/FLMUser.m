//
//  FLMUser.m
//  FLMScoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 F3rn4nd0. All rights reserved.
//

#import "FLMUser.h"

@implementation FLMUser

#pragma mark - Init
-(id) initWithIdUser: (NSString *) idUser aName: (NSString *) name aGender: (NSString *) gender aPicture: (NSString *) picture{
    
    if (self = [super init]) {
        _idUser = idUser;
        _name = name;
        _gender = gender;
        _picture = picture;
    }
    
    return self;
    
}

@end
