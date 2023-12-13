unit API.Classes.JSON.IBGE.Mesorregiao;

interface

uses
  REST.Json, REST.Json.Types, REST.JsonReflect, System.Generics.Collections,
  System.JSON, System.StrUtils, System.Classes, System.SysUtils,
  API.Classes.JSON.IBGE.UF;

type
  TJSONIBGEMesorregiao = class
  private
    [JSONName('id')]
    FId: Integer;
    [JSONName('nome')]
    FNome: string;
    [JSONName('UF')]
    FUF: TJSONIBGEUF;
  public
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property UF: TJSONIBGEUF read FUF write FUF;
  end;

  TJSONIBGEMesorregioes = class
  private
    [JSONName('mesorregiao'), JSONMarshalled(False)]
    FMesorregioesArray: TArray<TJSONIBGEMesorregiao>;
    FMesorregioesLista: TObjectList<TJSONIBGEMesorregiao>;
    function GetMesorregioes: TObjectList<TJSONIBGEMesorregiao>;
  public
    constructor Create(pJSONValue: TJSONValue; aDefault: string); overload;
    destructor Destroy; override;
    property Mesorregioes: TObjectList<TJSONIBGEMesorregiao> read GetMesorregioes;
  end;

implementation

uses
  REST.Client;

{ TJSONIBGEMesorregioes }

constructor TJSONIBGEMesorregioes.Create(pJSONValue: TJSONValue; aDefault: string);
var
  lJSONUnMarshal: TJSONUnMarshal;
begin
  inherited Create;
  FMesorregioesLista := TObjectList<TJSONIBGEMesorregiao>.Create;

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

  Self := TJson.JsonToObject<TJSONIBGEMesorregioes>(TJSONObject(pJSONValue));
end;

destructor TJSONIBGEMesorregioes.Destroy;
begin
  for var lMesorregiao in FMesorregioesArray do
  begin
    FreeAndNil(lMesorregiao);
  end;

  FMesorregioesArray := nil;
  FMesorregioesLista.FreeInstance;
  inherited;
end;

function TJSONIBGEMesorregioes.GetMesorregioes: TObjectList<TJSONIBGEMesorregiao>;
begin
  for var lElemento in FMesorregioesArray do
  begin
    FMesorregioesLista.Add(lElemento);
  end;

  Result := FMesorregioesLista;
end;

{ TJSONIBGEMesorregiao }

destructor TJSONIBGEMesorregiao.Destroy;
begin
  FreeAndNil(FUF);
  inherited;
end;

end.
