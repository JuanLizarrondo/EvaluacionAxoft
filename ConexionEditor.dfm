object FRM_ConexionBD: TFRM_ConexionBD
  Left = 0
  Top = 0
  Caption = 'Configuracion Conexion Bases De Datos'
  ClientHeight = 393
  ClientWidth = 674
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
  object PN_Background: TPanel
    Left = 0
    Top = 0
    Width = 674
    Height = 393
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 312
    ExplicitTop = 144
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Label1: TLabel
      Left = 176
      Top = 80
      Width = 44
      Height = 13
      Caption = 'Servidor:'
    end
    object Label2: TLabel
      Left = 176
      Top = 123
      Width = 73
      Height = 13
      Caption = 'Base de Datos:'
    end
    object Label3: TLabel
      Left = 176
      Top = 163
      Width = 43
      Height = 13
      Caption = 'Usuario: '
    end
    object Label4: TLabel
      Left = 176
      Top = 203
      Width = 63
      Height = 13
      Caption = 'Contrase'#241'a: '
    end
    object E_Servidor: TEdit
      Left = 272
      Top = 77
      Width = 209
      Height = 21
      TabOrder = 0
    end
    object E_BasedeDatos: TEdit
      Left = 272
      Top = 120
      Width = 209
      Height = 21
      TabOrder = 1
    end
    object E_Usuario: TEdit
      Left = 272
      Top = 160
      Width = 209
      Height = 21
      TabOrder = 2
    end
    object E_Pass: TEdit
      Left = 272
      Top = 200
      Width = 209
      Height = 21
      PasswordChar = '*'
      TabOrder = 3
    end
    object BT_Test: TButton
      Left = 164
      Top = 288
      Width = 101
      Height = 33
      Caption = 'Test Conexion'
      TabOrder = 4
      OnClick = BT_TestClick
    end
    object BT_Aceptar: TButton
      Left = 404
      Top = 288
      Width = 101
      Height = 33
      Caption = 'Aceptar'
      TabOrder = 5
      OnClick = BT_AceptarClick
    end
  end
end
