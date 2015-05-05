//
//  FLMScoopViewController.h
//  FLMScoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 F3rn4nd0. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLMUser.h"

typedef void (^profileCompletion)(NSDictionary* profInfo);
typedef void (^completeBlock)(NSArray* results);
typedef void (^completeOnError)(NSError *error);
typedef void (^completionWithURL)(NSURL *theUrl, NSError *error);

@interface FLMScoopViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *picProfile;
@property (strong, nonatomic) NSURL *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *labelUSer;

- (IBAction)publicarNew:(id)sender;
- (IBAction)leerNew:(id)sender;

@end
