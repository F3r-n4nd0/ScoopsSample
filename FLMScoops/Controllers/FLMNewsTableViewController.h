//
//  FLMNewsTableViewController.h
//  FLMScoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 F3rn4nd0. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLMUser;
@class FLMNews;
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface FLMNewsTableViewController : UITableViewController

-(id) initWithUser: (FLMUser *) user aMSClient: (MSClient *) client;

@property (weak, nonatomic) MSClient * client;
@property (weak, nonatomic) FLMUser *userLog;


@end
