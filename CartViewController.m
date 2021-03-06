//
//  CartViewController.m
//  The Knights Club
//
//  Created by 姚远 on 7/30/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController (){
    CGRect screenRect;
    
    KCItem * selectedItem;
    BOOL isUped;
    
    
    float fl_totalPrice;
    float fl_tax;
    float fl_tips;
    float fl_totalCharge;
    
    NSString * str_totalPrice;
    NSString * str_tax;
    NSString * str_tips;
    NSString * str_totalCharge;
}

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllVars];
    _totalChargeLabel.hidden =YES;
    _taxValueLabel.hidden = YES;
    _tipsField.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(void) initAllVars{
    
    
    screenRect = [[UIScreen mainScreen] bounds];
   
    if (!_selectedItemList) {
        _selectedItemList =  [KCItemListHandler readItemListFromFile];
    }
    
//    if(_dismisViewDelegate){
//    [_dismisViewDelegate closeFatherController];
//    }
    
    _tipsField.delegate = self;
    isUped = NO;
    
    [self configToolBar];
    
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    backgroundImageView.image = [UIImage imageNamed:@"Background"];
    [self.view insertSubview:backgroundImageView atIndex:0];
    [self configLabels];
    
}


-(void)updateItemList: (KCItemList *) updatedList{
    _selectedItemList = updatedList;
    //[self initAllVars];
    //[_orderTable reloadData];
    [self configLabels];
}

-(void) configLabels{
    fl_totalPrice = 0.0;
    for (NSDictionary * itemDic in _selectedItemList.selectedItemArray) {
        KCItem * item = [[KCItem alloc]initWithDictionary:itemDic];
        KCDish * dish = item.kc_selectedDish;
        int quantity = item.kc_quantity.intValue;
        fl_totalPrice += dish.dishPrice.floatValue * quantity;
    }
    fl_tax = fl_totalPrice * 0.06;
    fl_tips = 0;
    fl_totalCharge = fl_totalPrice + fl_tax;
    
    str_totalPrice = [NSString stringWithFormat:@"$%.2f", fl_totalPrice];
    str_tax = [NSString stringWithFormat:@"$%.2f", fl_tax];
    str_totalCharge = [NSString stringWithFormat:@"$%.2f", fl_totalCharge];
    
    _taxValueLabel.text = str_tax;
    _orderPriceLabel.text = str_totalPrice;
    _totalChargeLabel.text = str_totalCharge;
    _tipsField.placeholder = [NSString stringWithFormat:@"15%%:%.2f", (fl_totalPrice + fl_tax) *0.15];
    [_orderTable reloadData];

}


- (IBAction)tipsChange:(id)sender {
    fl_tips = _tipsField.text.floatValue;
    fl_totalCharge = fl_totalPrice + fl_tax + fl_tips;
    str_totalPrice = [NSString stringWithFormat:@"$%.2f", fl_totalCharge];
    _totalChargeLabel.text = str_totalPrice;
}



