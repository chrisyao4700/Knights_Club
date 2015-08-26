//
//  OrderDetailViewController.m
//  The Knights Club
//
//  Created by 姚远 on 8/4/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController (){
   
    UIAlertView * noOrderAlert;
    NSMutableData * _downloadedData;
    NSString * mode;
    CGRect screenRect;
    
    NSArray * selectedItemListData;
    KCItemList * selectedItemList;
    UIImageView* qrImageView;
    
    BOOL qrIsShowing;
    
}

@end

@implementation OrderDetailViewController

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
- (IBAction)hitQRButton:(id)sender {
    if (qrIsShowing == NO) {
        qrIsShowing = YES;
        [_qrButton setTitle:@"Dismiss" forState:UIControlStateNormal];
        qrImageView.hidden = NO;
        _orderContentView.hidden = YES;
        
  
    }else{
        qrIsShowing = NO;
        [_qrButton setTitle:@"QR Code" forState:UIControlStateNormal];
        qrImageView.hidden = YES;
        _orderContentView.hidden =NO;

        
    }
}

-(void) initAllVars{
    mode = [self checkOrderMode];
    if (mode) {
        if ([mode isEqualToString:@"Current"]) {
            [self initWithModeCurrent];
        }else if([mode isEqualToString:@"Previous"]){
            [self initWithModePrevious];
        }
    }
    
    screenRect = [[UIScreen mainScreen] bounds];
    
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    backgroundImageView.image = [UIImage imageNamed:@"Background"];
    [self.view insertSubview:backgroundImageView atIndex:0];

    
    CGRect imageFrame = CGRectMake(screenRect.size.width/2 - 100, screenRect.size.height/2 -100, 200, 200);
    qrImageView = [[UIImageView alloc]initWithFrame:imageFrame];
    [self.view addSubview:qrImageView];
    
    qrImageView.image = [KCQRCodeHandler generateQRCodeImageWithString:[_currentOrder kc_orderTitle]];
    
    qrImageView.hidden = YES;
    [_qrButton setTitle:@"QR Code" forState:UIControlStateNormal];
    qrIsShowing = NO;
    
    
    
    
}
-(NSString *) checkOrderMode{
    if ([_currentOrder.kc_orderState isEqualToString:@"Waiting"] || [_currentOrder.kc_orderState isEqualToString:@"Accepted"]||[_currentOrder.kc_orderState isEqualToString:@"Cooked"]) {
        return @"Current";
    }else{
        return @"Previous";
    }
    
    
}
-(void) initWithModeCurrent{
   // currentOrder = [KCConnectOrder readOrderFromFile];
    noOrderAlert = [[UIAlertView alloc]initWithTitle:@"No Order" message:@"You don't have any order on process" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    if (!_currentOrder) {
        [noOrderAlert show];
    }else{
        [self updateLabel:self];
        NSTimer* timer = [NSTimer timerWithTimeInterval:5.0f target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [self configElementsWithOrder];
       // _toolBar.hidden = YES;
        
    }

}
-(void) initWithModePrevious{
    noOrderAlert = [[UIAlertView alloc]initWithTitle:@"No Order" message:@"You don't have any order on process" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    if (!_currentOrder) {
        [noOrderAlert show];
    }else{
        [self configElementsWithOrder];
    }
}

-(void) updateLabel:(id) sender{
   
    [KCConnectOrder readOrderFromDatabaseWithColumn:@"Title" andValue:_currentOrder.kc_orderTitle andDelegate:self];
    
}

    
    


-(void) configElementsWithOrder{
    _titleLabel.text = _currentOrder.kc_orderTitle;
    _stateLabel.text = _currentOrder.kc_orderState;
    
    if ([_stateLabel.text isEqualToString:@"Waiting"]||[_stateLabel.text isEqualToString:@"Denied"]) {
        _state_image.image = [UIImage imageNamed:@"light_red"];
        
    }else if([_stateLabel.text isEqualToString:@"Accepted"] ||[_stateLabel.text isEqualToString:@"Cooked"]||[_stateLabel.text isEqualToString:@"Finished"]){
        _state_image.image = [UIImage imageNamed:@"light_green"];
    }
    _orderContentView.text =  [_currentOrder.kc_orderString stringByReplacingOccurrencesOfString:@"/" withString:@"\n"];
    
    _orderContentView.editable = NO;
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
    KCOrder * order = [[KCOrder alloc]initWithContentDictionary:[jsonArray objectAtIndex:0]];
    
    if (order) {
        _currentOrder = order;
        [self configElementsWithOrder];
    }
}
- (IBAction)pushOrderAgain:(id)sender {
//    KCOrder * localOrder = [KCConnectOrder fetchOrderFromList:[KCConnectOrder readOrdersFromFile] andKey:_currentOrder.kc_orderTitle];
//    NSArray * selectedItems = localOrder.kc_order_itemList;
//    selectedItemList = [[KCItemList alloc] initWithDataArray:selectedItems];
//    [self performSegueWithIdentifier:@"orderToCart" sender:self];
    
    NSDictionary * menu = [KCMenuHandler readMenuFromFile];
    NSDictionary * images= [KCImageHandler readImagesFromFile];
    KCItemList * list = [[KCItemList alloc] init];
    for (NSString * name in [self configDishNamesByOrder:_currentOrder]) {
        NSData * imgData = [images objectForKey:name];
        [list addItem:[[KCItem alloc] initWithDish:[[KCDish alloc] initWithContentDictionary: [menu objectForKey:name]] andQuantity:1 andRequirement:@"" andImageData:imgData]];
    }
    [KCItemListHandler saveItemListToFileWithList:list];
    
    [self performSegueWithIdentifier:@"orderToCart" sender:self];
    
    
}
-(NSArray *) configDishNamesByOrder:(KCOrder *) order{
    NSString * itemList = order.kc_menu_items;
    return [itemList componentsSeparatedByString:@","];
}
 
- (IBAction)pushDelete:(id)sender {
    
}



#pragma mark -

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"orderToCart"]) {
        CartViewController * ctvc = (CartViewController *)[segue destinationViewController];
        ctvc.selectedItemList =selectedItemList;
        
        
        }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
