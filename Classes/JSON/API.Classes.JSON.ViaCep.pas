unit API.Classes.JSON.ViaCep;

interface

uses
//  REST.Json,
  REST.Json.Types;
//  REST.JsonReflect,
//  System.Generics.Collections,
//  System.JSON,
//  System.StrUtils,
//  System.Classes,
//  System.SysUtils,
//  REST.Client;

type
  TJSONViaCep = class
  private
    [JSONName('cep')]
    FCep: string;
    [JSONName('logradouro')]
    FLogradouro: string;
    [JSONName('complemento')]
    FComplemento: string;
    [JSONName('bairro')]
    FBairro: string;
    [JSONName('localidade')]
    FCidade: string;
    [JSONName('uf')]
    FUf: string;
    [JSONName('ibge')]
    FIbge: Integer;
    [JSONName('gia')]
    FGia: Integer;
    [JSONName('ddd')]
    FDdd: Integer;
    [JSONName('siafi')]
    FSiafi: Integer;
  public
    property Cep: string read FCep write FCep;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Complemento: string read FComplemento write FComplemento;
    property Bairro: string read FBairro write FBairro;
    property Cidade: string read FCidade write FCidade;
    property Uf: string read FUf write FUf;
    property Ibge: Integer read FIbge write FIbge;
    property Gia: Integer read FGia write FGia;
    property Ddd: Integer read FDdd write FDdd;
    property Siafi: Integer read FSiafi write FSiafi;
  end;

implementation

end.
