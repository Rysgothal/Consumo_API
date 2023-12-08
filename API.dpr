program API;

{$R *.dres}

uses
  Vcl.Forms,
  API.Forms.Principal in 'Forms\API.Forms.Principal.pas' {frmPrincipal},
  API.Forms.ViaCep in 'Forms\API.Forms.ViaCep.pas' {frmViaCep},
  API.DataModules.Principal in 'DataModules\API.DataModules.Principal.pas' {dmPrincipal: TDataModule},
  API.Classes.JSON.ViaCep in 'Classes\JSON\API.Classes.JSON.ViaCep.pas',
  API.Classes.Helpers.Exceptions in 'Classes\Helpers\API.Classes.Helpers.Exceptions.pas',
  API.Classes.Base.Principal in 'Classes\Base\API.Classes.Base.Principal.pas',
  API.Classes.Base.ViaCep in 'Classes\Base\API.Classes.Base.ViaCep.pas',
  API.Classes.Helpers.Strings in 'Classes\Helpers\API.Classes.Helpers.Strings.pas',
  API.Classes.Base.IBGE.Mesorregiao in 'Classes\Base\IBGE\API.Classes.Base.IBGE.Mesorregiao.pas',
  API.Classes.Helpers.Enumerados in 'Classes\Helpers\API.Classes.Helpers.Enumerados.pas',
  API.Classes.Base.IBGE.Regiao in 'Classes\Base\IBGE\API.Classes.Base.IBGE.Regiao.pas',
  API.Classes.Base.IBGE.Nomes in 'Classes\Base\IBGE\API.Classes.Base.IBGE.Nomes.pas',
  API.Interfaces.Strategy.Principal in 'Interfaces\Strategy\API.Interfaces.Strategy.Principal.pas',
  API.Classes.Strategy.ViaCepStrategy in 'Classes\Strategy\API.Classes.Strategy.ViaCepStrategy.pas',
  API.Classes.JSON.IBGE.Regiao in 'Classes\JSON\IBGE\API.Classes.JSON.IBGE.Regiao.pas',
  API.Classes.JSON.IBGE.Mesorregiao in 'Classes\JSON\IBGE\API.Classes.JSON.IBGE.Mesorregiao.pas',
  API.Classes.JSON.IBGE.Metadados in 'Classes\JSON\IBGE\API.Classes.JSON.IBGE.Metadados.pas',
  API.Classes.JSON.IBGE.NomeFrequencia in 'Classes\JSON\IBGE\API.Classes.JSON.IBGE.NomeFrequencia.pas',
  API.Classes.JSON.IBGE.NomeRanking in 'Classes\JSON\IBGE\API.Classes.JSON.IBGE.NomeRanking.pas',
  API.Classes.JSON.IBGE.UF in 'Classes\JSON\IBGE\API.Classes.JSON.IBGE.UF.pas',
  API.Forms.IBGEMesorregiao in 'Forms\IBGE\API.Forms.IBGEMesorregiao.pas' {frmIbgeMesorregiao},
  API.Forms.IBGERegiao in 'Forms\IBGE\API.Forms.IBGERegiao.pas' {frmIbgeRegiao},
  API.Forms.Navegador in 'Forms\API.Forms.Navegador.pas' {frmNavegador},
  API.Classes.Strategy.IBGERegioesStrategy in 'Classes\Strategy\API.Classes.Strategy.IBGERegioesStrategy.pas',
  API.Classes.Strategy.IBGEMetadadosStrategy in 'Classes\Strategy\API.Classes.Strategy.IBGEMetadadosStrategy.pas',
  API.Classes.Base.IBGE.Metadados in 'Classes\Base\IBGE\API.Classes.Base.IBGE.Metadados.pas',
  API.Classes.Strategy.IBGEMesorregiaoStrategy in 'Classes\Strategy\API.Classes.Strategy.IBGEMesorregiaoStrategy.pas',
  API.Classes.Strategy.IBGEEstadosStrategy in 'Classes\Strategy\API.Classes.Strategy.IBGEEstadosStrategy.pas',
  API.Classes.Decorator.Log in 'Classes\Decorator\API.Classes.Decorator.Log.pas',
  API.Interfaces.Bridge.JSONParaObject in 'Interfaces\Bridge\API.Interfaces.Bridge.JSONParaObject.pas',
  API.Classes.Bridge.ViaCepBridge in 'Classes\Bridge\API.Classes.Bridge.ViaCepBridge.pas',
  API.Classes.Bridge.IBGERegiaoBridge in 'Classes\Bridge\API.Classes.Bridge.IBGERegiaoBridge.pas',
  API.Classes.Bridge.IBGEMetadadosBridge in 'Classes\Bridge\API.Classes.Bridge.IBGEMetadadosBridge.pas',
  API.Classes.Bridge.IBGEUFBridge in 'Classes\Bridge\API.Classes.Bridge.IBGEUFBridge.pas',
  API.Classes.Bridge.IBGEMesorregiaoBridge in 'Classes\Bridge\API.Classes.Bridge.IBGEMesorregiaoBridge.pas',
  API.Classes.Base.IBGE.Estados in 'Classes\Base\IBGE\API.Classes.Base.IBGE.Estados.pas',
  Vcl.Themes,
  Vcl.Styles,
  API.Frames.ViaCep in 'Frames\API.Frames.ViaCep.pas' {frmDadosViaCep: TFrame},
  API.Classes.Singleton.Principal in 'Classes\Singleton\API.Classes.Singleton.Principal.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
