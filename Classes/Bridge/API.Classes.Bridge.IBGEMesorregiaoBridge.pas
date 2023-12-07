unit API.Classes.Bridge.IBGEMesorregiaoBridge;

interface

uses
  API.Interfaces.Bridge.JSONParaObject, System.JSON;

type
  TBridgeIBGEMesorregioes = class(TInterfacedObject, ITransformar)
  public
    function ParaObjeto(const pJSON: TJSONValue): TObject;
  end;

implementation

uses
  API.Classes.JSON.IBGE.Mesorregiao;

{ TBridgeIBGEMesorregioes }

function TBridgeIBGEMesorregioes.ParaObjeto(const pJSON: TJSONValue): TObject;
begin
  Result := TJSONIBGEMesorregioes.Create(pJSON, 'mesorregiao');
end;

end.
