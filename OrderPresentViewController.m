//
//  OrderPresentViewController.m
//  The Knights Club
//
//  Created by 姚远 on 8/4/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "OrderPresentViewController.h"

@interface OrderPresentViewController (){
    NSMutableDictionary * orderDataDictionary;
    
    NSMutableData * _downloadedData;
    
    NSURLConnection * readOrderConnection;
    
    NSArray * tableContent;
    
    KCCustomer * customer;
    
    
    NSArray * tdOrderTable;
    NSArray * tableHeaders;
    
    NSString * tableMode;
    
    NSDictionary * imageDictionary;
    
    CGRect screenRect;
    
    KCOrder * selectedOrder;
    
    
}

@end

@implementation OrderPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hitBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)hitAllOrder:(id)sender {
    
    [self configTableContentWithMode:@"AllOrder"];
}

- (IBAction)hitCurrent:(id)sender {
    [self configTableContentWithMode:@"CurrentOrder"];
}
- (IBAction)hitFinishedOrder:(id)sender {
    [self configTableContentWithMode:@"FinishedOrder"];
}


-(void) initAllVars{
    tableMode = @"AllOrder";
    customer = [KCCustomerHandler readCustomerFromFile];
    orderDataDictionary = [[NSMutableDictionary alloc]init];
    imageDictionary = [KCImageHandler readImagesFromFile];
    readOrderConnection = [KCConnectOrder readOrderFromDatabaseWithColumn:@"Customer" andValue:customer.networkID andDelegate:self];
    
    screenRect = [[UIScreen mainScreen] bounds];
    
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    backgroundImageView.image = [UIImage imageNamed:@"Background"];
    [self.view insertSubview:backgroundImageView atIndex:0];
    //[self configTableContentWithMode:tableMode];
    
}

/* Database */
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
    
    NSMutableArray * orderKeys = [[NSMutableArray alloc] init];
    NSMutableArray * orderValues = [[NSMutableArray alloc] init];
    
    for (int i =0; i< jsonArray.count; i++) {
        
        KCOrder * order = [[KCOrder alloc]initWithContentDictionary:[jsonArray objectAtIndex:i]];
        [orderValues addObject:order];
        BOOL hasKey = NO;
        for (NSString * key in orderKeys ) {
            if ([order.kc_orderState isEqualToString:key]) {
                hasKey = YES;
                break;
            }
           
        }
        if (hasKey ==NO) {
            [orderKeys addObject:order.kc_orderState];
        }
    }
    
    [self configDataDictionaryByKeys:orderKeys andValues:orderValues];
    
}

-(void) configDataDictionaryByKeys:(NSArray *) keys andValues:(NSArray *) values{
    for (NSString * key in keys) {
        NSMutableArray * orderWithKey = [[NSMutableArray alloc]init];
        
        for (KCOrder * order in values) {
            if ([order.kc_orderState isEqualToString:key]) {
                [orderWithKey addObject: order];
            }
        }
        [orderDataDictionary setValue:orderWithKey forKey:key];
        //[self configTableContentWithMode:tableMode];
    }
    
    [self configTableContentWithMode:tableMode];
    //[_orderContentView reloadData];
    
}

-(void) configTableContentWithMode:(NSString *) mode{
    tableMode = mode;
    if ([mode isEqualToString:@"AllOrder"]) {
        
        tdOrderTable = [orderDataDictionary allValues];
        tableHeaders = [orderDataDictionary allKeys];
        
        
    }if ([mode isEqualToString:@"CurrentOrder"]) {
        NSMutableArray * tmpContent = [[NSMutableArray alloc] init];
        [tmpContent addObjectsFromArray:[orderDataDictionary objectForKey:@"Unaccepted"]];
        [tmpContent addObjectsFromArray:[orderDataDictionary objectForKey:@"Accepted"]];
        [tmpContent addObjectsFromArray:[orderDataDictionary objectForKey:@"Cooked"]];
        tableContent = tmpContent;
    }else if([mode isEqualToString:@"FinishedOrder"]){
        NSMutableArray * tmpContent = [[NSMutableArray alloc] init];
        [tmpContent addObjectsFromArray:[orderDataDictionary objectForKey:@"Denied"]];
        [tmpContent addObjectsFromArray:[orderDataDictionary objectForKey:@"Finished"]];
        tableContent = tmpContent;
    }
    
    
    [_orderContentView reloadData];
}




-(NSArray *) configDishNamesByOrder:(KCOrder *) order{
    NSString * itemList = order.kc_menu_items;
    return [itemList componentsSeparatedByString:@","];
}

-(NSArray *) configImagesByNameArray:(NSArray *) dishArr{
    NSMutableArray * images = [[NSMutableArray alloc] init];
    
    for (NSString * nameStr in dishArr) {
        [images addObject:[imageDictionary objectForKey:nameStr]];
    }
    return images;
}

/*Table View */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([tableMode isEqualToString:@"AllOrder"]) {
        return tableHeaders.count;
    }
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([tableMode isEqualToString:@"AllOrder"]) {
        return tableHeaders[section];
    }else{
       return nil;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    
    if ([tableMode isEqualToString:@"AllOrder"]) {
        return [tdOrderTable[section] count];
    }else{
        return tableContent.count;
    }
    
    
    // }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderPresentTableViewCell* cell = [_orderContentView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
    KCOrder * order;
    if ([tableMode isEqualToString:@"AllOrder"]) {
        order = [[tdOrderTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
       
        
        
        
    }else{
        
        order = [tableContent objectAtIndex:indexPath.row];
    }
    
    NSArray * images = [self configImagesByNameArray:[self configDishNamesByOrder:order]];
    
    if (images.count>=3) {
        cell.first_item.image = [UIImage imageWithData:[images objectAtIndex:0]];
        cell.second_item.image = [UIImage imageWithData:[images objectAtIndex:1]];
        cell.third_item.image = [UIImage imageWithData:[images objectAtIndex:2]];
    }else if (images.count == 2){
        cell.first_item.image = [UIImage imageWithData:[images objectAtIndex:0]];
        cell.second_item.image = [UIImage imageWithData:[images objectAtIndex:1]];
    }else{
        cell.first_item.image = [UIImage imageWithData:[images objectAtIndex:0]];
    }
    
    cell.dateLabel.text = order.kc_order_date;
    cell.timeLabel.text = order.kc_order_time;
    cell.tittleLabel.text = order.kc_orderTitle;

    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KCOrder * order;
    if ([tableMode isEqualToString:@"AllOrder"]) {
        order = [[tdOrderTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
    }else{
        order = [tableContent objectAtIndex:indexPath.row];
    }
    
    selectedOrder = order;
    
    [self performSegueWithIdentifier:@"orderMasterToDetail" sender:self];
    
}






#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"orderMasterToDetail"]) {
        OrderDetailViewController * odvc = (OrderDetailViewController *)[segue destinationViewController];
        odvc.currentOrder = selectedOrder;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
