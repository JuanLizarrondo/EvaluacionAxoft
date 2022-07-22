object FRM_EstadoSelector: TFRM_EstadoSelector
  Left = 0
  Top = 0
  Caption = 'Selector De Estado'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 505
    Height = 231
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 184
    ExplicitTop = 88
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Label1: TLabel
      Left = 136
      Top = 104
      Width = 40
      Height = 13
      Caption = 'Estado: '
    end
    object BT_Aceptar: TButton
      Left = 200
      Top = 168
      Width = 145
      Height = 25
      Caption = 'Aceptar'
      TabOrder = 0
      OnClick = BT_AceptarClick
    end
    object DBL_Estado: TDBLookupComboBox
      Left = 200
      Top = 104
      Width = 145
      Height = 21
      KeyField = 'EstadoKey'
      ListField = 'Nombre'
      ListSource = DS_Estado
      TabOrder = 1
    end
  end
  object FDQ_Estado: TFDQuery
    ConnectionName = 'MainDB'
    SQL.Strings = (
      'select * from Estado')
    Left = 416
    Top = 88
  end
  object DS_Estado: TDataSource
    DataSet = FDQ_Estado
    Left = 416
    Top = 136
  end
end
