program API;

{$R *.dres}

uses
  Vcl.Forms,
  API.Forms.Principal in 'Forms\Principal\API.Forms.Principal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
