//
//  FLMUser.h
//  FLMScoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 F3rn4nd0. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLMUser : NSObject

-(id) initWithIdUser: (NSString *) idUser aName: (NSString *) name aGender: (NSString *) gender aPicture: (NSString *) picture;

@property (nonatomic, strong) NSString *idUser;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *picture;

@end
