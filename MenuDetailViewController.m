//
//  MenuDetailViewController.m
//  The Knights Club
//
//  Created by 姚远 on 7/29/15.
//  Copyright (c) 2015 Gannon University. All rights reserved.
//

#import "MenuDetailViewController.h"

@interface MenuDetailViewController (){
    BOOL isEmpty;
    CGRect screenRect;
    
    BOOL isFromCart;
    //
    
}

@end

@implementation MenuDetailViewController

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
    [_updateItemListDelegate updateItemList:_selectedItemList];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)sliderChanged:(id)sender {
    _quantityLabel.text = [NSString stringWithFormat:@"%d",(int)_quantitySlider.value];
}

- (IBAction)pushAddToCart:(id)sender {
    [_selectedItemList addItem:[self configItem]];
    [KCItemListHandler saveItemListToFileWithList:_selectedItemList];

    if (_updateItemListDelegate) {
        [_updateItemListDelegate updateItemList:_selectedItemList];
    }
    
       [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) initAllVars{
   // _quantitySlider.transform = CGAffineTransformMakeRotation(1.57079633);
   // movementDistance
    screenRect = [[UIScreen mainScreen] bounds];
    
    if (!_selectedItemList) {
      _selectedItemList =  [KCItemListHandler readItemListFromFile];
    }
    isFromCart = NO;
    isEmpty = YES;
    CGPoint addButton_center = CGPointMake(screenRect.size.width/2, screenRect.size.height - 25);
    _addCartButton.center = addButton_center;
    [_quantitySlider setValue:0.0 animated:YES];
    
    [_quantitySlider setMaximumValue:5.0];
    [_quantitySlider setMinimumValue:1.0];
    
    
    UIImageView * backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    backgroundImageView.image = [UIImage imageNamed:@"Background"];
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    if ((_si_quantity) && (_si_requirement)) {
        [self configCartReturnMode];
    }
    if (isEmpty == YES) {
        _requirementView.delegate = self;
        _requirementView.text = @"Special Requirement Here~~ ^.^";
        _requirementView.textColor = [UIColor lightGrayColor];
    }
    

}
-(void) configCartReturnMode{
    isFromCart = YES;
    if (_si_requirement.length > 0) {
        isEmpty = NO;
    }
    _quantityLabel.text = _si_quantity.stringValue;
    [_quantitySlider setValue:_si_quantity.floatValue animated:YES];
    _requirementView.text = _si_requirement;
    [_backButton setTitle:@"Delete" forState:UIControlStateNormal];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(BOOL) textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView*)textView {
    if (isEmpty == YES) {
        _requirementView.text = @"";
        _requirementView.textColor = [UIColor blackColor];
        isEmpty = NO;
    }else{
        _requirementView.textColor = [UIColor blackColor];
    }
    return YES;
}

- (void) textViewDidEndEditing:(UITextView*)textView {
    if(_requirementView.text.length == 0){
        _requirementView.textColor = [UIColor lightGrayColor];
        _requirementView.text = @"Special Requirement Here~~ ^.^";
        isEmpty = YES;
    }
    
}
#define kOFFSET_FOR_KEYBOARD 200.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
  
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    CGRect textViewRect = self.requirementView.frame;
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
    _requirementView.frame = textViewRect;
    
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

-(KCItem *) configItem{
    NSInteger itemQuantity = _quantityLabel.text.integerValue;
    NSString * requirementText;
    if ([_requirementView.text isEqualToString:@"Special Requirement Here~~ ^.^"]) {
        requirementText = @"";
    }else{
        requirementText = _requirementView.text;
    }
//    if (!_imageData) {
//         NSData * luluImage = [[NSData alloc]initWithContentsOfFile:@"lulu.png"];
//        _imageData = luluImage;
//    }
    KCItem * item = [[KCItem alloc] initWithDish:_currentDish andQuantity: itemQuantity andRequirement:requirementText andImageData:_imageData];
    return item;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"dishDetail"]) {
        DishDetailScrllViewController * ddsvc = (DishDetailScrllViewController *)[segue destinationViewController];
        ddsvc.selectedDish = _currentDish;
        ddsvc.imageData = _imageData;
    }
   
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
