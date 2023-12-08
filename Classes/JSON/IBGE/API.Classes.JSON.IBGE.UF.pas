unit API.Classes.JSON.IBGE.UF;

interface

uses
  REST.Json, REST.Json.Types, REST.JsonReflect, System.Generics.Collections, System.JSON, System.StrUtils,
  System.Classes, System.SysUtils, REST.Client, API.Classes.JSON.IBGE.Regiao;

type
  TJSONIbgeUF = class
  private
    [JSONName('id')]
    FId: Integer;
    [JSONName('sigla')]
    FSigla: string;
    [JSONName('nome')]
    FNome: string;
    [JSONName('regiao')]
    FRegiao: TJSONIBGERegiao;
  public
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property Sigla: string read FSigla write FSigla;
    property Nome: string read FNome write FNome;
    property Regiao: TJSONIBGERegiao read FRegiao write FRegiao;
  end;

  TJSONIbgeUFs = class
  private
    [JSONName('uf'), JSONMarshalled(False)]
    FUfArray: TArray<TJSONIbgeUF>;
    FUfLista: TObjectList<TJSONIbgeUF>;
    function GetUfs: TObjectList<TJSONIbgeUF>;
  public
    constructor Create(pJSONValue: TJSONValue; aDefault: string); overload;
    destructor Destroy; override;
    property Ufs: TObjectList<TJSONIbgeUF> read GetUfs;
  end;

implementation

{ TJSONIbgeUFs }

constructor TJSONIbgeUFs.Create(pJSONValue: TJSONValue; aDefault: string);
var
  lJSONUnMarshal: TJSONUnMarshal;
begin
  inherited Create;
  FUfLista := TObjectList<TJSONIbgeUF>.Create;

  if pJSONValue is TJSONArray then
  begin
    lJSONUnMarshal := TJSONUnMarshal.Create;
    try
      lJSONUnMarshal.SetFieldArray(Self, aDefault, (pJSONValue as TJSONArray));
    finally
      lJSONUnMarshal.Free;
    end;

    Exit;
  end;

  Self := TJson.JsonToObject<TJSONIbgeUFs>(TJSONObject(pJSONValue));
end;

destructor TJSONIbgeUFs.Destroy;
begin
  for var lUF in FUfArray do
  begin
    FreeAndNil(lUF);
  end;

  FUfArray := nil;
  FUfLista.FreeInstance;
  inherited;
end;

function TJSONIbgeUFs.GetUfs: TObjectList<TJSONIbgeUF>;
begin
  for var lElemento in FUfArray do
  begin
    FUfLista.Add(lElemento);
  end;

  Result := FUfLista;
end;

{ TJSONIbgeUF }

destructor TJSONIbgeUF.Destroy;
begin
  FreeAndNil(FRegiao);
  inherited;
end;

end.
