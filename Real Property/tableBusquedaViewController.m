//
//  tableBusquedaViewController.m
//  Real Property
//
//  Created by Anibal Rodriguez on 20/01/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import "tableBusquedaViewController.h"
#import "BusquedaViewController.h"
#import "DetailViewController.h"
#import "CustomBusquedaCells.h"
#import "AsyncImageView.h"
#import "HomeViewController.h"
#import "AppDelegate.h"

@interface tableBusquedaViewController ()

@end

@implementation tableBusquedaViewController

@synthesize recibirURl;
@synthesize helpView5;
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    _spinner.hidden = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _spinner.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
 
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setCenter:CGPointMake(320/2.0, 580/2.0)];
    [self.view addSubview:_spinner];
    NSLog(@"%f",self.tableView.bounds.size.height/2);
    //[self.view addSubview:_spinner];

    
    self.navigationController.navigationBarHidden = NO;
	// Do any additional setup after loading the view.
    //NSLog(@"%@",recibirURl);
    NSString * url = recibirURl;
    NSURL *urlStringBusqueda = [NSURL URLWithString:url];
    NSData *dataUrl = [NSData dataWithContentsOfURL:urlStringBusqueda];
    NSError *error;
    
    //connection
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:urlStringBusqueda];
    NSURLConnection *conexion = [[NSURLConnection alloc] initWithRequest:request delegate:self.tableView];
    NSLog(@"conexion en %@",conexion);
    
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if(!appDelegate.isFirstHelpViewed5){
        [helpView5 setHidden:NO];
        appDelegate.isFirstHelpViewed5 = YES;
    }else{
        [helpView5 setHidden:YES];
    }
    //end connection
    
    
    json = [NSJSONSerialization JSONObjectWithData:dataUrl options:kNilOptions error:&error];
 
    NSString *nuevoValor = [json objectAtIndex:0];;
    NSString * nuevoValorString = [nuevoValor valueForKey:@"maxpages"];
    if( [nuevoValorString integerValue] == 0 ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No se ha encontrado resultados" message:@"No hay propiedades publicadas según los parámetros de filtrado actual, intente con otros parametros" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }else{
        /* imprimir un texto en vez de la alerta
        UILabel *scoreLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(20,20, 280, 50) ];
        scoreLabel.textColor = [UIColor blackColor];
        [self.view addSubview:scoreLabel];
        scoreLabel.text = @"texto aqui";
        */

        tituloB         = [[json valueForKey:@"titulo"] objectAtIndex:1];
        precioB         = [[json valueForKey:@"precio"] objectAtIndex:1];
        habitacionesB   = [[json valueForKey:@"habitaciones"] objectAtIndex:1];
        imageList       = [[json valueForKey:@"imageList"] objectAtIndex:1];
        banosB          = [[json valueForKey:@"banos"] objectAtIndex:1];
        IDInmuebleB     = [[json valueForKey:@"inmuebleID"] objectAtIndex:1];
        direcc          = [[json valueForKey:@"direccion"] objectAtIndex:1];
        estacionamiento = [[json valueForKey:@"estacionamientos"] objectAtIndex:1];
        destacado       = [[json valueForKey:@"destacado"] objectAtIndex:1];
        tipodeoperacion = [[json valueForKey:@"tipoOperacion"] objectAtIndex:1];
        HS              = [[json valueForKey:@"habitaciones_servicio"] objectAtIndex:1];
        BS              = [[json valueForKey:@"banos_servicio"] objectAtIndex:1];
        unidadP         = [[json valueForKey:@"formatoPrecio"] objectAtIndex:1];
        
        
        //NSLog(@"hS; %@ BS: %@",HS,BS);
        
        imagenThumb = [imageList valueForKey:@"1"];
        imgThumF = [imagenThumb valueForKey:@"thumb"];
        
        
        
        
        temp     = [[NSMutableArray alloc] init];
        
        
        for (int i = 0; i < [imgThumF count]; i++) {
            //if( [Point containsObject:@""]) {
            //if (Point.count > 0) {
            NSMutableString *urlImage = [[NSMutableString alloc] initWithString:@"http://www.realproperty.cl"];
            [urlImage appendString:[imgThumF objectAtIndex:i]];
            [temp addObject:urlImage];
            //NSLog(@"no es 0");
        }
        
    }

}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response %@", response);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSMutableData *acumaladata = [[NSMutableData alloc] init];
    [acumaladata appendData:data];
    NSLog(@"data desde connection %@",acumaladata);
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [tituloB count];
   
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *simpleTableIdentifier = @"Cell";
    CustomBusquedaCells * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[CustomBusquedaCells alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }else{
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.imageView];
    }
    cell.TitleLabel.text        = [precioB          objectAtIndex:indexPath.row];
    cell.SubtitleLabel.text     = [tituloB          objectAtIndex:indexPath.row];
    cell.habitaciones.text      = [habitacionesB    objectAtIndex:indexPath.row];
    cell.banos.text             = [banosB           objectAtIndex:indexPath.row];
    cell.direccion.text         = [direcc           objectAtIndex:indexPath.row];
    cell.estacionamiento2.text  = [estacionamiento  objectAtIndex:indexPath.row];
    cell.unidadPrec.text        = [unidadP          objectAtIndex:indexPath.row];
    
    /*
    NSString    * strinTemp     = [temp objectAtIndex:indexPath.row];
    NSURL       * urlImageTemp  = [[NSURL alloc] initWithString:strinTemp];
    NSData      * dataTemp      = [NSData dataWithContentsOfURL:urlImageTemp];
    */
    
    NSString    * strinTemp     = [temp objectAtIndex:indexPath.row];
    NSURL       * urlImageTemp  = [[NSURL alloc] initWithString:strinTemp];
    
    //NSLog(@"destacado si o no %@", [destacado objectAtIndex:indexPath.row]);
    
    if ([[destacado objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
        descatadoValor = @"Destacado";
        cell.destacado2.backgroundColor = [UIColor redColor];
        
    }
    if ([[destacado objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        descatadoValor = @"";
        cell.destacado2.backgroundColor = NO;
    }
    
    if ([[tipodeoperacion objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
        tipodeoperacionCell = @"Venta";
    }
    if ([[tipodeoperacion objectAtIndex:indexPath.row] isEqualToString:@"2"]) {
        tipodeoperacionCell = @"Arriendo";
    }
    
    cell.tipodeoperacion2.text = tipodeoperacionCell;
    cell.destacado2.text = descatadoValor;
    
    if ([[HS objectAtIndex:indexPath.row] isEqualToString:@"1"] || [[BS objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
        cell.servicios.hidden = NO;
    }else {
        cell.servicios.hidden = YES;
        cell.vistaDHE.frame = CGRectMake(93, 75, 78, 20);
    }
    
    // estacionamiento ni servicios
    if ( [[estacionamiento objectAtIndex:indexPath.row] isEqualToString:@"0"] && [[HS objectAtIndex:indexPath.row] isEqualToString:@"0"] && [[BS objectAtIndex:indexPath.row] isEqualToString:@"0"]){
        cell.vistaDHE.frame = CGRectMake(93, 75, 52, 20);
    }
    
    // estacionamiento ni servicios ni baños

    if ( [[banosB objectAtIndex:indexPath.row] isEqualToString:@"0"] && [[estacionamiento objectAtIndex:indexPath.row] isEqualToString:@"0"] && [[HS objectAtIndex:indexPath.row] isEqualToString:@"0"] && [[BS objectAtIndex:indexPath.row] isEqualToString:@"0"]){
        cell.vistaDHE.frame = CGRectMake(93, 75, 37, 20);
    }
    
    //si baño es igual 0
    
    if ([[banosB objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
         cell.vistaDHE.frame = CGRectMake(93, 75, 35, 20);
    }
    
    //no hay estacionamiento pero si hay servicios
    
    if ([[estacionamiento objectAtIndex:indexPath.row] isEqualToString:@"0"]) {
        cell.vistaDHE.frame = CGRectMake(93, 75, 52, 20);
    }
    
    //si todos son vacios
    
    if (([[estacionamiento objectAtIndex:indexPath.row] isEqualToString:@"0"] && [[banosB objectAtIndex:indexPath.row] isEqualToString:@"0"] && [[habitacionesB objectAtIndex:indexPath.row] isEqualToString:@"0"] && [[HS objectAtIndex:indexPath.row] isEqualToString:@"0"]) && [[BS objectAtIndex:indexPath.row] isEqualToString:@"0"] ) {
        cell.vistaDHE.hidden = YES;
    }
    


    
    
    //cell.thumbImageView.image = [UIImage imageWithData:dataTemp];
    
    cell.thumbImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    
    cell.thumbImageView.imageURL = urlImageTemp;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //NSLog(@"imagen %@ en la posicion %i",[temp objectAtIndex:indexPath.row],indexPath.row);
   
    return cell;
}


/*
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.recibirTitulo = tituloB[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];

}

*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    _spinner.hidden = NO;
    [_spinner startAnimating];
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        DetailViewController *vc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        vc.IDInmueble = IDInmuebleB[indexPath.row];
        NSLog(@"es qui");
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%d",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)closeHelpScreen:(UIButton *)sender
{
    //[self performSegueWithIdentifier:@"goNextHelpScreen1" sender:nil];
    [helpView5 setHidden:YES];
}
@end
