object FRM_TareaEditor: TFRM_TareaEditor
  Left = 0
  Top = 0
  Caption = 'Editor Tareas'
  ClientHeight = 298
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PN_Background: TPanel
    Left = 0
    Top = 0
    Width = 666
    Height = 298
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 59
      Width = 72
      Height = 13
      Alignment = taRightJustify
      Caption = 'Nombre Tarea:'
    end
    object Label2: TLabel
      Left = 11
      Top = 107
      Width = 93
      Height = 13
      Alignment = taRightJustify
      Caption = 'Fecha Vencimiento:'
    end
    object Label3: TLabel
      Left = 67
      Top = 163
      Width = 37
      Height = 13
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object E_NombreTarea: TEdit
      Left = 120
      Top = 56
      Width = 521
      Height = 21
      MaxLength = 100
      TabOrder = 0
      OnKeyPress = E_NombreTareaKeyPress
    end
    object CP_FechaVencimiento: TCalendarPicker
      Left = 120
      Top = 96
      Width = 161
      Height = 32
      CalendarHeaderInfo.DaysOfWeekFont.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.DaysOfWeekFont.Color = clWindowText
      CalendarHeaderInfo.DaysOfWeekFont.Height = -13
      CalendarHeaderInfo.DaysOfWeekFont.Name = 'Segoe UI'
      CalendarHeaderInfo.DaysOfWeekFont.Style = []
      CalendarHeaderInfo.Font.Charset = DEFAULT_CHARSET
      CalendarHeaderInfo.Font.Color = clWindowText
      CalendarHeaderInfo.Font.Height = -20
      CalendarHeaderInfo.Font.Name = 'Segoe UI'
      CalendarHeaderInfo.Font.Style = []
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TextHint = 'Seleccione Fecha'
    end
    object BT_Aceptar: TButton
      Left = 208
      Top = 240
      Width = 97
      Height = 36
      Caption = 'Aceptar'
      ImageIndex = 4
      Images = DM_DataModule.ImageList1
      TabOrder = 2
      OnClick = BT_AceptarClick
    end
    object Button2: TButton
      Left = 350
      Top = 240
      Width = 107
      Height = 36
      Caption = 'Cancelar'
      ImageIndex = 5
      Images = DM_DataModule.ImageList1
      TabOrder = 3
      OnClick = Button2Click
    end
    object DBL_Estado: TDBLookupComboBox
      Left = 120
      Top = 159
      Width = 145
      Height = 21
      KeyField = 'EstadoKey'
      ListField = 'Nombre'
      ListSource = DS_Estado
      TabOrder = 4
    end
  end
  object FDQ_Estado: TFDQuery
    ConnectionName = 'MainDB'
    SQL.Strings = (
      'Select * from Estado')
    Left = 552
    Top = 128
  end
  object DS_Estado: TDataSource
    DataSet = FDQ_Estado
    Left = 552
    Top = 184
  end
end
