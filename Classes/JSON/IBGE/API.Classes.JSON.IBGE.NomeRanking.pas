unit API.Classes.JSON.IBGE.NomeRanking;

interface

uses
  REST.Json, REST.Json.Types, REST.JsonReflect, System.Generics.Collections,
  System.JSON, System.StrUtils, System.Classes, System.SysUtils, REST.Client;

type
  TJSONIBGEResRanking = class
  private
    [JSONName('nome')]
    FNome: string;
    [JSONName('frequencia')]
    FFrequencia: Integer;
    [JSONName('ranking')]
    FRanking: Integer;
  public
    property Nome: string read FNome write FNome;
    property Frequencia: Integer read FFrequencia write FFrequencia;
    property Ranking: Integer read FRanking write FRanking;
  end;

  TJSONIBGENomeRanking = class
  private
    [JSONName('localidade')]
    FLocalidade: string;
    [JSONName('sexo')]
    FSexo: string;
    [JSONName('res')]
    FRes: TArray<TJSONIBGEResRanking>;
  public
    destructor Destroy; override;
    property Localidade: string read FLocalidade write FLocalidade;
    property Sexo: string read FSexo write FSexo;
    property Res: TArray<TJSONIBGEResRanking> read FRes write FRes;
  end;

  TIbgeNomesRankings = class
  private
    [JSONName('nome-ranking'), JSONMarshalled(false)]
    FNomesRankingArray: TArray<TJSONIBGENomeRanking>;
    function GetNomesRanking: TJSONIBGENomeRanking;
  public
    constructor Create(pJSONValue: TJSONValue; aDefault: string); overload;
    destructor Destroy; override;
    property NomesRanking: TJSONIBGENomeRanking read GetNomesRanking;
  end;

implementation

{ TIbgeNomesRankings }

constructor TIbgeNomesRankings.Create(pJSONValue: TJSONValue; aDefault: string);
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

  Self := TJson.JsonToObject<TIbgeNomesRankings>(TJSONObject(pJSONValue));
end;

destructor TIbgeNomesRankings.Destroy;
begin
  for var lNomes in FNomesRankingArray do
  begin
    FreeAndNil(lNomes);
  end;

  inherited;
end;

function TIbgeNomesRankings.GetNomesRanking: TJSONIBGENomeRanking;
begin
  Result := FNomesRankingArray[0];
end;

{ TJSONIBGENomeRanking }

destructor TJSONIBGENomeRanking.Destroy;
begin
  for var lRes in FRes do
  begin
    FreeAndNil(lRes);
  end;

  inherited;
end;

end.
