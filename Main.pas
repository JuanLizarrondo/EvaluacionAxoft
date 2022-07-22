unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.CategoryButtons,
  Vcl.WinXCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, System.Actions, Vcl.ActnList,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, DataModule, TareaEditor,
  System.ImageList, Vcl.ImgList, EstadoSelector, ConexionEditor;

type
  TFRM_Main = class(TForm)
    PN_Main: TPanel;
    MainMenu: TMainMenu;
    NuevaTarea1: TMenuItem;
    Editar1: TMenuItem;
    Eliminar1: TMenuItem;
    DBG_Tareas: TDBGrid;
    SV_Menu: TSplitView;
    CategoryButtons1: TCategoryButtons;
    MarcarLeida1: TMenuItem;
    PopupMenu: TPopupMenu;
    Eliminar2: TMenuItem;
    Editar2: TMenuItem;
    MarcarCompletada1: TMenuItem;
    FDQ_Tareas: TFDQuery;
    DS_Tareas: TDataSource;
    ActionList1: TActionList;
    AC_NuevaTarea: TAction;
    AC_Eliminar: TAction;
    AC_Editar: TAction;
    AC_MarcarCompletada: TAction;
    AC_ConfigurarConexion: TAction;
    AC_FiltroEstado: TAction;
    PN_Top: TPanel;
    IM_MenuButton: TImage;
    Panel1: TPanel;
    AC_TareasPendientes: TAction;
    procedure FormCreate(Sender: TObject);
    procedure AC_NuevaTareaExecute(Sender: TObject);
    procedure IM_MenuButtonClick(Sender: TObject);
    procedure AC_EditarExecute(Sender: TObject);
    procedure AC_EliminarExecute(Sender: TObject);
    procedure AC_TareasPendientesExecute(Sender: TObject);
    procedure AC_MarcarCompletadaExecute(Sender: TObject);
    procedure AC_FiltroEstadoExecute(Sender: TObject);
    procedure AC_ConfigurarConexionExecute(Sender: TObject);
  private
    { Private declarations }
    procedure inicializar;
  public
    { Public declarations }
  end;
const
  ESTADO_ACTIVA = 1;
  ESTADO_COMPLETADA = 2;
  ESTADO_DIFERIDA = 3;

var
  FRM_Main: TFRM_Main;

implementation

{$R *.dfm}

{ TFRM_Main }

procedure TFRM_Main.AC_ConfigurarConexionExecute(Sender: TObject);
begin
  if startConfiguracionConexion then
    DM_DataModule.DataBase.Connected:= True
  else
    ShowMessage('Error. No se conecto a la Base de Datos');
end;

procedure TFRM_Main.AC_EditarExecute(Sender: TObject);
begin
  if FDQ_Tareas.FieldByName('FechaCompletada').IsNull then
    startTareasEditor(FDQ_Tareas.FieldByName('TareaKey').AsInteger)
  else
    ShowMessage('No se puede Editar una Tarea ya Completada');

  DM_DataModule.actualizarQuery(FDQ_Tareas);
end;

procedure TFRM_Main.AC_EliminarExecute(Sender: TObject);
var
fdq: TFDQuery;
begin
  fdq:= DM_DataModule.crearQuery;
  fdq.SQL.Add('Update Tarea set Activa = 0 where TareaKey = :tareaKey');
  fdq.ParamByName('tareakey').AsInteger:= FDQ_Tareas.FieldByName('TareaKey').AsInteger;
  try
  fdq.ExecSQL;
  finally
  fdq.Free;
  end;
  DM_DataModule.actualizarQuery(FDQ_Tareas);
end;

procedure TFRM_Main.AC_FiltroEstadoExecute(Sender: TObject);
var
estadoKey: Integer;
begin
  estadoKey:= 0;
  startEstadoSelector(estadoKey);
  FDQ_Tareas.ParamByName('EstadoKey').AsInteger:= estadoKey;
  if estadoKey <> 0 then
    DM_DataModule.actualizarQuery(FDQ_Tareas)
  else
    ShowMessage('No se selecciono Ningun Estado');
end;

procedure TFRM_Main.AC_MarcarCompletadaExecute(Sender: TObject);
var
fdq: TFDQuery;
begin
  //solo actualizamos el registro donde estemos parados
  fdq:= DM_DataModule.crearQuery;
  fdq.SQL.Add('Update Tarea set FechaCompletada = :fecha, EstadoKey = 2 where TareaKey = :tareaKey');
  fdq.ParamByName('fecha').AsDateTime:= DM_DataModule.getDate;
  fdq.ParamByName('tareaKey').AsInteger:= FDQ_Tareas.FieldByName('TareaKey').AsInteger;

  try
  fdq.ExecSQL;
  finally
  fdq.Free
  end;

  DM_DataModule.actualizarQuery(FDQ_Tareas);
end;

procedure TFRM_Main.AC_NuevaTareaExecute(Sender: TObject);
begin
  startTareasEditor();
  DM_DataModule.actualizarQuery(FDQ_Tareas);
end;

procedure TFRM_Main.AC_TareasPendientesExecute(Sender: TObject);
begin
  FDQ_Tareas.ParamByName('estadoKey').AsInteger:= ESTADO_ACTIVA;
  DM_DataModule.actualizarQuery(FDQ_Tareas);
end;

procedure TFRM_Main.FormCreate(Sender: TObject);
begin
     inicializar;
end;

procedure TFRM_Main.IM_MenuButtonClick(Sender: TObject);
begin
  SV_Menu.Opened:= not SV_Menu.Opened;
end;

procedure TFRM_Main.inicializar;
begin
  if not FileExists(Application.GetNamePath+'Conexion.ini') then
    ShowMessage('Debe configurar una conexion a BD')
  else
    begin
    FDQ_Tareas.ParamByName('estadoKey').AsInteger:= ESTADO_ACTIVA;
    DM_DataModule.actualizarQuery(FDQ_Tareas);
    end;
end;

end.
