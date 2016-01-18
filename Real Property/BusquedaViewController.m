//
//  BusquedaViewController.m
//  Real Property
//
//  Created by Anibal Rodriguez on 06/01/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import "BusquedaViewController.h"
#import "tableBusquedaViewController.h"
#import "UICheckbox.h"
#import "HomeViewController.h"
#import "AppDelegate.h"

@interface BusquedaViewController ()
@property (strong, nonatomic) NSMutableArray *prueba;
@property (strong, nonatomic) NSMutableArray *pruebaID;

@property (strong, nonatomic) NSMutableArray *regionMA;
@property (strong, nonatomic) NSMutableArray *regionMAID;

@property (strong, nonatomic) NSMutableArray *comunaMA;
@property (strong, nonatomic) NSMutableArray *comunaMAID;
@property (strong, nonatomic) NSMutableArray *countComunaMA;
@end

@implementation BusquedaViewController

@synthesize jsonTipo;
//@synthesize tipoDescription;
@synthesize regionesDescription;
@synthesize jsonRegiones;
@synthesize jsoncomunas;
@synthesize comunasDescription;
@synthesize banos;
@synthesize habitaciones;
@synthesize disponibilidad;
@synthesize tipoField;
@synthesize pvInmuebles;
@synthesize regionField;
@synthesize comunasField;
@synthesize habField;
@synthesize dispField;
@synthesize banoField;
@synthesize operaField;
@synthesize condField;
@synthesize HastaField;
@synthesize PVVcontainer;
@synthesize countInmuebles;
@synthesize PrecioField;
@synthesize helpView3;
//checkbox

@synthesize servicios = _servicios, amobaldo = _amobaldo;
@synthesize parametroAmoblado, parametroServicios;

//metodos para el checkbox

-(IBAction)servicios:(id)sender
{
    NSLog(@"checkbox.checked = %@", (self.servicios.checked) ? @"YES" : @"NO");
    NSLog(@"checkbox.disabled = %@", (self.servicios.disabled) ? @"YES" : @"NO");
    
    if (self.servicios.checked == TRUE) {
        parametroServicios = @"1";
        NSLog(@"%@",parametroServicios);
    }else{
        parametroServicios = @"0";
        NSLog(@" '%@' no hay valor para servicios",parametroServicios);
    }
    
}
-(IBAction)amoblados:(id)sender
{
    
    NSLog(@"checkbox.checked = %@", (self.amobaldo.checked) ? @"YES" : @"NO");
    NSLog(@"checkbox.disabled = %@", (self.amobaldo.disabled) ? @"YES" : @"NO");
    
    if (self.amobaldo.checked == TRUE) {
        parametroAmoblado = @"1";
        NSLog(@"%@",parametroAmoblado);
    }else{
        parametroAmoblado = @"0";
        NSLog(@" '%@' no hay valor para amobaldo",parametroAmoblado);
    }
    
}
//fin metodos check
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    currentTextField = textField;
    
    if (textField == DesdeField) {
        NSLog(@"epa");
    }
    if (textField == tipoField ) {
        currentArray = self.prueba;//tipoDescription;
        [pvInmuebles reloadAllComponents];
        [pvInmuebles selectRow:0 inComponent:0 animated:YES];
        [self show];
    }
    if (textField == regionField) {
        currentArray = self.regionMA; //regionesDescription;
        [pvInmuebles reloadAllComponents];
        [pvInmuebles selectRow:0 inComponent:0 animated:YES];
        [self show];
    }
    if (textField == comunasField) {
        currentArray = self.comunaMA;
        [pvInmuebles reloadAllComponents];
        [pvInmuebles selectRow:0 inComponent:0 animated:YES];
        [self show];
    }
    if (textField == habField) {
        currentArray = habitaciones;
        [pvInmuebles reloadAllComponents];
        [pvInmuebles selectRow:0 inComponent:0 animated:YES];
        [self show];
    }
    if (textField == dispField) {
        currentArray = disponibilidad;
        [pvInmuebles reloadAllComponents];
        [pvInmuebles selectRow:0 inComponent:0 animated:YES];
        [self show];
    }
    if (textField == banoField) {
        currentArray = banos;
        [pvInmuebles reloadAllComponents];
        [pvInmuebles selectRow:0 inComponent:0 animated:YES];
        [self show];
    }
    if (textField == operaField) {
        currentArray = operaciones;
        [pvInmuebles reloadAllComponents];
        [pvInmuebles selectRow:0 inComponent:0 animated:YES];
        [self show];
    }
    if (textField == condField) {
        currentArray = condiciones;
        [pvInmuebles reloadAllComponents];
        [pvInmuebles selectRow:0 inComponent:0 animated:YES];
        [self show];
    }
    if(textField == PrecioField){
        currentArray = monedaValor;
        [pvInmuebles reloadAllComponents];
        [pvInmuebles selectRow:0 inComponent:0 animated:YES];
        [self show];
    }
    return NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [HastaField resignFirstResponder];
    [DesdeField resignFirstResponder];
    [_volumenHasta resignFirstResponder];
    [_volumenDes resignFirstResponder];
    [_superHasta resignFirstResponder];
    [_superDesde resignFirstResponder];
    
   
    PVVcontainer.frame = CGRectMake(0, 700, 320, 232);
}

