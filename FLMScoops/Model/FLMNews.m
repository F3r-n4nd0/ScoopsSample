//
//  FLMNews.m
//  FLMScoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 F3rn4nd0. All rights reserved.
//

#import "FLMNews.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@implementation FLMNews

#pragma mark - Init
- (id)initWithTitle:(NSString*)title andPhoto:(NSData *)img aText:(NSString*)text anAuthor:(NSString *)author anIdUser: (NSString *) idUser aValoracion: (NSInteger) valoracion aState: (BOOL) estado aClient: (MSClient *) client{
    
    if (self = [super init]) {
        _title = title;
        _text = text;
        _author = author;
        _image = img;
        _dateCreated = [NSDate date];
        _idUser = idUser;
        _valoracion = valoracion;
        _estado = estado;
        _client = client;
    }
    
    return self;
    
}

- (id)initWithIdNews: (NSString*) idNews aTitle:(NSString*)title andPhoto:(NSData *)img aText:(NSString*)text anAuthor:(NSString *)author anIdUser: (NSString *) idUser aValoracion: (NSInteger) valoracion aState: (BOOL) estado aClient: (MSClient *) client{
    
    if (self = [super init]) {
        _idNews = idNews;
        _title = title;
        _text = text;
        _author = author;
        _image = img;
        _dateCreated = [NSDate date];
        _idUser = idUser;
        _valoracion = valoracion;
        _estado = estado;
        _client = client;
    }
    
    return self;
    
}

- (void)addNewToAzure{
    MSTable *news = [self.client tableWithName:@"news"];
    
    NSDictionary * scoop= @{@"titulo" : self.title, @"noticia" : self.text, @"userId" : self.idUser, @"autor" : self.author, @"valoracion" : [NSNumber numberWithInteger:self.valoracion], @"estado" : [NSNumber numberWithBool:self.estado]};
    [news insert:scoop
      completion:^(NSDictionary *item, NSError *error) {
          
          if (error) {
              NSLog(@"Error %@", error);
          } else {
              NSLog(@"OK --- %@", item);
              
              self.idNews = [item valueForKey:@"id"];
              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"News"
                                                              message:@"Se ha creado una nueva News"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
              [alert show];
          }
          
      }];
    
}





@end
