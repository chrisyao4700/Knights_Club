//
//  SearchMenuViewController.m
//  The Knights Club
//
//  Created by 姚远 on 7/29/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "SearchMenuViewController.h"

@interface SearchMenuViewController (){
    NSMutableArray * tableContent;
    NSMutableArray * dishTitles;
    
    KCDish * selectedDish;
    
     CGRect  screenRect;
}

@end

@implementation SearchMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initAllVars{
    tableContent = [[NSMutableArray alloc] init];
    dishTitles = [[NSMutableArray alloc] init];
    for (KCDish * dish in _menuDataArray) {
        [tableContent addObject:dish];
        [dishTitles addObject:dish.dishName];
    }
    
    screenRect = [[UIScreen mainScreen] bounds];
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    backgroundImageView.image = [UIImage imageNamed:@"Background"];
     [self.view insertSubview:backgroundImageView atIndex:0];
    
    if (!_selectedItemList) {
        _selectedItemList =  [KCItemListHandler readItemListFromFile];
    }
   
    
}

/* Table View */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return [sectionList objectAtIndex:section];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return tableContent.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
    
//    NSArray * dishSection = [tableContent objectAtIndex:indexPath.section];
    KCDish * dish = [tableContent objectAtIndex:indexPath.row];
    cell.nameLabel.text = dish.dishName;
    cell.priceLabel.text = [NSString stringWithFormat:@"$%@",dish.dishPrice];
    cell.m_imageView.contentMode = UIViewContentModeScaleAspectFit;
    //cell.m_imageView.image = [KCConnectDish configImagesWithDish:dish];
   // cell.m_imageView.image = [self configImagesWithImageView:nil andDish:nil];
    if (_imageDictionary) {
        cell.m_imageView.image = [UIImage imageWithData:[_imageDictionary objectForKey:dish.dishName]];
    }else{
        cell.m_imageView.image = [UIImage imageNamed:@"lulu"];
    }

    
    // cell.numberLabel.text = tableNumbers[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KCDish * dish = [tableContent objectAtIndex:indexPath.row];
    selectedDish = dish;
    [self performSegueWithIdentifier:@"searchMenuToDetail" sender:self];
    
}

/* End Table View */

/* Search Bar */



-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    tableContent = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< dishTitles.count; i++) {
        if ([[dishTitles[i] lowercaseString] containsString:[searchBar.text lowercaseString]]) {
            [tableContent addObject:[_menuDataArray objectAtIndex:i]];
        }
    }
    [_menuTable reloadData];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
}
/* End Search Bar */

- (IBAction)hitBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchMenuToDetail"]) {
        MenuDetailViewController * mdvc = (MenuDetailViewController *) [segue destinationViewController];
        mdvc.currentDish = selectedDish;
        mdvc.imageData = [_imageDictionary objectForKey:selectedDish.dishName];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
