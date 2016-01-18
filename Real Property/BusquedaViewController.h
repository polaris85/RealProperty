//
//  BusquedaViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 06/01/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UICheckbox;

@interface BusquedaViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, NSURLConnectionDelegate>
{
    NSURLConnection * conetTipo;
    NSMutableData * datosTipo;
    NSDictionary * obj;
    UITextField * currentTextField;
    NSArray * currentArray;
    NSArray * tipoDescription;
    NSArray * operaciones;
    NSArray * condiciones;
    UITextField * DesdeField;
    UITextField * desdeField;
    
    NSMutableArray * StringComplete;
    
    //IDS m arreglo con JSON M arrreglo con ID
    NSArray * tipoID;
    NSString * TipoID;
    NSArray * regionesID;
    NSString * RegionesID;
    NSArray * comunaID;
    NSString * ComunaID;
    NSArray * condID;
    NSString * CondID;
    NSArray * operaID;
    NSString * OperaID;
    NSArray * habID;
    NSString * HabID;
    NSArray * banosID;
    NSString * BanosID;
    NSArray * dispID;
    NSString * DispID;
    NSString * desdeV;
    NSString * hastaV;
    NSArray * moneda;
    NSArray * monedaValor;
    NSString * monedaID;
    
    NSString * CountInmM;
    UIToolbar* numberToolbar;
    // Buqueda
    
    NSURLConnection * conBusqueda;
    NSMutableData *DataBusqueda;
    NSArray * algo2;
    UITableViewCell *cell;
    NSMutableString * urlString;
    
    

}

@property (nonatomic, strong) IBOutlet UIPickerView * pvInmuebles;
@property (strong, nonatomic) IBOutlet UITextField * tipoField;
@property (strong, nonatomic) IBOutlet UITextField *regionField;
@property (strong, nonatomic) IBOutlet UITextField *comunasField;
@property (strong, nonatomic) IBOutlet UITextField *habField;
@property (strong, nonatomic) IBOutlet UITextField *banoField;
@property (strong, nonatomic) IBOutlet UITextField *dispField;
@property (strong, nonatomic) IBOutlet UITextField *HastaField;
@property (strong, nonatomic) IBOutlet UITextField *condField;
@property (strong, nonatomic) IBOutlet UITextField *operaField;
@property (strong, nonatomic) IBOutlet UITextField *PrecioField;
@property (strong, nonatomic) IBOutlet UIView *PVVcontainer;
@property (strong, nonatomic) IBOutlet UITextField *superDesde;
@property (strong, nonatomic) IBOutlet UITextField *superHasta;

@property (strong, nonatomic) IBOutlet UITextField *volumenHasta;
@property (strong, nonatomic) IBOutlet UITextField *volumenDes;

@property (strong, nonatomic) IBOutlet UIView *helpView3;


@property (nonatomic, strong) NSArray * jsonTipo;
//@property (nonatomic, strong) NSArray * tipoDescription;
@property (nonatomic, strong) NSArray * jsonRegiones;
@property (nonatomic, strong) NSArray * regionesDescription;
@property (nonatomic, strong) NSArray * jsoncomunas;
@property (nonatomic, strong) NSArray * comunasDescription;
@property (nonatomic, strong) NSArray * countInmuebles;
@property (nonatomic, strong) NSArray * banos;
@property (nonatomic, strong) NSArray * habitaciones;
@property (nonatomic, strong) NSArray * disponibilidad;

- (IBAction)hide:(id)sender;
- (IBAction)getDesde:(id)sender;
- (IBAction)getHasta:(id)sender;
- (IBAction)closeHelpScreen:(UIButton*)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *regresarHome;
- (IBAction)regresarH:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *buscarBarButton;
- (IBAction)BuscarBarB:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationBar *barBusqueda;

- (IBAction)barBusq:(id)sender;
- (IBAction)BuscarBotButton:(id)sender;

//checkbox para amoblado y servicios

@property (strong, nonatomic) IBOutlet UICheckbox *servicios;
@property (strong, nonatomic) IBOutlet UICheckbox *amobaldo;

-(IBAction)servicios:(id)sender;

-(IBAction)amoblados:(id)sender;

@property(nonatomic, strong) NSString * parametroServicios;
@property(nonatomic, strong) NSString * parametroAmoblado;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spiningBusqueda;


@end