// fin de la edicion del texto



// Pickerview

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return[currentArray count];
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (currentTextField == comunasField) {
        return [currentArray objectAtIndex:row];
    }else{
        return [currentArray objectAtIndex:row];
    }
    return [currentArray objectAtIndex:row];
    
}



// valores de los Picker e IDS para las Busquedas

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    if (currentTextField == tipoField) {
        //[currentTextField setText:[currentArray objectAtIndex:row]];
        currentTextField.text = [currentArray objectAtIndex:row];
        TipoID =  [self.pruebaID objectAtIndex:row]; // Arreglo con inicial en Mayuscula Arreglo final con Minuscula inicial
        NSLog(@"el id de el tipo de inmuble es: %@",TipoID);
        if(row==0){
            currentTextField.text = @"";
        }
        
        // casa
        if ([TipoID isEqualToString:@"1"]) {
            habField.hidden = NO;
            habField.frame = CGRectMake(20, 320, 280, 30);
            
            banoField.hidden = NO;
            banoField.frame = CGRectMake(20, 360, 280, 30);
            
            _superDesde.hidden = NO;
            _superDesde.frame = CGRectMake(20, 400, 135, 30);
            
            _superHasta.hidden = NO;
            _superHasta.frame = CGRectMake(165, 400, 135, 30);
            
            _volumenDes.hidden = YES;
            _volumenDes.frame = CGRectMake(20, 440, 135, 30);
            
            _volumenHasta.hidden = YES;
            _volumenHasta.frame = CGRectMake(165, 440, 135, 30);
            
            self.servicios.hidden = NO;
            self.servicios.frame = CGRectMake(20, 440, 30, 30);
            
            self.amobaldo.hidden = NO;
            self.amobaldo.frame = CGRectMake(165, 440, 30, 30);
            

        }
        
        //departamento y temporada
        if ([TipoID isEqualToString:@"2"] || [TipoID isEqualToString:@"13"]) {
            habField.hidden = NO;
            habField.frame = CGRectMake(20, 320, 280, 30);
            
            banoField.hidden = NO;
            banoField.frame = CGRectMake(20, 360, 280, 30);
            
            _superDesde.hidden = NO;
            _superDesde.frame = CGRectMake(20, 400, 135, 30);
            
            _superHasta.hidden = NO;
            _superHasta.frame = CGRectMake(165, 400, 135, 30);
            
            _volumenDes.hidden = YES;
            _volumenDes.frame = CGRectMake(20, 440, 135, 30);
            
            _volumenHasta.hidden = YES;
            _volumenHasta.frame = CGRectMake(165, 440, 135, 30);
            
            self.servicios.hidden = NO;
            self.servicios.frame = CGRectMake(20, 440, 30, 30);
            
            self.amobaldo.hidden = NO;
            self.amobaldo.frame = CGRectMake(165, 440, 30, 30);
            
        }
        //local comercial y oficina
        if ([TipoID isEqualToString:@"16"] || [TipoID isEqualToString:@"22"]) {
            habField.hidden = YES;
            habField.frame = CGRectMake(20, 320, 280, 30);
            
            banoField.hidden = NO;
            banoField.frame = CGRectMake(20, 320, 280, 30);
            
            _superDesde.hidden = NO;
            _superDesde.frame = CGRectMake(20, 360, 135, 30);
            
            _superHasta.hidden = NO;
            _superHasta.frame = CGRectMake(165, 360, 135, 30);
            
            _volumenDes.hidden = YES;
            _volumenDes.frame = CGRectMake(20, 440, 135, 30);
            
            _volumenHasta.hidden = YES;
            _volumenHasta.frame = CGRectMake(165, 440, 135, 30);
            
            self.servicios.hidden = YES;
            self.servicios.frame = CGRectMake(20, 440, 30, 30);
            
            self.amobaldo.hidden = NO;
            self.amobaldo.frame = CGRectMake(20, 400, 30, 30);
        }
        //estacionamiento e industria
        if ([TipoID isEqualToString:@"21"] || [TipoID isEqualToString:@"31"]) {
            habField.hidden = YES;
            habField.frame = CGRectMake(20, 320, 280, 30);
            
            banoField.hidden = YES;
            banoField.frame = CGRectMake(20, 320, 280, 30);
            
            _superDesde.hidden = NO;
            _superDesde.frame = CGRectMake(20, 320, 135, 30);
            
            _superHasta.hidden = NO;
            _superHasta.frame = CGRectMake(165, 320, 135, 30);
            
            _volumenDes.hidden = YES;
            _volumenDes.frame = CGRectMake(20, 440, 135, 30);
            
            _volumenHasta.hidden = YES;
            _volumenHasta.frame = CGRectMake(165, 440, 135, 30);
            
            self.servicios.hidden = YES;
            self.servicios.frame = CGRectMake(20, 440, 30, 30);
            
            self.amobaldo.hidden = YES;
            self.amobaldo.frame = CGRectMake(20, 400, 30, 30);
        }
        //Arriendo Diario casa, dpto, casa comercial, casa oficina
        if ([TipoID isEqualToString:@"29"] || [TipoID isEqualToString:@"28"] || [TipoID isEqualToString:@"26"] || [TipoID isEqualToString:@"24"]) {
            habField.hidden = NO;
            habField.frame = CGRectMake(20, 320, 280, 30);
            
            banoField.hidden = NO;
            banoField.frame = CGRectMake(20, 360, 280, 30);
            
            _superDesde.hidden = YES;
            _superDesde.frame = CGRectMake(20, 400, 135, 30);
            
            _superHasta.hidden = YES;
            _superHasta.frame = CGRectMake(165, 400, 135, 30);
            
            _volumenDes.hidden = YES;
            _volumenDes.frame = CGRectMake(20, 440, 135, 30);
            
            _volumenHasta.hidden = YES;
            _volumenHasta.frame = CGRectMake(165, 440, 135, 30);
            
            self.servicios.hidden = NO;
            self.servicios.frame = CGRectMake(20, 400, 30, 30);
            
            self.amobaldo.hidden = NO;
            self.amobaldo.frame = CGRectMake(165, 400, 30, 30);
        }
        //parcela, loteo, agricola y parcela, terreno, terreno de construccion
        if ([TipoID isEqualToString:@"30"] || [TipoID isEqualToString:@"23"] || [TipoID isEqualToString:@"18"] || [TipoID isEqualToString:@"17"] || [TipoID isEqualToString:@"8"] || [TipoID isEqualToString:@"5"] || [TipoID isEqualToString:@"7"]) {
            habField.hidden = YES;
            habField.frame = CGRectMake(20, 320, 280, 30);
            
            banoField.hidden =YES;
            banoField.frame = CGRectMake(20, 360, 280, 30);
            
            _superDesde.hidden = NO;
            _superDesde.frame = CGRectMake(20, 320, 135, 30);
            
            _superHasta.hidden = NO;
            _superHasta.frame = CGRectMake(165, 320, 135, 30);
            
            _volumenDes.hidden = YES;
            _volumenDes.frame = CGRectMake(20, 440, 135, 30);
            
            _volumenHasta.hidden = YES;
            _volumenHasta.frame = CGRectMake(165, 440, 135, 30);
            
            self.servicios.hidden = YES;
            self.amobaldo.hidden = YES;
        }
        //bodega
        if ([TipoID isEqualToString:@"3"]) {
            habField.hidden = YES;
            habField.frame = CGRectMake(20, 320, 280, 30);
            
            banoField.hidden = YES;
            banoField.frame = CGRectMake(20, 320, 280, 30);
            
            _superDesde.hidden = YES;
            _superDesde.frame = CGRectMake(20, 360, 135, 30);
            
            _superHasta.hidden = YES;
            _superHasta.frame = CGRectMake(165, 360, 135, 30);
            
            _volumenDes.hidden = NO;
            _volumenDes.frame = CGRectMake(20, 320, 135, 30);
            
            _volumenHasta.hidden = NO;
            _volumenHasta.frame = CGRectMake(165, 320, 135, 30);

            self.servicios.hidden = YES;
            self.servicios.frame = CGRectMake(20, 400, 30, 30);
            
            self.amobaldo.hidden = NO;
            self.amobaldo.frame = CGRectMake(20, 360, 30, 30);
        }
        regionField.placeholder = @"Región - Seleccione Operación y Condición";
    }
    if(currentTextField == regionField){
        [currentTextField setText:[currentArray objectAtIndex:row]];
        RegionesID = [self.regionMAID objectAtIndex:row];
        NSLog(@"el id de la Region seleciona es: %@",RegionesID);
        
        _spiningBusqueda.hidden = NO;
        [_spiningBusqueda startAnimating];
        // Data para Comunas
        NSMutableString *urlStringComunas = [[NSMutableString alloc] initWithString:@"http://www.realproperty.cl/mobilData.php?functName=getComunasByRegionWithCounts&regionID="];
        if (RegionesID == NULL) {
            RegionesID = @"0";
        }
        [urlStringComunas appendString:RegionesID];
        if (tipoField.text) {
            [urlStringComunas appendString:@"&tipoSearchID="];
            [urlStringComunas appendString:TipoID];
        }
        if (condField.text) {
            [urlStringComunas appendString:@"&condicion="];
            [urlStringComunas appendString:CondID];
        }
        if (operaField.text) {
            [urlStringComunas appendString:@"&operacion="];
            [urlStringComunas appendString:OperaID];
        }
        NSLog(@"comuna completa%@",urlStringComunas);
        NSURL * urlComunas = [NSURL URLWithString:urlStringComunas];
        NSData *dataComunas = [NSData dataWithContentsOfURL:urlComunas];
        NSError * errorC;
        //conexion get comunas
        
        NSURLRequest * requestComuna = [[NSURLRequest alloc] initWithURL:urlComunas];
        NSURLConnection * conexionComuna = [[NSURLConnection alloc] initWithRequest:requestComuna delegate:self];
        NSLog(@"%@",conexionComuna);
        
        //fin conexion get comunas
        self.jsoncomunas = [NSJSONSerialization JSONObjectWithData:dataComunas options:kNilOptions error:&errorC];
        comunasDescription = [jsoncomunas valueForKeyPath:@"description"];
        countInmuebles = [jsoncomunas valueForKey:@"countInmuebles"];
        comunaID = [jsoncomunas valueForKey:@"comunaID"];
        
        self.comunaMA = [[NSMutableArray alloc] initWithObjects:@"Selecione una opción", nil];
        [self.comunaMA addObjectsFromArray:comunasDescription];
        NSLog(@"arreglo con append para comunas%@",self.comunaMA);
        
        self.comunaMAID = [[NSMutableArray alloc] initWithObjects:@"0", nil];
        [self.comunaMAID addObjectsFromArray:comunaID];
        NSLog(@"arreglo con append id para comunas%@",self.comunaMAID);
        
        self.countComunaMA = [[NSMutableArray alloc] initWithObjects:@"0", nil];
        [self.countComunaMA addObjectsFromArray:countInmuebles];
        NSLog(@"arreglo con append id para comunas%@",self.countComunaMA);
        NSLog(@"comuna count: %i", comunasDescription.count);
        if ([comunasDescription count]) {
            [comunasField setText:@""];
        }else{
            [comunasField setText:@"No hay Inmuebles"];
        }
        if(row==0){
            currentTextField.text = @"";
        }
        comunasField.enabled = YES;
        comunasField.placeholder = @"Comuna";
    }

    if (currentTextField == comunasField) {
        
        StringComplete = [[NSMutableArray alloc] init];
        [StringComplete addObjectsFromArray:currentArray];
        [StringComplete addObjectsFromArray:self.countComunaMA];
        //NSLog(@"%@",StringComplete);
        
        NSMutableString * algo = [[NSMutableString alloc] init];
        [algo appendString:[StringComplete objectAtIndex:row]];
        [algo appendString:@" - "];
        [algo appendString:[StringComplete objectAtIndex:[currentArray count]+row]];
        //NSLog(@"algo: %@",algo);
        
        [currentTextField setText:algo];
        
        //valor del ID Comuna
        ComunaID = [self.comunaMAID objectAtIndex:row];
        CountInmM = [self.countComunaMA objectAtIndex:row];
        NSLog(@"el id del Comuna seleciona es: %@",ComunaID);
        NSLog(@"cantidad de inmuebles: %@",CountInmM);
        
    }
    
    if (currentTextField == operaField) {
        [currentTextField setText:[currentArray objectAtIndex:row]];
        OperaID = [operaID objectAtIndex:row];
        if(row==0){
            currentTextField.text = @"";
        }
        NSLog(@"%@",OperaID);
        if (![condField.text isEqualToString:@""]) {
            NSLog(@"es diferente de 0 - activa region");
            regionField.enabled = YES;
            regionField.placeholder = @"Región";
        }

    }
    if (currentTextField == condField) {
        [currentTextField setText:[currentArray objectAtIndex:row]];
        CondID = [condID objectAtIndex:row];
        if(row==0){
            currentTextField.text = @"";
        }
        NSLog(@"%@",CondID);
        if (![operaField.text isEqualToString:@""]) {
            NSLog(@"es diferente de 0 - activa region");
            regionField.enabled = YES;
            regionField.placeholder = @"Región";
        }
        
    }

    if (currentTextField == habField) {
        [currentTextField setText:[currentArray objectAtIndex:row]];
        HabID = [habID objectAtIndex:row];
        if(row==0){
            currentTextField.text = @"";
        }
        NSLog(@"%@",HabID);
    }
    if (currentTextField == banoField) {
        [currentTextField setText:[currentArray objectAtIndex:row]];
        BanosID = [banosID objectAtIndex:row];
        if(row==0){
            currentTextField.text = @"";
        }
        NSLog(@"%@",BanosID);
    }
    if (currentTextField == dispField) {
        [currentTextField setText:[currentArray objectAtIndex:row]];
        DispID = [dispID objectAtIndex:row];
        if(row==0){
            currentTextField.text = @"";
        }
        NSLog(@"%@",DispID);
    }
    if (currentTextField == PrecioField) {
        [currentTextField setText:[currentArray objectAtIndex:row]];
        monedaID = [moneda objectAtIndex:row];
        NSLog(@"%@",monedaID);
    }
    
}

