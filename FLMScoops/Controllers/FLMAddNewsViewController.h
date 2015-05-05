//
//  FLMAddNewsViewController.h
//  FLMScoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 F3rn4nd0. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLMUser;
@class FLMNews;
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface FLMAddNewsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

-(id) initWithUser: (FLMUser *) user aMSClient: (MSClient *) client;

@property (weak, nonatomic) IBOutlet UITextField *titletext;
@property (weak, nonatomic) IBOutlet UITextView *boxNews;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) MSClient * client;
@property (weak, nonatomic) FLMUser *userLog;
@property (strong, nonatomic) FLMNews *news;

@property (nonatomic) CGRect oldRect;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBarView;

- (IBAction)displayPublicar:(id)sender;
- (IBAction)dysplayCamera:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
