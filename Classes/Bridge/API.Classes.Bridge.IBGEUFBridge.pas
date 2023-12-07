unit API.Classes.Bridge.IBGEUFBridge;

interface

uses
  API.Interfaces.Bridge.JSONParaObject, System.JSON;

type
  TBridgeIBGEUFs = class(TInterfacedObject, ITransformar)
  public
    function ParaObjeto(const pJSON: TJSONValue): TObject;
  end;

implementation

uses
  API.Classes.JSON.IBGE.UF;

{ TBridgeIBGEUFs }

function TBridgeIBGEUFs.ParaObjeto(const pJSON: TJSONValue): TObject;
begin
  Result := TJSONIbgeUFs.Create(pJSON, 'uf');
end;

end.
