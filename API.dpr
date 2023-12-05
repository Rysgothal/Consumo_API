program API;

{$R *.dres}

uses
  Vcl.Forms,
  API.Forms.Principal.Menu in 'Forms\Principal\API.Forms.Principal.Menu.pas' {frmPrincipal},
  API.Forms.ViaCep in 'Forms\ViaCep\API.Forms.ViaCep.pas' {frmViaCep},
  API.DataModules.Principal in 'DataModules\API.DataModules.Principal.pas' {dmPrincipal: TDataModule},
  API.Classes.JSON.ViaCep in 'Classes\JSON\API.Classes.JSON.ViaCep.pas',
  API.Classes.Helpers.Exceptions in 'Classes\Helpers\API.Classes.Helpers.Exceptions.pas',
  API.Classes.Base.Principal in 'Classes\Base\API.Classes.Base.Principal.pas',
  API.Classes.Base.ViaCep in 'Classes\Base\API.Classes.Base.ViaCep.pas',
  API.Classes.Helpers.Strings in 'Classes\Helpers\API.Classes.Helpers.Strings.pas',
  API.Interfaces.AbstractFactory.FabricaApi in 'Interfaces\AbstractFactory\API.Interfaces.AbstractFactory.FabricaApi.pas',
  API.Classes.Base.IBGEMesorregiao in 'Classes\Base\API.Classes.Base.IBGEMesorregiao.pas',
  API.Classes.AbstractFactory.FabricaAPi in 'Classes\AbstractFactory\API.Classes.AbstractFactory.FabricaAPi.pas',
  API.Classes.AbstractFactory.ProdutoViaCep in 'Classes\AbstractFactory\API.Classes.AbstractFactory.ProdutoViaCep.pas',
  API.Classes.Singleton.Principal in 'Classes\Singleton\API.Classes.Singleton.Principal.pas',
  API.Classes.Helpers.Enumerados in 'Classes\Helpers\API.Classes.Helpers.Enumerados.pas',
  API.Classes.AbstractFactory.ProdutoIBGE in 'Classes\AbstractFactory\API.Classes.AbstractFactory.ProdutoIBGE.pas',
  API.Classes.Base.IBGERegiao in 'Classes\Base\API.Classes.Base.IBGERegiao.pas',
  API.Classes.Base.IBGENomes in 'Classes\Base\API.Classes.Base.IBGENomes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmPrincipal, dmPrincipal);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
