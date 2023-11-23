unit unitConsMovimentacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TformConsMovimentacoes = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    txtDataInicial: TMaskEdit;
    txtDataFinal: TMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    btConsultar: TButton;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Label4: TLabel;
    lblTotal: TLabel;
    procedure btConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formConsMovimentacoes: TformConsMovimentacoes;

implementation

{$R *.dfm}

uses unitDM;

procedure TformConsMovimentacoes.btConsultarClick(Sender: TObject);
begin
  DM.sqlMovimentacoes.Close;
  DM.sqlMovimentacoes.SQL.Clear;
  DM.sqlMovimentacoes.SQL.Text := 'SELECT * FROM movimentacoes WHERE Date(dataHota) BETWEEN :pDatatInicial AND :pDataFinal';
  DM.sqlMovimentacoes.ParamByName('pDataInicial').Value := FormatDateTime('yyyy-mm-dd', StrToDate(txtDataInicial.Text));
  DM.sqlMovimentacoes.ParamByName('pDataFinal').Value := FormatDateTime('yyyy-mm-dd', StrToDate(txtDataFinal.Text));
  DM.sqlMovimentacoes.Open();

  lblTotal.Caption := IntToStr(DM.sqlMovimentacoes.RecordCount);
end;

procedure TformConsMovimentacoes.FormShow(Sender: TObject);
begin
  DM.sqlMovimentacoes.Refresh;
  DM.sqlMovProdutos.Refresh;
  lblTotal.Caption := IntToStr(DM.sqlMovimentacoes.RecordCount);
end;

end.
