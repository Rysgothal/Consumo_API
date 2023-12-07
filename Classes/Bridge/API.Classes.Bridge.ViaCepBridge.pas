unit API.Classes.Bridge.ViaCepBridge;

interface

uses
  API.Interfaces.Bridge.JSONParaObject, System.JSON;

type
  TBridgeViaCep = class(TInterfacedObject, ITransformar)
  public
    function ParaObjeto(const pJSON: TJSONValue): TObject;
  end;

implementation

uses
  API.Classes.JSON.ViaCep, REST.Json;

{ TBridgeViaCep }

function TBridgeViaCep.ParaObjeto(const pJSON: TJSONValue): TObject;
begin
  Result := TJson.JsonToObject<TJSONViaCep>(TJSONObject(pJson));
end;

end.
