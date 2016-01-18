//
//  DetailViewController.h
//  Real Property
//
//  Created by Anibal Rodriguez on 20/01/14.
//  Copyright (c) 2014 Moviloft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "iCarousel.h"
#import <MessageUI/MessageUI.h>


@interface DetailViewController : UIViewController <MKMapViewDelegate, UITextFieldDelegate, UITextViewDelegate, iCarouselDelegate, iCarouselDataSource, MFMailComposeViewControllerDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate>
{
    
    NSArray * json;
    NSString * respuestaAmoblado;
    NSString * respuestaDispon;
    NSInteger success;
    NSString *mensaje;
    NSInteger successF;
    NSString *mensajeF;
    NSString *samanthaEsUnaLadilla;
    
    NSMutableArray * temporalFotos;
    NSArray *imagenesInm;
    NSString *idfotosCarousel;
    
    NSString * precio1v;
    NSString * precio2v;
    NSString * precio3v;
    NSString * precio4v;
    
    NSString * tipodeOpV;
    
    NSString * codigo;
    
    NSArray * HS;
    NSArray * BS;
    NSArray *logoEmpresa;
    NSString * formatoPrecioV;
    
    NSString * urlInmuebleEmail;
    UIActivityIndicatorView * spinner;
    
    
    
}
@property (strong, nonatomic) IBOutlet UILabel *etiquetaDormitorio;
@property (strong, nonatomic) IBOutlet UILabel *etiquetabanos;
@property (strong, nonatomic) IBOutlet UILabel *etiquetaEstacionamiento;

@property(nonatomic) BOOL wrap;
@property (strong, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) NSArray * json;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollDetail;

@property (strong, nonatomic) NSString * IDInmueble;

@property (strong, nonatomic) IBOutlet UILabel *etiquetaTitulo;
@property (strong, nonatomic) NSArray * detailTitulo;

@property (strong, nonatomic) IBOutlet UILabel *etiquetaPrecio;
@property (strong, nonatomic) NSArray * detailPrecio;

@property (strong, nonatomic) IBOutlet UILabel *etiquetaBanos;
@property (strong, nonatomic) NSArray * detailBanos;

@property (strong, nonatomic) IBOutlet UILabel *etiquetaHab;
@property (strong, nonatomic) NSArray * detailhab;

@property (strong, nonatomic) IBOutlet UITextView *texViewDescripcion;
@property (strong, nonatomic) NSArray * detailDescrip;

@property (strong,nonatomic) IBOutlet UILabel *labelSuperficie;
@property (strong, nonatomic) NSArray * detailSuperficie;

@property (strong,nonatomic) IBOutlet UILabel *labelSuperficieT;
@property (strong, nonatomic) NSArray * detailSuperficieT;


@property (strong, nonatomic) IBOutlet UILabel *labelUnidadSuper;
@property (strong, nonatomic) NSArray * detailSuperUnidad;

@property (strong, nonatomic) IBOutlet UILabel *labelunidadSuperT;
@property (strong, nonatomic) NSArray * detailSuperUnidadT;

@property (strong, nonatomic) IBOutlet UILabel *labelEstac;
@property (strong, nonatomic) NSArray * detailEstaci;


@property (strong, nonatomic) IBOutlet UILabel *labelRegion;
@property (strong, nonatomic) NSArray * detailRegion;


@property (strong, nonatomic) IBOutlet UILabel *labelComuna;
@property (strong, nonatomic) NSArray * detailComuna;


@property (strong, nonatomic) IBOutlet UILabel *labelDirec;
@property (strong, nonatomic) NSArray * detailDirec;


@property (strong, nonatomic) IBOutlet UILabel *labelAmobaldo;
@property (strong, nonatomic) NSArray * detailAmobaldo;

@property (strong, nonatomic) IBOutlet UILabel *labelDisponibilidad;
@property (strong, nonatomic) NSArray * detailDispo;

@property (strong, nonatomic) IBOutlet UILabel *labelEjecutivo;
@property (strong, nonatomic) NSArray * detailEjecutivo;

@property (strong, nonatomic) IBOutlet UILabel *lableTel;
@property (strong, nonatomic) NSArray * detailTel;
@property (strong, nonatomic) NSArray * detailTel2;
@property (strong, nonatomic) NSArray * detailCel;
@property (strong, nonatomic) NSArray * detailCel2;
@property (strong, nonatomic) NSString * telefonoFinal;

@property (strong, nonatomic) NSArray * detailTelM;
@property (strong, nonatomic) NSArray * detailTel2M;
@property (strong, nonatomic) NSArray * detailCelM;
@property (strong, nonatomic) NSArray * detailCel2M;
@property (strong, nonatomic) NSString * telefonoFinalM;


@property (strong, nonatomic) IBOutlet UILabel *labelEmailC;
@property (strong, nonatomic) NSArray * detailEmailC;

@property (strong, nonatomic) IBOutlet MKMapView *mapa;


@property (strong, nonatomic) IBOutlet UILabel *unidadtotal;

@property (strong, nonatomic) IBOutlet UILabel *unidadutil;


@property (strong, nonatomic) IBOutlet UIView *roundDetailDHE;


@property (strong, nonatomic) NSArray * longitud;
@property (strong, nonatomic) NSArray * latitud;

@property (strong, nonatomic) NSString * idUsuario;

@property (strong, nonatomic) IBOutlet UITextView *notaTextView;
- (IBAction)enviarNota:(id)sender;

- (IBAction)llamarContacto:(id)sender;

- (IBAction)favoritos:(id)sender;

@property (strong, nonatomic)  IBOutlet UIButton * favoritos;


@property (strong, nonatomic) IBOutlet UILabel *formatoPrecio;

@property (strong, nonatomic) IBOutlet UILabel *precio1;
@property (strong, nonatomic) IBOutlet UILabel *precio2;
@property (strong, nonatomic) IBOutlet UILabel *precio3;
@property (strong, nonatomic) IBOutlet UILabel *precio4;

@property (strong, nonatomic) IBOutlet UILabel *tipoOperacionV;


@property (strong, nonatomic) IBOutlet UINavigationItem *navItemBusq;
@property (strong, nonatomic) IBOutlet UILabel *cantidadFotos;
@property (strong, nonatomic) IBOutlet UILabel *serviciosLabel;
@property (strong, nonatomic) IBOutlet UIImageView *logoCorredora;
@property (strong, nonatomic) IBOutlet UILabel *estacInfo;
@property (strong, nonatomic) IBOutlet UIButton *goMap;
- (IBAction)goMapAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *llamarContacto;
- (IBAction)enviarEmail:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *enviarEmailPersona;
- (IBAction)enviarEmailPerAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *vistaPrincipal;
@property (strong, nonatomic) IBOutlet UIView *cercanosYserviciosView;
@property (strong, nonatomic) IBOutlet UIView *contactoView;

@end
