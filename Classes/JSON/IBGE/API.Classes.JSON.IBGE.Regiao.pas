unit API.Classes.JSON.IBGE.Regiao;

interface

uses
  REST.Json, REST.Json.Types, REST.JsonReflect, System.Generics.Collections, System.JSON,
  System.SysUtils;

type
  TJSONIBGERegiao = class
  private
    [JSONName('id')]
    FId: Integer;
    [JSONName('sigla')]
    FSigla: string;
    [JSONName('nome')]
    FNome: string;
  public
    property Id: Integer read FId write FId;
    property Sigla: string read FSigla write FSigla;
    property Nome: string read FNome write FNome;
  end;

  TJSONIBGERegioes = class
  private
    [JSONName('regioes')]
    FRegiaoArray: TArray<TJSONIBGERegiao>;
    FRegiaoLista: TObjectList<TJSONIBGERegiao>;
    function GetRegiao: TObjectList<TJSONIBGERegiao>;
  public
    constructor Create(pJSONValue: TJSONValue; pDefault: string); overload;
    destructor Destroy; override;
    property Regiao: TObjectList<TJSONIBGERegiao> read GetRegiao;
  end;

implementation

{ TJSONIBGERegioes }

constructor TJSONIBGERegioes.Create(pJSONValue: TJSONValue; pDefault: string);
var
  lJSONUnMarshal: TJSONUnMarshal;
begin
  inherited Create;
  FRegiaoLista := TObjectList<TJSONIBGERegiao>.Create;

  if pJSONValue is TJSONArray then
  begin
    lJSONUnMarshal := TJSONUnMarshal.Create;
    try
      lJSONUnMarshal.SetFieldArray(Self, pDefault, (pJSONValue as TJSONArray));
    finally
      FreeAndNil(lJSONUnMarshal);
    end;

    Exit;
  end;

  Self := TJson.JsonToObject<TJSONIBGERegioes>(TJSONObject(pJSONValue));
end;

destructor TJSONIBGERegioes.Destroy;
begin
  for var lRegiaoArray in FRegiaoArray do
  begin
    FreeAndNil(lRegiaoArray);
  end;

  FRegiaoArray := nil;
  FRegiaoLista.FreeInstance;
  inherited;
end;

function TJSONIBGERegioes.GetRegiao: TObjectList<TJSONIBGERegiao>;
begin
  for var lElemento in FRegiaoArray do
  begin
    FRegiaoLista.Add(lElemento);
  end;

  Result := FRegiaoLista;
end;

end.