- (IBAction)hitCheckOut:(id)sender {
    if (!_selectedItemList || _selectedItemList.dataArray.count == 0) {
        UIAlertView * emptyCart = [[UIAlertView alloc] initWithTitle:@"Empty Cart" message:@"Sorry, you don't have anything in cart." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [emptyCart show];
    }else{
    [self performSegueWithIdentifier:@"cartToPay" sender:self];
    }
}

- (IBAction)hitMenu:(id)sender {
    [self performSegueWithIdentifier:@"cartToMenu" sender:self];
}
- (IBAction)hitCart:(id)sender {
}
- (IBAction)hitEvent:(id)sender {
    [self performSegueWithIdentifier:@"cartToEvent" sender:self];
}
- (IBAction)hitMe:(id)sender {
    [self performSegueWithIdentifier:@"cartToMe" sender:self];
}
- (IBAction)hitClear:(id)sender {
    //[KCItemListHandler deleteItemListInFile];
    [_selectedItemList resetList];
    [KCItemListHandler saveItemListToFileWithList:_selectedItemList];
    //[self viewDidLoad];
    [self performSegueWithIdentifier:@"cartToMenu" sender:self];
    //[self configLabels];
    //[self configToolBar];
   // [_orderTable reloadData];
}

-(void) configToolBar{
    CGFloat buttonWidth = screenRect.size.width/4;
    CGFloat buttonHeight = 60;
    
    
    
    _menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [_menuButton addTarget:self action:@selector(hitMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_menuButton setBackgroundImage: [UIImage imageNamed:@"kc_menu_tbi"] forState:UIControlStateNormal];
    [_toolBarView addSubview:_menuButton];
    
    _cartButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth, 0, buttonWidth, buttonHeight)];
    [_cartButton addTarget:self action:@selector(hitCart:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([KCItemListHandler cartIsEmpty] ==YES) {
        [_cartButton setBackgroundImage: [UIImage imageNamed:@"kc_ecart_sel"] forState:UIControlStateNormal];
    }else{
        [_cartButton setBackgroundImage: [UIImage imageNamed:@"kc_fcart_sel"] forState:UIControlStateNormal];
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


/* Table View */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return _selectedItemList.selectedItemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell" forIndexPath:indexPath];
    
    
    KCItem * item = [[KCItem alloc]initWithDictionary: _selectedItemList.selectedItemArray[indexPath.row]];
    
    cell.quantityLabel.text = [NSString stringWithFormat:@"X%@", item.kc_quantity.stringValue];
    cell.priceLabel.text = [NSString stringWithFormat:@"$%@",item.kc_selectedDish.dishPrice];
    cell.item_imageView.contentMode = UIViewContentModeScaleAspectFit;
    if ([item.kc_requirement isEqualToString:@""]) {
        cell.requirementView.text = @"No Special Requirement";
        cell.requirementView.editable = NO;
    }else{
        cell.requirementView.text = item.kc_requirement;
        cell.requirementView.editable = NO;
    }
    
    UIImage * dishImage = [UIImage imageWithData:item.kc_imageData];
    
    cell.item_imageView.image = dishImage;
    
    
    
    // cell.numberLabel.text = tableNumbers[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedItem = [[KCItem alloc]initWithDictionary:[[_selectedItemList.selectedItemArray objectAtIndex:indexPath.row] copy]];
    [_selectedItemList deleteItemWithIndext:indexPath.row];
    [self performSegueWithIdentifier:@"cartToDetail" sender:self];
    
    
}
/* End Table View */


/* TextView & TextField */

#define kOFFSET_FOR_KEYBOARD 200.0


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [self.tipsField resignFirstResponder];
    
    return YES;
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
   
    return YES;
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (isUped == NO)
    {
        [self setViewMovedUp:YES];
        isUped = YES;
    }
    else if (isUped == YES)
    {
        //[self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (isUped == NO)
    {
        
        [self setViewMovedUp:NO];
        isUped = NO;
    }
    else if (isUped == YES)
    {
        [self setViewMovedUp:NO];
        isUped = NO;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    
       
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    //CGRect textViewRect = self.requirementView.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        //rect.size.height += kOFFSET_FOR_KEYBOARD;
        //textViewRect.origin.y -= kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        //rect.size.height -= kOFFSET_FOR_KEYBOARD;
        //textViewRect.origin.y += kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    //_requirementView.frame = textViewRect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
/* End Text View */
-(void) closeFatherController{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"cartToMe"]) {
        [KCItemListHandler saveItemListToFileWithList:_selectedItemList];
    }else if ([[segue identifier] isEqualToString:@"cartToDetail"]) {
        MenuDetailViewController * mdvc = (MenuDetailViewController *)[segue destinationViewController];
        mdvc.selectedItemList = _selectedItemList;
        mdvc.currentDish = [selectedItem kc_selectedDish];
        mdvc.imageData = selectedItem.kc_imageData;
        mdvc.updateItemListDelegate = self;
        mdvc.si_quantity = selectedItem.kc_quantity;
        mdvc.si_requirement = selectedItem.kc_requirement;
        
    
    }else if ([segue.identifier isEqualToString:@"cartToMenu"]){
        MenuViewController * mvc = (MenuViewController *) [segue destinationViewController];
        mvc.selectedItemList = _selectedItemList;
        mvc.closeControllerDelegate = self;
        
    }else if ([segue.identifier isEqualToString:@"cartToEvent"]){
        EventViewController * evc = (EventViewController *) [segue destinationViewController];
        evc.dismissFatherViewDelegate = self;
    }else if ([segue.identifier isEqualToString:@"cartToPay"]){
        PaymentViewController * pvc = (PaymentViewController *) [segue destinationViewController];
        pvc.itemList = _selectedItemList;
        if (_tipsField.text.floatValue) {
            pvc.tips = [NSNumber numberWithFloat:_tipsField.text.floatValue];
        }else{
            pvc.tips = [NSNumber numberWithInt:0];
        }
        if (_finalRequirementView.text) {
            pvc.finalRequirement = _finalRequirementView.text;
        }
        pvc.tax = _taxValueLabel.text;
        pvc.total = _totalChargeLabel.text;
        pvc.refreshDelegate = self;
        pvc.orderTotal = _orderPriceLabel.text;
        
        
    }
   
}

@end
