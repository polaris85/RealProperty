//
//  tableBusquedaViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 20/01/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableBusquedaViewController : UIViewController <NSURLConnectionDelegate, NSURLConnectionDataDelegate, UITableViewDataSource, UITableViewDelegate>
{
 
    NSArray         * json;
    NSArray         * tituloB;
    NSArray         * precioB;
    NSArray         * habitacionesB;
    NSArray         * banosB;
    NSArray         * IDInmuebleB;
    NSArray         * imagenThumb;
    NSMutableArray  * temp;
    NSArray         * direcc;
    NSArray         * estacionamiento;
    NSArray         * tipodeoperacion;
    
    NSArray         * destacado;
   
    NSArray         * imageList;
    NSArray         * imgThumF;
    NSString        * urlThumF;
    NSMutableArray  * urlThumA;
    NSString        * thumC;
    UIImage         * imagenF;
    NSString        * shareTitulo;
    
    NSArray         * unidadP;
    

    NSString *descatadoValor;
    NSString *tipodeoperacionCell;
    
    NSArray * HS;
    NSArray * BS;
    
}

@property (weak,nonatomic) NSString * recibirURl;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIView *helpView5;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)backButton:(id)sender;
- (IBAction)closeHelpScreen:(UIButton*)sender;


@end
