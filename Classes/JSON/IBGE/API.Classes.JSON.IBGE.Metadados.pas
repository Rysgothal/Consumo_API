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
    destructor Destroy; override;
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
    destructor Destroy; override;
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
    FMesorregioesLista: TObjectList<TJSONIBGEMetadado>;
    function GetMetadados: TObjectList<TJSONIBGEMetadado>;
  public
    constructor Create(pJSONValue: TJSONValue; aDefault: string); overload;
    destructor Destroy; override;
    property Metadados: TObjectList<TJSONIBGEMetadado> read GetMetadados;
  end;

implementation

{ TJSONIBGEMetadados }

constructor TJSONIBGEMetadados.Create(pJSONValue: TJSONValue; aDefault: string);
var
  lJSONUnMarshal: TJSONUnMarshal;
begin
  inherited Create;
  FMesorregioesLista := TObjectList<TJSONIBGEMetadado>.Create;

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

  Self := TJson.JsonToObject<TJSONIBGEMetadados>(TJSONObject(pJSONValue));
end;

destructor TJSONIBGEMetadados.Destroy;
begin
  for var lMetadado in FMesorregioesArray do
  begin
    FreeAndNil(lMetadado);
  end;

  FMesorregioesArray := nil;
  FMesorregioesLista.FreeInstance;
  inherited;
end;

function TJSONIBGEMetadados.GetMetadados: TObjectList<TJSONIBGEMetadado>;
begin
  for var lElemento in FMesorregioesArray do
  begin
    FMesorregioesLista.Add(lElemento);
  end;

  Result := FMesorregioesLista;
end;

{ TJSONIBGEArea }

destructor TJSONIBGEArea.Destroy;
begin
  FreeAndNil(FUnidade);
  inherited;
end;

{ TJSONIBGEMetadado }

destructor TJSONIBGEMetadado.Destroy;
begin
  for var lRegiao in FRegiaoLimitrofe do
  begin
    FreeAndNil(lRegiao);
  end;

  FreeAndNil(FCentroide);
  FreeAndNil(FArea);
  inherited;
end;

end.
