//
//  MenuViewController.m
//  The Knights Club
//
//  Created by 姚远 on 7/28/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController (){
    NSMutableData * _downloadedData;
    NSMutableArray * knightsClubMenu;
    NSMutableArray * sectionList;
    NSMutableArray * sectionDataArray;
    NSDictionary * retrivedMenu;
    
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    [self readMenuFromDatabase];
    // Do any additional setup after loading the view.
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
    
    NSArray * dishSection = [sectionDataArray objectAtIndex:indexPath.section];
    KCDish * dish = [dishSection objectAtIndex:indexPath.row];
    cell.nameLabel.text = dish.dishName;
    cell.priceLabel.text = [NSString stringWithFormat:@"$%@",dish.dishPrice];
    cell.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.m_imageView.image = [KCConnectDish configImagesWithDish:dish];
    
    
    // cell.numberLabel.text = tableNumbers[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    knightsClubMenu = [[NSMutableArray alloc]init];
    sectionList = [[NSMutableArray alloc]init];
    
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
    
    
    retrivedMenu =[[NSDictionary alloc] initWithObjects:sectionDataArray forKeys:sectionList];
    

    
    
     [_menuTable reloadData];
}
- (IBAction)hitSearch:(id)sender {
    [self performSegueWithIdentifier:@"menuToSearch" sender:self];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"menuToSearch"]) {
        SearchMenuViewController * smvc = (SearchMenuViewController *)[segue destinationViewController];
        smvc.menuDataArray = knightsClubMenu;
        smvc.selectedItems = _selectedItems;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
