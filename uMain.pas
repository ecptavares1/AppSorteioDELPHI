unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.ListBox,
  uFormat;

type
  TForm1 = class(TForm)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    edtNome: TEdit;
    Label2: TLabel;
    edtRG: TEdit;
    Label3: TLabel;
    edtCelular: TEdit;
    Rectangle4: TRectangle;
    Label4: TLabel;
    Rectangle5: TRectangle;
    Label5: TLabel;
    ListBox1: TListBox;
    StyleBook1: TStyleBook;
    procedure edtCelularTyping(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Rectangle5Click(Sender: TObject);
    procedure Rectangle4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Num : Integer;
    NumAdded : Boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.edtCelularTyping(Sender: TObject);
begin
  Formatar(edtCelular,TFormato.Celular);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Num := 1;
  NumAdded := False;
end;

procedure TForm1.Rectangle4Click(Sender: TObject);
var
  ListBoxItem : TListBoxItem;
begin
  if edtNome.Text <> '' then
  Begin
    ListBox1.BeginUpdate;

    ListBoxItem := TListBoxItem.Create(ListBox1);
    ListBoxItem.Height := 90;
    ListBoxItem.Parent := ListBox1;
    ListBoxItem.StyleLookup := 'ListBoxItemAndroid';
    ListBoxItem.StylesData['lblNumero'] := Num;
    ListBoxItem.StylesData['lblNome'] := edtNome.Text;
    ListBoxItem.StylesData['lblRG'] := edtRG.Text;
    ListBoxItem.StylesData['lblCelular'] := edtCelular.Text;
    ListBox1.AddObject(ListBoxItem);

    ListBox1.EndUpdate;
    Num := Num + 1;
    NumAdded := True;

  End
  Else
  Begin
    ShowMessage('Voce precisa preencher pelo menos o campo NOME.');
    edtNome.SetFocus;
  End;
end;

procedure TForm1.Rectangle5Click(Sender: TObject);
var
  numSorteado : Integer;
begin
  if NumAdded then
  Begin
    numSorteado := 0;
    numSorteado := round(random(Num));
    while numSorteado <= 0 do
      numSorteado := round(random(Num));
    ShowMessage('NOME : ' + Listbox1.ListItems[numSorteado - 1].StylesData['lblNome'].AsString + #13 + 'RG : ' + Listbox1.ListItems[numSorteado - 1].StylesData['lblRG'].AsString + #13 + 'CELULAR : ' + Listbox1.ListItems[numSorteado - 1].StylesData['lblCelular'].AsString + #13 + 'NUMERO : ' + Listbox1.ListItems[numSorteado - 1].StylesData['lblNumero'].AsString );
  End
  Else
  Begin
    ShowMessage('Você precisa adicionar os nomes para o sorteo.');
  End;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  MessageDlg('Deseja realizar novo sorteio ?', System.UITypes.TMsgDlgType.mtInformation,
  [System.UITypes.TMsgDlgBtn.mbYes,
  System.UITypes.TMsgDlgBtn.mbNo
  ], 0,
    procedure(const AResult: System.UITypes.TModalResult)
    begin
        case AResult of
        mrYES:
        begin
          Num := 1;
          NumAdded := False;
          edtNome.Text := '';
          edtRG.Text := '';
          edtCelular.Text := '';
          ListBox1.Clear;
        end;

      end;
    end);
end;

end.
