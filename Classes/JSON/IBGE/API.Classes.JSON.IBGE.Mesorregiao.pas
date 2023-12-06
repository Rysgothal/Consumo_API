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
    FUF: TJSONIbgeUF;
  public
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property UF: TJSONIbgeUF read FUF write FUF;
  end;

  TJSONIBGEMesorregioes = class
  private
    [JSONName('mesorregiao'), JSONMarshalled(False)]
    FMesorregioesArray: TArray<TJSONIBGEMesorregiao>;
    function GetMesorregioes: TObjectList<TJSONIBGEMesorregiao>;
  public
    constructor Create(pJSONValue: TJSONValue; aDefault: string); overload;
    property Mesorregioes: TObjectList<TJSONIBGEMesorregiao> read GetMesorregioes;
  end;

implementation

uses
  REST.Client;

{ TJSONIBGEMesorregioes }

constructor TJSONIBGEMesorregioes.Create(pJSONValue: TJSONValue; aDefault: string);
var
  vJSONUnMarshal: TJSONUnMarshal;
begin
  inherited Create;

  if pJSONValue is TJSONArray then
  begin
    vJSONUnMarshal := TJSONUnMarshal.Create;
    try
      vJSONUnMarshal.SetFieldArray(Self, aDefault, (pJSONValue as TJSONArray));
    finally
      vJSONUnMarshal.Free;
    end;

    Exit;
  end;

  Self := TJson.JsonToObject<TJSONIBGEMesorregioes>(TJSONObject(pJSONValue));
end;

function TJSONIBGEMesorregioes.GetMesorregioes: TObjectList<TJSONIBGEMesorregiao>;
var
  vElemento: TJSONIBGEMesorregiao;
  vListaMesorregioes: TObjectList<TJSONIBGEMesorregiao>;
begin
  vListaMesorregioes := TObjectList<TJSONIBGEMesorregiao>.Create;

  for vElemento in FMesorregioesArray do
  begin
    vListaMesorregioes.Add(vElemento);
  end;

  Result := vListaMesorregioes;
end;

end.
