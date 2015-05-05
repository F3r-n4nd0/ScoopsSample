//
//  FLMNewsTableViewController.m
//  FLMScoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 F3rn4nd0. All rights reserved.
//

#import "FLMNewsTableViewController.h"
#import "FLMNewsViewController.h"
#import "FLMUser.h"
#import "FLMNews.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface FLMNewsTableViewController ()
@property (strong, nonatomic) NSArray *news;
@end

@implementation FLMNewsTableViewController

-(id) initWithUser: (FLMUser *) user aMSClient: (MSClient *) client{
    
    if (self = [super init]) {
        _userLog = user;
        _client = client;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //Obtener los datos de noticias
    [self getNews];
    
    //following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.news.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FLMNews *new = [self.news objectAtIndex:indexPath.row];
    
    // Crear una celda
    static NSString *cellID = @"notebookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleSubtitle
                reuseIdentifier:cellID];
    }
    
    // Configurarla (sincronizar libreta -> celda)
    //cell.imageView.image = [UIImage imageWithData:book.photo.photoData];
    cell.textLabel.text = new.title;
    cell.detailTextLabel.text = new.author;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Devolverla
    return cell;
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    FLMNews *news = [self.news objectAtIndex:indexPath.row];
    
    //Creamos un book
    FLMNewsViewController *nVC = [[FLMNewsViewController alloc] initWithNews:news aClient:self.client];
    
    //Hago un push
    [self.navigationController pushViewController:nVC animated:YES];
    
}

-(void) getNews{
    
    NSMutableArray *arrayNew = [NSMutableArray new] ;
    
    MSTable *newss = [self.client tableWithName:@"news"];

    
    [newss readWithCompletion:^(MSQueryResult *result, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@", error);
        } else {
            
            
            NSDictionary *items = [result valueForKey:@"items"];
            
            for (id item in items) {
                
                FLMNews *new = [[FLMNews alloc] initWithIdNews:[item valueForKey:@"id"] aTitle:[item valueForKey:@"titulo"] andPhoto:nil aText:[item valueForKey:@"noticia"] anAuthor:[item valueForKey:@"autor"] anIdUser:[item valueForKey:@"userid"] aValoracion:[[item valueForKey:@"valoracion"] boolValue] aState:[item valueForKey:@"estado"] aClient:self.client];
                
                [arrayNew addObject:new];
            }

            self.news = arrayNew;
        }
        
        [self.tableView reloadData];
    }];
    
}




@end
