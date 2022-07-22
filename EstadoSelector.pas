unit EstadoSelector;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataModule, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Vcl.StdCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls,
  Vcl.ExtCtrls;

type
  TFRM_EstadoSelector = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    FDQ_Estado: TFDQuery;
    DS_Estado: TDataSource;
    BT_Aceptar: TButton;
    DBL_Estado: TDBLookupComboBox;
    procedure BT_AceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



function startEstadoSelector(var estadoKey: integer):integer;

implementation

{$R *.dfm}
function startEstadoSelector(var estadoKey: integer):integer;
var
  FRM_EstadoSelector: TFRM_EstadoSelector;
begin
  Application.CreateForm(TFRM_EstadoSelector, FRM_EstadoSelector);
  FRM_EstadoSelector.ShowModal;
  if FRM_EstadoSelector.ModalResult = mrOk then
    estadoKey:= FRM_EstadoSelector.FDQ_Estado.FieldByName('EstadoKey').AsInteger
  else
    estadoKey:= 0;
end;



procedure TFRM_EstadoSelector.BT_AceptarClick(Sender: TObject);
begin
  Self.ModalResult:= mrOk;
  Self.CloseModal;
end;

procedure TFRM_EstadoSelector.FormCreate(Sender: TObject);
begin
  DM_DataModule.actualizarQuery(FDQ_Estado);
end;

end.
