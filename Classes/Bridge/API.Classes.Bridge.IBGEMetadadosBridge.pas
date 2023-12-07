unit API.Classes.Bridge.IBGEMetadadosBridge;

interface

uses
  API.Interfaces.Bridge.JSONParaObject, System.JSON;

type
  TBridgeIBGEMetadados = class(TInterfacedObject, ITransformar)
  public
    function ParaObjeto(const pJSON: TJSONValue): TObject;
  end;

implementation

uses
  API.Classes.JSON.IBGE.Metadados;

{ TBridgeIBGEMetadados }

function TBridgeIBGEMetadados.ParaObjeto(const pJSON: TJSONValue): TObject;
begin
  Result := TJSONIBGEMetadados.Create(pJSON, 'metadados');
end;

end.