- (IBAction)getDesde:(id)sender{
    desdeV = DesdeField.text;
    NSLog(@"%@",desdeV);
    
}

- (IBAction)getHasta:(id)sender{
    hastaV = HastaField.text;
    NSLog(@"%@",hastaV);
    
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _spiningBusqueda.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //done and cancel en el number pad
    
    numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Listo" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    DesdeField.inputAccessoryView = numberToolbar;
    HastaField.inputAccessoryView = numberToolbar;
    _volumenHasta.inputAccessoryView = numberToolbar;
    _volumenDes.inputAccessoryView = numberToolbar;
    _superHasta.inputAccessoryView = numberToolbar;
    _superDesde.inputAccessoryView = numberToolbar;
    
    comunasField.enabled = NO;
    comunasField.placeholder = @"Comuna - Seleccione Región";
    regionField.enabled = NO;
    regionField.placeholder = @"Región - Seleccione Tipo de Inmueble";
    _spiningBusqueda.hidden = YES;
    // oculta campos
    banoField.hidden     = YES;
    habField.hidden      = YES;
    _superDesde.hidden   = YES;
    _superHasta.hidden   = YES;
    _volumenDes.hidden   = YES;
    _volumenHasta.hidden = YES;
    self.servicios.hidden = YES;
    self.amobaldo.hidden = YES;
    

    
 //   [_superDesde setUserInteractionEnabled:YES];
    
    self.servicios.checked = FALSE;
    self.servicios.disabled = FALSE;
    self.servicios.text = @"Servicios";
    
    self.amobaldo.checked = FALSE;
    self.amobaldo.disabled = FALSE;
    self.amobaldo.text = @"Amoblado";
    
    parametroServicios = @"0";
    parametroAmoblado = @"0";
    //fin oculta campos
    

    StringComplete = [[NSMutableArray alloc] init];
    self.navigationController.navigationBarHidden = NO;
    _barBusqueda.hidden = YES;
    
    //Data para Tipo de inmueble
    NSString *urlStringTipo = [NSString stringWithFormat:@"http://www.realproperty.cl/mobilData.php?functName=getTipoInmueble"];
    NSURL *urlTipo = [NSURL URLWithString:urlStringTipo];
    NSData *dataTipo = [NSData dataWithContentsOfURL:urlTipo];
    NSError *error;
    //conecion get tipo de inmueble
    
    NSURLRequest * requestTipo = [[NSURLRequest alloc] initWithURL:urlTipo];
    NSURLConnection * conexionTipo = [[NSURLConnection alloc] initWithRequest:requestTipo delegate:self];
    NSLog(@"%@",conexionTipo);
    
    //fin de get tipo de inmueble
    self.jsonTipo = [NSJSONSerialization JSONObjectWithData:dataTipo options:kNilOptions error:&error];
    tipoDescription = [jsonTipo valueForKey:@"description"];
    tipoID = [jsonTipo valueForKey:@"tipoID"] ;
    
    
    self.prueba = [[NSMutableArray alloc] initWithObjects:@"Selecione una opción", nil];
    [self.prueba addObjectsFromArray:tipoDescription];
    NSLog(@"arreglo con append%@",self.prueba);
    
    self.pruebaID = [[NSMutableArray alloc] initWithObjects:@"0", nil];
    [self.pruebaID addObjectsFromArray:tipoID];
    NSLog(@"arreglo con append id%@",self.pruebaID);
    
    //Data para Regiones
    
    NSString *urlStringRegiones = [NSString stringWithFormat:@"http://www.realproperty.cl/mobilData.php?functName=getRegiones"];
    NSURL *urlRegiones = [NSURL URLWithString:urlStringRegiones];
    NSData *dataRegiones = [NSData dataWithContentsOfURL:urlRegiones];
    NSError *errorR;
    //conexion get regiones
    
    NSURLRequest * requestRegiones = [[NSURLRequest alloc] initWithURL:urlRegiones];
    NSURLConnection * conexionRegiones = [[NSURLConnection alloc] initWithRequest:requestRegiones delegate:self];
    NSLog(@"%@",conexionRegiones);
    
    //fin de conexion get regiones
    
    self.jsonRegiones = [NSJSONSerialization JSONObjectWithData:dataRegiones options:kNilOptions error:&errorR];
    self.regionesDescription = [jsonRegiones valueForKey:@"description"];
    regionesID = [jsonRegiones valueForKey:@"regionID"];
    
    self.regionMA = [[NSMutableArray alloc] initWithObjects:@"Selecione una opción", nil];
    [self.regionMA addObjectsFromArray:regionesDescription];
    NSLog(@"arreglo con append%@",self.regionMA);
    
    self.regionMAID = [[NSMutableArray alloc] initWithObjects:@"0", nil];
    [self.regionMAID addObjectsFromArray:regionesID];
    NSLog(@"arreglo con append id%@",self.regionMAID);
    

    // Moneda
    moneda = [[NSArray alloc] initWithObjects:@"PE",@"UF",@"USD",@"EU", nil];
    monedaValor = [[NSArray alloc] initWithObjects:@"$",@"UF",@"USD",@"EUR", nil];
    

    //data habitaciones
    
    habitaciones = [[NSArray alloc] initWithObjects:@"Selecione una opción",@"Indiferete",@"1",@"2",@"3",@"4",@"5 ó más", nil];
    habID = [[NSArray alloc] initWithObjects:@"0",@"0",@"1",@"2",@"3",@"4",@"5", nil];
    
    //data baños
    banos = [[NSArray alloc] initWithObjects:@"Selecione una opción",@"Indiferete",@"1",@"2",@"3",@"4",@"5", nil];
    banosID = [[NSArray alloc] initWithObjects:@"0",@"0",@"1",@"2",@"3",@"4",@"5", nil];
    
    //data disponibilidad
    disponibilidad = [[NSArray alloc] initWithObjects:@"Selecione una opción",@"Indifernete",@"Inmediata",@"1 semana",@"2 semana",@"3 semana",@"1 mes o menos",@"1 mes a 3 meses", @"3 meses a 6 meses", @"menos de 1 año", @"mas de 1 año", nil];
    dispID = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    
    //data operaciones
    operaciones = [[NSArray alloc] initWithObjects:@"Selecione una opción",@"Venta",@"Arriendo", nil];
    operaID = [[NSArray alloc] initWithObjects:@"0",@"1",@"2", nil];
    
    //data condiciones
    condiciones = [[NSArray alloc] initWithObjects:@"Selecione una opción",@"Nuevo",@"Usado",@"Proyecto", nil];
    condID = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3", nil];
    
    
    PVVcontainer.frame = CGRectMake(0, 700, 320, 232);
    

    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if(!appDelegate.isFirstHelpViewed3){
        [helpView3 setHidden:NO];
        appDelegate.isFirstHelpViewed3 = YES;
    }else{
        [helpView3 setHidden:YES];
    }
}

