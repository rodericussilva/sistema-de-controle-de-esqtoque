program SistemaEstoque;

uses
  Vcl.Forms,
  unitPrincipal in 'unitPrincipal.pas' {formPrincipal},
  unitCadProdutos in 'unitCadProdutos.pas' {formCadProduto},
  unitCadMovimentacoes in 'unitCadMovimentacoes.pas' {formCadMovimentacoes},
  unitConsMovimentacoes in 'unitConsMovimentacoes.pas' {formConsMovimentacoes},
  unitDM in 'unitDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.CreateForm(TformCadProduto, formCadProduto);
  Application.CreateForm(TformCadMovimentacoes, formCadMovimentacoes);
  Application.CreateForm(TformConsMovimentacoes, formConsMovimentacoes);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
