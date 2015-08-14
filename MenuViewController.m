//
//  MenuViewController.m
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "MenuViewController.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface MenuViewController (){
    NSMutableData * _downloadedData;
    NSMutableArray * knightsClubMenu;
    NSMutableArray * sectionList;
    NSMutableArray * sectionDataArray;
    NSDictionary * retrivedMenu;
        
    
    KCDish * selectedDish;
    CGRect  screenRect;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    [self readMenuFromDatabase];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* Table View Data */


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return sectionDataArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [sectionList objectAtIndex:section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [[sectionDataArray objectAtIndex:section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
    
    
    KCDish * dish = [[sectionDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.nameLabel.text = dish.dishName;
    cell.priceLabel.text = [NSString stringWithFormat:@"$%@",dish.dishPrice];
    cell.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage * dishImage = [UIImage imageWithData:[_imageDictionary objectForKey:dish.dishName]];
    

    if (dishImage) {
        cell.m_imageView.image = dishImage;
    }else{
        cell.m_imageView.image = [UIImage imageNamed:[self configLoadingImageNameWithInterger:indexPath.row%5]];
    }
      return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KCDish * dish = [[sectionDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    selectedDish = dish;
    [self performSegueWithIdentifier:@"mainMenuToDetail" sender:self];
    
    
}



/* Database Connection */

-(void) readMenuFromDatabase{
    [KCConnectDish readDishesFromDatabaseWithDelegate:self];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
   // NSMutableDictionary * tmpDict =[[NSMutableDictionary alloc] init];
    NSMutableArray * dishNames =[[NSMutableArray alloc] init];
    NSMutableArray * dishData = [[NSMutableArray alloc] init];
    for (NSDictionary * contentDictionary in jsonArray) {
        KCDish * dish = [[KCDish alloc] initWithContentDictionary:contentDictionary];
        [knightsClubMenu addObject:dish];
        [dishNames addObject:dish.dishName];
        [dishData addObject:dish.contentDictionary];
        //[tmpDict setValue:dish forKey:dish.dishName];
      
        }
    
     [self configTableData];
    retrivedMenu = [[NSDictionary alloc] initWithObjects:dishData forKeys:dishNames];
    [KCMenuHandler saveMenuToFile:retrivedMenu];
}
-(void) initAllVars{
   // [_closeControllerDelegate closeFatherController];
    if (!_selectedItemList) {
        _selectedItemList = [KCItemListHandler readItemListFromFile];
    }
    if (!_selectedItemList) {
        _selectedItemList = [[KCItemList alloc]init];
    }
    screenRect = [[UIScreen mainScreen] bounds];
    
    [self configToolBar];
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    backgroundImageView.image = [UIImage imageNamed:@"Background"];
    [self.view insertSubview:backgroundImageView atIndex:0];
  
    _imageDictionary = [[NSMutableDictionary alloc]init];
    knightsClubMenu = [[NSMutableArray alloc]init];
    sectionList = [[NSMutableArray alloc]init];

}

-(void) configToolBar{
    CGFloat buttonWidth = screenRect.size.width/4;
    CGFloat buttonHeight = 60;
    
    
    
    _menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [_menuButton addTarget:self action:@selector(hitMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_menuButton setBackgroundImage: [UIImage imageNamed:@"kc_menu_sel"] forState:UIControlStateNormal];
    [_toolBarView addSubview:_menuButton];
    
    _cartButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth, 0, buttonWidth, buttonHeight)];
    [_cartButton addTarget:self action:@selector(hitCart:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([KCItemListHandler cartIsEmpty] ==YES) {
        [_cartButton setBackgroundImage: [UIImage imageNamed:@"kc_cart_tbi"] forState:UIControlStateNormal];
    }else{
        [_cartButton setBackgroundImage: [UIImage imageNamed:@"kc_fcart_tbi"] forState:UIControlStateNormal];
    }

    [_toolBarView addSubview:_cartButton];
    
    
    ///////----------------------------
    _eventButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth *2, 0, buttonWidth, buttonHeight)];
    [_eventButton addTarget:self action:@selector(hitEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_eventButton setBackgroundImage: [UIImage imageNamed:@"kc_event_tbi"] forState:UIControlStateNormal];
    [_toolBarView addSubview:_eventButton];
    
    ///////----------------------------
    
    _meButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth*3, 0, buttonWidth, buttonHeight)];
    [_meButton addTarget:self action:@selector(hitMe:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_meButton setBackgroundImage: [UIImage imageNamed:@"kc_me_tbi"] forState:UIControlStateNormal];
    [_toolBarView addSubview:_meButton];
    
    
    
}


-(void) configTableData{
    sectionDataArray = [[NSMutableArray alloc]init];
    for (KCDish * dish in knightsClubMenu) {
        BOOL catagoryFound = NO;
        for (NSString * catagory in sectionList) {
            
            if ([dish.dishCategory isEqualToString:catagory]) {
                catagoryFound = YES;
                for (NSMutableArray * sct in sectionDataArray) {
                    if ([[[sct objectAtIndex:0] dishCategory] isEqualToString:catagory]) {
                        [sct addObject:dish];
                    }
                }
            }
        }
        if (catagoryFound == NO) {
            [sectionList addObject:dish.dishCategory];
            NSMutableArray * section = [[NSMutableArray alloc]init];
            [section addObject:dish];
            [sectionDataArray addObject:section];
        }
    }
    _imageDictionary = [[NSMutableDictionary alloc]initWithDictionary:[KCImageHandler readImagesFromFile]];
    [_menuTable reloadData];
    dispatch_async(kBgQueue, ^{
       [self configImageDictionary];
        [KCImageHandler saveImagesToLocalFileWithImageDictionary:_imageDictionary];
        [_menuTable reloadData];
    });
    
    
    
    //retrivedMenu =[[NSDictionary alloc] initWithObjects:sectionDataArray forKeys:sectionList];
    //   [_menuTable reloadData];
   
    
}


-(NSString *) configLoadingImageNameWithInterger: (NSInteger) row{
    NSString * img_name = [NSString stringWithFormat:@"lulu%zd", row];
    return img_name;
}

-(void) configImageDictionary{
   
    
    for (KCDish * dish in knightsClubMenu) {
        NSData * data = [KCConnectDish configImagesWithDish:dish andDelegate:self];
        if (data) {
             [_imageDictionary setObject: data forKey:dish.dishName];
        }
       
        }
    
}
- (IBAction)hitSearch:(id)sender {
    [self performSegueWithIdentifier:@"menuToSearch" sender:self];
}
- (IBAction)hitMenu:(id)sender {
   
    
}

- (IBAction)hitCart:(id)sender {
    [self performSegueWithIdentifier:@"menuToCart" sender:self];
}
- (IBAction)hitEvent:(id)sender {
    [self performSegueWithIdentifier:@"menuToEvent" sender:self];
}
- (IBAction)hitMe:(id)sender {
    [self performSegueWithIdentifier:@"menuToMe" sender:self];
}
-(void)closeFatherController{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)updateFatherViewController{
    [self viewDidLoad];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [KCItemListHandler saveItemListToFileWithList:_selectedItemList];
    
    if ([segue.identifier isEqualToString:@"menuToSearch"]) {
        SearchMenuViewController * smvc = (SearchMenuViewController *)[segue destinationViewController];
        smvc.menuDataArray = knightsClubMenu;
        smvc.selectedItemList = _selectedItemList;
        smvc.imageDictionary = _imageDictionary;
    }else if([segue.identifier isEqualToString:@"mainMenuToDetail"]){
        MenuDetailViewController * mdvc = (MenuDetailViewController *)[segue destinationViewController];
        KCDish * copy_dish = [[KCDish alloc]initWithContentArray:[selectedDish.contentArray copy]];
        mdvc.currentDish =  copy_dish;
        mdvc.selectedItemList = _selectedItemList;
        mdvc.refreshDelegate = self;
        
        if ([_imageDictionary objectForKey:selectedDish.dishName]) {
            mdvc.imageData = [[_imageDictionary objectForKey:selectedDish.dishName] copy];
        }else{
            UIImage * luluImage = [UIImage imageNamed:@"lulu"];
            NSData * luluDataPic = UIImagePNGRepresentation(luluImage);
            mdvc.imageData = luluDataPic;
        }
    }else if ([segue.identifier isEqualToString:@"menuToCart"] ){
        CartViewController * cvc = (CartViewController *) [segue destinationViewController];
        cvc.selectedItemList = _selectedItemList;
        cvc.dismisViewDelegate = self;
      //  [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if([segue.identifier isEqualToString:@"menuToMe"]){
        CustomerViewController * ctvc = (CustomerViewController *) [segue destinationViewController];
        ctvc.dismisViewDelegate = self;
    }else if([segue.identifier isEqualToString:@"menuToEvent"]){
        EventViewController * evc = (EventViewController *) [segue destinationViewController];
        evc.dismissFatherViewDelegate = self;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