//metodos para boton done y cancel en number pad

-(void)doneWithNumberPad{
    [DesdeField resignFirstResponder];
    [HastaField resignFirstResponder];
    [_volumenDes resignFirstResponder];
    [_volumenHasta resignFirstResponder];
    [_superDesde resignFirstResponder];
    [_superHasta resignFirstResponder];
}

// bsuqueda desde el boton

- (IBAction)barBusq:(id)sender {
    _spiningBusqueda.hidden = NO;
    [_spiningBusqueda startAnimating];
    [DesdeField resignFirstResponder];
    [HastaField resignFirstResponder];
    [_superDesde resignFirstResponder];
    [_superHasta resignFirstResponder];
    [_volumenDes resignFirstResponder];
    [_volumenHasta resignFirstResponder];
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
}

- (IBAction)BuscarBotButton:(id)sender {
    _spiningBusqueda.hidden = NO;
    [_spiningBusqueda startAnimating];
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
}
-(void)threadStartAnimating:(id)data{


    if([[tipoField text] isEqualToString:@""] || [[operaField text] isEqualToString:@""] || [[condField text] isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Busquéda incompleta."
                                                            message:@"Tipo de Inmueble, Condición y Operación son obligatorios."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        _spiningBusqueda.hidden = YES;
    }else{

        urlString = [[NSMutableString alloc] initWithString:@"https://www.realproperty.cl/mobilData.php?functName=getInmuebles&limit="];
        if (CountInmM) {
            [urlString appendString:CountInmM];
        }else{
            [urlString appendString:@"9999"];
        }
        if (TipoID) {
            [urlString appendString:@"&tipoSearchID="];
            [urlString appendString:TipoID];
        }
        if (RegionesID) {
            [urlString appendString:@"&regionID="];
            [urlString appendString:RegionesID];
        }
        if (ComunaID) {
            [urlString appendString:@"&comunaID="];
            [urlString appendString:ComunaID];
        }
        if (OperaID) {
            [urlString appendString:@"&operacion="];
            [urlString appendString:OperaID];
        }
        if (CondID) {
            [urlString appendString:@"&condicion="];
            [urlString appendString:CondID];
        }
        if (HabID) {
            [urlString appendString:@"&habitaciones="];
            [urlString appendString:HabID];
        }
        if (BanosID) {
            [urlString appendString:@"&banos="];
            [urlString appendString:BanosID];
        }
        if (DispID) {
            [urlString appendString:@"&disponibilidad="];
            [urlString appendString:DispID];
        }
        if (monedaID) {
            [urlString appendString:@"&formatoPrecio="];
            [urlString appendString:monedaID];
        }
        if(DesdeField){
            [urlString appendString:@"&precioDesde="];
            [urlString appendString:DesdeField.text];
        }
        if (HastaField) {
            [urlString appendString:@"&precioHasta="];
            [urlString appendString:HastaField.text];
        }
        if (_superDesde) {
            [urlString appendString:@"&superficieDesde="];
            [urlString appendString:_superDesde.text];
        }
        if (_superHasta) {
            [urlString appendString:@"&superficieHasta="];
            [urlString appendString:_superHasta.text];
        }
        if (self.servicios) {
            [urlString appendString:@"&habitaciones_servicio="];
            [urlString appendString:parametroServicios];
        }
        if (self.amobaldo) {
            [urlString appendString:@"&amoblado="];
            [urlString appendString:parametroAmoblado];
        }
        if (_volumenDes){
            [urlString appendString:@"&volumenDesde="];
            [urlString appendString:_volumenDes.text];
        }
        if (_volumenHasta) {
            [urlString appendString:@"&volumenHasta="];
            [urlString appendString:_volumenHasta.text];
        }
        [urlString appendString:@"&order=precio%20asc"];
        NSLog(@"%@",urlString);
        tableBusquedaViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"tabla2"];
        [self.navigationController pushViewController:vc animated:YES];
        vc.recibirURl = urlString;
    }

}

//buscar desde el button bar

- (IBAction)BuscarBarB:(id)sender {
    // aqui va el codigo de la barra manual
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error de la conexion %@",error);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
   // NSLog(@"didReciveData");
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    _spiningBusqueda.hidden = NO;
    [_spiningBusqueda startAnimating];
    NSLog(@"se muestra el spining");
}
-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    _spiningBusqueda.hidden = YES;
    [_spiningBusqueda stopAnimating];
    NSLog(@"se oculto el spning");
    
}
//metodos de conexion



//fin metodos de conexion
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hide:(id)sender {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    PVVcontainer.frame = CGRectMake(0, 900, 320, 206);
    [UIView commitAnimations];
}
-(void)show{
    [UIView beginAnimations:Nil context:NULL];
    [UIView setAnimationDuration:0.3];
    PVVcontainer.frame = CGRectMake(0, 220, 320, 206);
    [UIView commitAnimations];
}
- (IBAction)regresarH:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)closeHelpScreen:(UIButton*)sender
{
    [helpView3 setHidden:YES];
}
@end
