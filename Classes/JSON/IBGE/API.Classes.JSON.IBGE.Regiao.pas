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
  vJSONUnMarshal: TJSONUnMarshal;
begin
  inherited Create;

  if pJSONValue is TJSONArray then
  begin
    vJSONUnMarshal := TJSONUnMarshal.Create;
    try
      vJSONUnMarshal.SetFieldArray(Self, pDefault, (pJSONValue as TJSONArray));
    finally
      FreeAndNil(vJSONUnMarshal);
    end;

    Exit;
  end;

  Self := TJson.JsonToObject<TJSONIBGERegioes>(TJSONObject(pJSONValue));
end;

destructor TJSONIBGERegioes.Destroy;
begin
  for var lRegiao in FRegiaoArray do
  begin
    if not Assigned(lRegiao) then
    begin
      Continue;
    end;

    FreeAndNil(lRegiao);
  end;

  inherited;
end;

function TJSONIBGERegioes.GetRegiao: TObjectList<TJSONIBGERegiao>;
var
  vElemento: TJSONIBGERegiao;
  vListaRegioes: TObjectList<TJSONIBGERegiao>;
begin
  vListaRegioes := TObjectList<TJSONIBGERegiao>.Create;

  for vElemento in FRegiaoArray do
  begin
    vListaRegioes.Add(vElemento);
  end;

  Result := vListaRegioes;
end;

end.
