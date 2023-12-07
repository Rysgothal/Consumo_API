unit API.Classes.Bridge.IBGERegiaoBridge;

interface

uses
  API.Interfaces.Bridge.JSONParaObject, System.JSON;

type
  TBridgeIBGERegiao = class(TInterfacedObject, ITransformar)
  public
    function ParaObjeto(const pJSON: TJSONValue): TObject;
  end;

  TBridgeIBGERegioes = class(TInterfacedObject, ITransformar)
  public
    function ParaObjeto(const pJSON: TJSONValue): TObject;
  end;

implementation

uses
  REST.Json, API.Classes.JSON.IBGE.Regiao;

{ TBridgeIBGERegiao }

function TBridgeIBGERegiao.ParaObjeto(const pJSON: TJSONValue): TObject;
begin
  Result := TJson.JsonToObject<TJSONIBGERegiao>(TJSONObject(pJSON));
end;

{ TBridgeIBGERegioes }

function TBridgeIBGERegioes.ParaObjeto(const pJSON: TJSONValue): TObject;
begin
  Result := TJSONIbgeRegioes.Create(pJson, 'regioes');
end;

end.
