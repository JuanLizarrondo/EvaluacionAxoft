unit ConexionEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DataModule;

type
  TFRM_ConexionBD = class(TForm)
    PN_Background: TPanel;
    E_Servidor: TEdit;
    E_BasedeDatos: TEdit;
    E_Usuario: TEdit;
    E_Pass: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BT_Test: TButton;
    BT_Aceptar: TButton;
    procedure BT_TestClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BT_AceptarClick(Sender: TObject);
  private
    FArchivo: TStringList;
    { Private declarations }
  public
    { Public declarations }
  end;

function startConfiguracionConexion(): boolean;



implementation

{$R *.dfm}


function startConfiguracionConexion(): boolean;
var
  FRM_ConexionBD: TFRM_ConexionBD;
begin
  Application.CreateForm(TFRM_ConexionBD, FRM_ConexionBD);
  FRM_ConexionBD.ShowModal;
  Result:= FRM_ConexionBD.ModalResult = mrOk;
end;

procedure TFRM_ConexionBD.BT_AceptarClick(Sender: TObject);
begin
  DM_DataModule.DataBase.Connected:= False;
  self.ModalResult:= mrOk;
  Self.CloseModal;
end;

procedure TFRM_ConexionBD.BT_TestClick(Sender: TObject);
var
exito:boolean;
begin
  exito:= False;

  FArchivo.Add('Server='+E_Servidor.Text);
  FArchivo.Add('Database='+E_BasedeDatos.Text);
  FArchivo.Add('User_Name='+E_Usuario.Text);
  FArchivo.Add('Password='+E_Pass.Text);
  FArchivo.Add('MetaDefSchema=dbo');
  FArchivo.Add('MetaDefCatalog='+E_BasedeDatos.Text);
  //FArchivo.Add('MonitorBy=Remote');
  FArchivo.SaveToFile(Application.GetNamePath+'Conexion.ini');


  DM_DataModule.DataBase.Params.LoadFromFile(Application.GetNamePath+'Conexion.ini');


  try
  DM_DataModule.DataBase.Connected:= True;
  exito:= True;
  ShowMessage('Conexion Exitosa');
  except
  ShowMessage('Error de Conexion');
  end;
end;

procedure TFRM_ConexionBD.FormCreate(Sender: TObject);
begin
  FArchivo:= TStringList.Create;
  if FileExists(Application.GetNamePath+'Conexion.ini') then
    begin
      FArchivo.LoadFromFile(Application.GetNamePath+'Conexion.ini');
      E_Servidor.Text:= StringReplace(FArchivo[2],'Server=' ,'',[rfReplaceAll]);
      E_BasedeDatos.Text:= StringReplace(FArchivo[3],'Database=' ,'',[rfReplaceAll]);;
      E_Usuario.Text:= StringReplace(FArchivo[4],'User_Name=' ,'',[rfReplaceAll]);;
      E_Pass.Text:= StringReplace(FArchivo[5],'Password=' ,'',[rfReplaceAll]);;
    end
  else
    begin
      FArchivo.Add('[MSSQL]');
      FArchivo.Add('DriverID=MSSQL');
    end;
end;

end.
