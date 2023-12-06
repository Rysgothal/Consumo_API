unit API.Classes.JSON.IBGE.Metadados;

interface

uses
  REST.Json, REST.Json.Types, REST.JsonReflect, System.Generics.Collections,
  System.JSON, System.StrUtils, System.Classes, System.SysUtils, REST.Client;

type
  TJSONIBGEUnidade = class
  private
    [JSONName('id')]
    FId: string;
    [JSONName('nome')]
    FNome: string;
  public
    property Id: string read FId write FId;
    property Nome: string read FNome write FNome;
  end;

  TJSONIBGEArea = class
  private
    [JSONName('dimensao')]
    FDimensao: string;
    [JSONName('unidade')]
    FUnidade: TJSONIBGEUnidade;
  public
    property Dimensao: string read FDimensao write FDimensao;
    property Unidade: TJSONIBGEUnidade read FUnidade write FUnidade;
  end;

  TJSONIBGECoordenadas = class
  private
    [JSONName('longitude')]
    FLongitude: string;
    [JSONName('latitude')]
    FLatitude: string;
  public
    property Longitude: string read FLongitude write FLongitude;
    property Latitude: string read FLatitude write FLatitude;
  end;

  TJSONIBGEMetadado = class
  private
    [JSONName('id')]
    FId: string;
    [JSONName('nivel-geografico')]
    FNivelGeografico: string;
    [JSONName('centroide')]
    FCentroide: TJSONIBGECoordenadas;
    [JSONName('regiao-limitrofe')]
    FRegiaoLimitrofe: TArray<TJSONIBGECoordenadas>;
    [JSONName('area')]
    FArea: TJSONIBGEArea;
  public
    property Id: string read FId write FId;
    property NivelGeografico: string read FNivelGeografico write FNivelGeografico;
    property Centroide: TJSONIBGECoordenadas read FCentroide write FCentroide;
    property RegiaoLimitrofe: TArray<TJSONIBGECoordenadas> read FRegiaoLimitrofe write FRegiaoLimitrofe;
    property Area: TJSONIBGEArea read FArea write FArea;
  end;

  TJSONIBGEMetadados = class
  private
    [JSONName('metadados'), JSONMarshalled(false)]
    FMesorregioesArray: TArray<TJSONIBGEMetadado>;
    function GetMetadados: TObjectList<TJSONIBGEMetadado>;
  public
    constructor Create(pJSONValue: TJSONValue; aDefault: string); overload;
    property Metadados: TObjectList<TJSONIBGEMetadado> read GetMetadados;
  end;

implementation

{ TJSONIBGEMetadados }

constructor TJSONIBGEMetadados.Create(pJSONValue: TJSONValue; aDefault: string);
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

  Self := TJson.JsonToObject<TJSONIBGEMetadados>(TJSONObject(pJSONValue));
end;

function TJSONIBGEMetadados.GetMetadados: TObjectList<TJSONIBGEMetadado>;
var
  vElemento: TJSONIBGEMetadado;
  vListaMesorregioes: TObjectList<TJSONIBGEMetadado>;
begin
  vListaMesorregioes := TObjectList<TJSONIBGEMetadado>.Create;

  for vElemento in FMesorregioesArray do
  begin
    vListaMesorregioes.Add(vElemento);
  end;

  Result := vListaMesorregioes;
end;

end.
