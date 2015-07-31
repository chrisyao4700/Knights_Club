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
        cell.m_imageView.image = [UIImage imageNamed:@"lulu"];
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
    for (NSDictionary * contentDictionary in jsonArray) {
        KCDish * dish = [[KCDish alloc] initWithContentDictionary:contentDictionary];
        [knightsClubMenu addObject:dish];
      
        }
     [self configTableData];
}
-(void) initAllVars{
    [_closeControllerDelegate closeFatherController];
    if (!_selectedItemList) {
        _selectedItemList = [[KCItemList alloc]init];
    }
    
  
    _imageDictionary = [[NSMutableDictionary alloc]init];
    knightsClubMenu = [[NSMutableArray alloc]init];
    sectionList = [[NSMutableArray alloc]init];
    
    screenRect = [[UIScreen mainScreen] bounds];
    
    [_menuItem setWidth:screenRect.size.width/5];
    [_meItem setWidth:screenRect.size.width/5];
    [_eventItem setWidth:screenRect.size.width/5];
    [_cartItem setWidth:screenRect.size.width/5];
    
    
   
    
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

-(void) configImageDictionary{
   
    
    for (KCDish * dish in knightsClubMenu) {
        NSData * data = [KCConnectDish configImagesWithDish:dish andDelegate:self];
        [_imageDictionary setObject: data forKey:dish.dishName];
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
}
- (IBAction)hitMe:(id)sender {
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
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
      //  [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
