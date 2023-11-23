unit unitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, Vcl.Dialogs;

type
  TDM = class(TDataModule)
    Conexao: TFDConnection;
    tbProdutos: TFDTable;
    dsProdutos: TDataSource;
    tbMovimentacoes: TFDTable;
    tbMovProdutos: TFDTable;
    dsMovimentacoes: TDataSource;
    dsMovProdutos: TDataSource;
    sqlAumentaEstoque: TFDCommand;
    sqlDiminuiEstoque: TFDCommand;
    sqlMovimentacoes: TFDQuery;
    dsSqlMovimentacoes: TDataSource;
    tbProdutosid: TFDAutoIncField;
    tbProdutosnome: TStringField;
    tbProdutosfabricante: TStringField;
    tbProdutosvalidade: TDateField;
    tbProdutosestoqueAtual: TIntegerField;
    tbMovProdutosid: TFDAutoIncField;
    tbMovProdutosidMovimentacoes: TIntegerField;
    tbMovProdutosidProdutos: TIntegerField;
    tbMovProdutosquantidade: TIntegerField;
    tbMovProdutosnomeProduto: TStringField;
    sqlMovProdutos: TFDQuery;
    dsSqlMovProdutos: TDataSource;
    sqlMovProdutosid: TFDAutoIncField;
    sqlMovProdutosidMovimentacoes: TIntegerField;
    sqlMovProdutosidProdutos: TIntegerField;
    sqlMovProdutosquantidade: TIntegerField;
    sqlMovProdutosnomeProduto: TStringField;
    procedure tbMovProdutosAfterPost(DataSet: TDataSet);
    procedure tbMovProdutosAfterDelete(DataSet: TDataSet);
    procedure calcularTotais;
    procedure tbMovimentacoesAfterScroll(DataSet: TDataSet);
    procedure tbMovProdutosBeforeDelete(DataSet: TDataSet);
    procedure tbMovimentacoesBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses unitCadMovimentacoes;

{$R *.dfm}

procedure TDM.calcularTotais;
//cria��o da fun��o
var
  totais : Integer;
begin
  if tbMovProdutos.State in (dsBrowse) then
    begin
        tbMovProdutos.First;

        //repete at� o final da tabela, soma e vai para o pr�ximo
        while not tbMovProdutos.Eof do
          begin
            totais := totais + tbMovProdutos.FieldByName('quantidade').Value;

            tbMovProdutos.Next;
          end;

        formCadMovimentacoes.txtTotalProdutos.Caption := IntToStr(totais);

    end;
end;

procedure TDM.tbMovimentacoesAfterScroll(DataSet: TDataSet);
begin
  calcularTotais;
end;

procedure TDM.tbMovimentacoesBeforeDelete(DataSet: TDataSet);
begin
  if tbMovProdutos.RecordCount > 0 then
    begin
      ShowMessage('Existem produtos cadastrados nessa movimenta��o. Exclua-os primeiro!');
      abort;
    end;

end;

procedure TDM.tbMovProdutosAfterDelete(DataSet: TDataSet);
begin
  calcularTotais;     //invoca��o da fun��o
end;

procedure TDM.tbMovProdutosAfterPost(DataSet: TDataSet);
begin
  calcularTotais;     //invoca��o da fun��o

    if (tbMovimentacoes.FieldByName('tipo').Value = 'Entrada no Estoque') then
      begin
        sqlAumentaEstoque.ParamByName('pId').Value := tbMovimentacoes.FieldByName('idProduto').Value;
        sqlAumentaEstoque.ParamByName('pQtd').Value := tbMovimentacoes.FieldByName('quantidade').Value;
        sqlAumentaEstoque.Execute;
      end;

    if (tbMovimentacoes.FieldByName('tipo').Value = 'Sa�da do Estoque') then
      begin
        sqlDiminuiEstoque.ParamByName('pId').Value := tbMovimentacoes.FieldByName('idProduto').Value;
        sqlDiminuiEstoque.ParamByName('pQtd').Value := tbMovimentacoes.FieldByName('quantidade').Value;
        sqlDiminuiEstoque.Execute;
      end;

end;

procedure TDM.tbMovProdutosBeforeDelete(DataSet: TDataSet);
begin
  if (tbMovimentacoes.FieldByName('tipo').Value = 'Entrada no Estoque') then
    begin
      sqlDiminuiEstoque.ParamByName('pId').Value := tbMovimentacoes.FieldByName('idProduto').Value;
      sqlDiminuiEstoque.ParamByName('pQtd').Value := tbMovimentacoes.FieldByName('quantidade').Value;
      sqlDiminuiEstoque.Execute;
    end;

  if (tbMovimentacoes.FieldByName('tipo').Value = 'Sa�da do Estoque') then
    begin
      sqlAumentaEstoque.ParamByName('pId').Value := tbMovimentacoes.FieldByName('idProduto').Value;
      sqlAumentaEstoque.ParamByName('pQtd').Value := tbMovimentacoes.FieldByName('quantidade').Value;
      sqlAumentaEstoque.Execute;
    end;
end;

end.
