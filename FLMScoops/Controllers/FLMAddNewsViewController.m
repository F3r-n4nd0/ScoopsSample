//
//  FLMAddNewsViewController.m
//  FLMScoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 F3rn4nd0. All rights reserved.
//

#import "FLMAddNewsViewController.h"
#import "FLMNews.h"
#import "FLMUser.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface FLMAddNewsViewController ()

@end

@implementation FLMAddNewsViewController

#pragma mark - Init

-(id) initWithUser: (FLMUser *) user aMSClient: (MSClient *) client{

    
    if (self = [super init]) {
        _userLog = user;
        _client = client;
        _news = [FLMNews new];
    }
    
    return self;
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewDidLoad];
    
    
    self.photoView.image = [UIImage imageWithData:self.news.image];
    
    [self setupKeyboardNotifications];
}



- (IBAction)displayPublicar:(id)sender {
    
    self.news.title = self.titletext.text;
    self.news.image = self.news.image,
    self.news.text = self.boxNews.text;
    self.news.author = self.userLog.name;
    self.news.idUser = self.userLog.idUser;
    self.news.valoracion = 0;
    self.news.estado = false;
    self.news.client = self.client;
    
    [self.news addNewToAzure];
    
    
}

- (IBAction)dysplayCamera:(id)sender {
    
    //Creamos un UIImagePickerController
    UIImagePickerController *picker = [UIImagePickerController new];
    
    //Lo configuro
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //Uso la camara
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        
        //Tiro del carrete
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    
    //Esto es como muestra la nueva vista. La animacion
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //Lo muestro de forma modal
    [self presentViewController:picker animated:YES completion:^{
        
        //Esto se va a ejecutar cuadno termine la animación que muestra al picker.
        
    }];
    
}



#pragma mark - keyboard

- (void)setupKeyboardNotifications{
    
    // Alta en notificaciones
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyKeyboardWillAppear:)
               name:UIKeyboardWillShowNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(notifyKeyboardWillDisappear:)
               name:UIKeyboardWillHideNotification
             object:nil];
    
}

//UIKeyboardWillShowNotification
-(void)notifyKeyboardWillAppear: (NSNotification *) notification{
    
    // Obtener el frame del teclado
    NSDictionary *info = notification.userInfo;
    NSValue *keyFrameValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyFrame = [keyFrameValue CGRectValue];
    
    
    // La duración de la animación del teclado
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Nuevo CGRect
    self.oldRect = self.boxNews.frame;
    CGRect newRect = CGRectMake(self.oldRect.origin.x,
                                self.oldRect.origin.y,
                                self.oldRect.size.width,
                                self.oldRect.size.height - keyFrame.size.height + self.toolBarView.frame.size.height - 10);
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:0
                     animations:^{
                         self.boxNews.frame = newRect;
                     } completion:^(BOOL finished) {
                         //
                     }];
    
}

// UIKeyboardWillHideNotification
-(void)notifyKeyboardWillDisappear: (NSNotification *) notification{
    
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:0
                     animations:^{
                         self.boxNews.frame = self.oldRect;
                     } completion:^(BOOL finished) {
                         //
                     }];
}


- (IBAction)hideKeyboard:(id)sender{
    
    [self.view endEditing:YES];
}

#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //OJO! pico de memoria asegurado, especialmente en dispositivos antiguos
    //sacamos la UIImage del diccionario
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //La guardo en el modelo
    self.news.image = UIImageJPEGRepresentation(img, 0.9);
    self.photoView.image = img;
    
    //Quito de encima el controlador que estamos presentando
    [self dismissViewControllerAnimated:YES completion:^{
        //Se ejecutará cuando se haya ocultado del todo
        
    }];
}
@end
