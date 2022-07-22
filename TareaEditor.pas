unit TareaEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.WinXCalendars, Vcl.ExtCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataModule;

type
  TFRM_TareaEditor = class(TForm)
    PN_Background: TPanel;
    E_NombreTarea: TEdit;
    CP_FechaVencimiento: TCalendarPicker;
    Label1: TLabel;
    Label2: TLabel;
    BT_Aceptar: TButton;
    Label3: TLabel;
    Button2: TButton;
    FDQ_Estado: TFDQuery;
    DS_Estado: TDataSource;
    DBL_Estado: TDBLookupComboBox;
    procedure BT_AceptarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure E_NombreTareaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FTareaKey: Integer;
    procedure inicializar(tareaKey: Integer = 0);
    function verificarNombre(nombre: String): boolean;
    function verificarFecha():boolean;
  public
    { Public declarations }
  end;



function startTareasEditor(tareaKey: Integer = 0): Boolean;

implementation

{$R *.dfm}

function startTareasEditor(tareaKey: Integer = 0): Boolean;
var
  FRM_TareaEditor: TFRM_TareaEditor;
begin
  Application.CreateForm(TFRM_TareaEditor, FRM_TareaEditor);
  FRM_TareaEditor.inicializar(tareaKey);
  FRM_TareaEditor.ShowModal;
end;

{ TFRM_TareaEditor }

procedure TFRM_TareaEditor.BT_AceptarClick(Sender: TObject);
var
exito: boolean;
fdq: TFDQuery;
aux: TComponentState;
begin
  exito:= False;
  fdq:= DM_DataModule.crearQuery;

  //Verificamos el Nombre
  if not verificarNombre(E_NombreTarea.Text) then
    begin
    ShowMessage('El mensaje Contiene Caracteres invalidos o su longitud no es correcta (de 3 a 100 caracteres)');
    Exit
    end;

    //Verificamos la Fecha
  if not CP_FechaVencimiento.IsEmpty then
    begin
    if not verificarFecha then
      begin
      ShowMessage('La Fecha no puede ser un fin de semana o ser superior a 30 desde hoy');
      Exit
      end;
    end;


  if FTareaKey = 0 then
    begin

      fdq.SQL.Clear;
      fdq.SQL.Add('Insert into Tarea(Nombre, FechaCreacion, FechaVencimiento, EstadoKey, Activa)');
      fdq.SQL.Add('values(:nombre, :fechaAct, :fechaVenc, :estadoKey, :activa)');
      fdq.ParamByName('nombre').AsString:= E_NombreTarea.Text;
      fdq.ParamByName('fechaAct').AsDateTime:= DM_DataModule.getDate;
      //Definimos si se inserta nulo o una fecha en Fecha Vencimiento
      if CP_FechaVencimiento.IsEmpty then
        fdq.SQL.Text:= StringReplace(fdq.SQL.Text,':fechaVenc','null',[rfReplaceAll])
      else
        fdq.ParamByName('fechaVenc').AsDateTime:= CP_FechaVencimiento.Date;

      fdq.ParamByName('estadoKey').AsInteger:= 1;
      fdq.ParamByName('activa').AsInteger:= 1;
    end
  else
    begin
    fdq.SQL.Clear;
    fdq.SQL.Add('Update Tarea');
    fdq.SQL.Add('set Nombre = :nombre, EstadoKey = :estadoKey, FechaVencimiento = :fechaVen');
    fdq.SQL.Add('where TareaKey = :tareaKey');
    fdq.ParamByName('tareaKey').AsInteger:= FTareaKey;
    fdq.ParamByName('nombre').AsString:= E_NombreTarea.Text;
    fdq.ParamByName('estadoKey').AsInteger:= FDQ_Estado.FieldByName('EstadoKey').AsInteger;

    //Definimos si se inserta nulo o una fecha en Fecha Vencimiento
    if CP_FechaVencimiento.IsEmpty then
        fdq.SQL.Text:= StringReplace(fdq.SQL.Text,':fechaVen','null',[rfReplaceAll])
      else
        fdq.ParamByName('fechaVen').AsDateTime:= CP_FechaVencimiento.Date;
    end;

    try
    fdq.ExecSQL;
    exito:= True;
    finally
    fdq.Free;
    end;

    if not exito then
      ShowMessage('Error al insertar la Tarea');

  Self.Close;
end;

procedure TFRM_TareaEditor.Button2Click(Sender: TObject);
begin
Self.Close;
end;

procedure TFRM_TareaEditor.E_NombreTareaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not ( StrScan('0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM$#%&()[]'+chr(7)+chr(8), Key) = nil ) then
    begin
    //
    end
  else
    begin
    ShowMessage('Caracter '+Key+' No es un caracter valido');
    Key := #0;
    end;
end;

procedure TFRM_TareaEditor.inicializar(tareaKey: Integer);
var
fdq: TFDQuery;
begin
  DM_DataModule.actualizarQuery(FDQ_Estado);
  FTareaKey:= tareaKey;
  if FTareaKey <> 0 then
    begin
    //cargamos la tarea que queremos editar
    fdq:= DM_DataModule.crearQuery;
    fdq.SQL.Add('Select * from Tarea');
    fdq.SQL.Add('where TareaKey = :tareaKey');
    fdq.ParamByName('tareaKey').AsInteger:= FTareaKey;
    DM_DataModule.actualizarQuery(fdq);

    E_NombreTarea.Text:= fdq.FieldByName('Nombre').AsString;
    DBL_Estado.KeyValue := fdq.FieldByName('EstadoKey').AsInteger;
    DBL_Estado.Repaint;
    //controlamos que no sea nula la fecha
    if not fdq.FieldByName('FechaVencimiento').IsNull then
      CP_FechaVencimiento.Date:= fdq.FieldByName('FechaVencimiento').AsDateTime;

    fdq.Free;
    end
  else
    begin
    DBL_Estado.KeyValue:= 1;
    DBL_Estado.ReadOnly:= True;
    end;
end;

function TFRM_TareaEditor.verificarFecha: boolean;
var
aux: Integer;
res: boolean;
begin
  res:= False;
  if (1 < DayOfWeek(CP_FechaVencimiento.Date)) and (DayOfWeek(CP_FechaVencimiento.Date) < 7) then
    begin
    if ((DM_DataModule.getDate + 30 ) > CP_FechaVencimiento.Date )then
      res:= True
    end;

  Result:= res;
end;

function TFRM_TareaEditor.verificarNombre(nombre: String): boolean;
var
exito:boolean;
begin
  exito:= False;
  if nombre.Length >= 3 then
    begin
    if UpperCase(nombre) <> nombre then
      begin
        exito:= True;
      end;
    end;
  Result:= exito;
end;

end.
