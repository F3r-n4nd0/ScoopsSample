//
//  FLMNewsViewController.h
//  FLMScoops
//
//  Created by Agustín on 02/05/2015.
//  Copyright (c) 2015 F3rn4nd0. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FLMNews;
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface FLMNewsViewController : UIViewController

-(id) initWithNews: (FLMNews *) news aClient: (MSClient *) client;

@property (weak, nonatomic) IBOutlet UITextField *titletext;
@property (weak, nonatomic) IBOutlet UITextView *boxNews;
@property (weak, nonatomic) IBOutlet UITextField *valoracionGlobal;
@property (weak, nonatomic) IBOutlet UITextField *miValoracion;
@property (weak, nonatomic) FLMNews *news;
@property (weak, nonatomic) MSClient * client;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)valorarNews:(id)sender;

@end
