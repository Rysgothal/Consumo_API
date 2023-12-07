unit API.Classes.JSON.IBGE.NomeFrequencia;

interface

uses
  REST.Json, REST.Json.Types, REST.JsonReflect, System.Generics.Collections,
  System.JSON, System.StrUtils, System.Classes, System.SysUtils, REST.Client;

type
  TJSONIBGEResFrequencia = class
  private
    [JSONName('periodo')]
    FPeriodo: string;
    [JSONName('frequencia')]
    FFrequencia: Integer;
  public
    property Periodo: string read FPeriodo write FPeriodo;
    property Frequencia: Integer read FFrequencia write FFrequencia;
  end;

  TJSONIBGENomeFrequencia = class
  private
    [JSONName('nome')]
    FNome: string;
    [JSONName('sexo')]
    FSexo: string;
    [JSONName('localidade')]
    FLocalidade: string;
    [JSONName('res')]
    FRes: TArray<TJSONIBGEResFrequencia>;
  public
    property Nome: string read FNome write FNome;
    property Sexo: string read FSexo write FSexo;
    property Localidade: string read FLocalidade write FLocalidade;
    property Res: TArray<TJSONIBGEResFrequencia> read FRes write FRes;
    destructor Destroy; override;
  end;

  TJSONIBGENomesFrequecias = class
  private
    [JSONName('nome-frequencia'), JSONMarshalled(false)]
    FNomesArray: TArray<TJSONIBGENomeFrequencia>;
    function GetNomesFrequencias: TObjectList<TJSONIBGENomeFrequencia>;
  public
    constructor Create(pJSONValue: TJSONValue; aDefault: string); overload;
    destructor Destroy; override;
    property NomesFrequencias: TObjectList<TJSONIBGENomeFrequencia> read GetNomesFrequencias;
  end;

implementation

{ TJSONIBGENomesFrequecias }

constructor TJSONIBGENomesFrequecias.Create(pJSONValue: TJSONValue; aDefault: string);
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

  Self := TJson.JsonToObject<TJSONIBGENomesFrequecias>(TJSONObject(pJSONValue));
end;

destructor TJSONIBGENomesFrequecias.Destroy;
begin
  for var lNomes in FNomesArray do
  begin
    FreeAndNil(lNomes);
  end;

  inherited;
end;

function TJSONIBGENomesFrequecias.GetNomesFrequencias: TObjectList<TJSONIBGENomeFrequencia>;
var
  vElemento: TJSONIBGENomeFrequencia;
  vListaNomes: TObjectList<TJSONIBGENomeFrequencia>;
begin
  vListaNomes := TObjectList<TJSONIBGENomeFrequencia>.Create;

  for vElemento in FNomesArray do
  begin
    vListaNomes.Add(vElemento);
  end;

  Result := vListaNomes;
end;

{ TJSONIBGENomeFrequencia }

destructor TJSONIBGENomeFrequencia.Destroy;
begin
  for var lRes in FRes do
  begin
    FreeAndNil(lRes);
  end;

  inherited;
end;

end.
