program RegistroTareas;

uses
  Vcl.Forms,
  Main in 'Main.pas' {FRM_Main},
  TareaEditor in 'TareaEditor.pas' {FRM_TareaEditor},
  DataModule in 'DataModule.pas' {DM_DataModule: TDataModule},
  EstadoSelector in 'EstadoSelector.pas' {FRM_EstadoSelector},
  ConexionEditor in 'ConexionEditor.pas' {FRM_ConexionBD};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM_DataModule, DM_DataModule);
  Application.CreateForm(TFRM_Main, FRM_Main);
  Application.Run;
end.
