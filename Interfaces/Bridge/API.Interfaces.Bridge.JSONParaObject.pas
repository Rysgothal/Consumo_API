unit API.Interfaces.Bridge.JSONParaObject;

interface

uses
  System.JSON;

type
  ITransformar = interface
    function ParaObjeto(const pJSON: TJSONValue): TObject;
  end;

  implementation

end.
