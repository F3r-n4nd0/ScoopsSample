//
//  FLMNewsViewController.m
//  FLMScoops
//
//  Created by Agustín on 02/05/2015.
//  Copyright (c) 2015 F3rn4nd0. All rights reserved.
//

#import "FLMNewsViewController.h"
#import "FLMNews.h"

@interface FLMNewsViewController ()

@end

@implementation FLMNewsViewController

-(id) initWithNews: (FLMNews *) news aClient: (MSClient *) client{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _news = news;
        _client = client;
    }
    
    return self;
    
}


-(void) viewWillAppear:(BOOL)animated{
    
    [self getValoracionWithUser:self.client];
    
    self.titletext.text = self.news.title;
    self.boxNews.text = self.news.text;
    self.valoracionGlobal.text = [NSString stringWithFormat:@"%ld", (long)self.news.valoracion];
}


-(void) getValoracionWithUser: (MSClient *) client{
    
    [client invokeAPI:@"valoracionbook" body:self.news.idNews HTTPMethod:@"GET" parameters:nil headers:nil completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
        
        //tenemos info extra del usuario
        NSLog(@"%@", result);
        
        NSArray *valorGlobal = [result valueForKey:@"valor"];
        
        if (![[NSString stringWithFormat:@"%@", [valorGlobal lastObject]] isEqualToString:@"<null>"]) {
            
            self.valoracionGlobal.text =[NSString stringWithFormat:@"%@", [valorGlobal lastObject]];
            
        }else{
            self.valoracionGlobal.text = @"";
        }
        
        
    }];
    
}

#pragma mark - Actions
- (IBAction)hideKeyboard:(id)sender{
    
    [self.view endEditing:YES];
}

- (IBAction)valorarNews:(id)sender{
    
    MSTable *valoracion = [self.client tableWithName:@"valoracion"];
    
    NSDictionary * scoopVal= @{@"valor" : [NSNumber numberWithInteger:[self.miValoracion.text integerValue]], @"idnews" : self.news.idNews};
    [valoracion insert:scoopVal
            completion:^(NSDictionary *item, NSError *error) {
                
                if (error) {
                    NSLog(@"Error %@", error);
                    NSLog(@"OK --- %@", item);
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Valoración"
                                                                    message:@"Error al valorar"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                } else {
                    NSLog(@"OK --- %@", item);
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Valoración"
                                                                    message:@"Se ha valorado correctamente"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                
            }];
    
}

@end
