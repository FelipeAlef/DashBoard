unit uDaoUtils;

interface

uses FireDAC.Comp.Client, FireDac.DApt, FireDAC.Stan.Def, FireDAC.Phys.MySQL, FireDAC.Stan.Async, uUtils, System.JSON, DataSet.Serialize, System.Generics.Collections,
  ORM.Attributes, ORM.Mapper;

type
  IDao = interface
    ['{50DED34F-7782-448A-A1A4-ACA43A2CE6B1}']
    function GetConexao: TFDConnection;
    function ExecCommandQuery(const pCommand: string; const pArgs: array of Variant): Boolean;
    function GetCountQuery(const pCommand: string; const pArgs: array of Variant): Integer;
    function GetQuery(FC:TFDConnection): TFDQuery; overload;
    function GetQuery<T: IInterface>(const pCommand: string; const pArgs: array of Variant): TList<T>; overload;
    function GetQuery<T: IInterface>(const pArgs: array of Variant; const pCommand: string): T;
  end;

  TDao = class(TInterfacedObject, IDao)
  private
  public
    constructor Create;
    destructor Destroy; override;
    class function New : IDao;

    function GetConexao: TFDConnection;
    function ExecCommandQuery(const pCommand: string; const pArgs: array of Variant): Boolean;
    function GetCountQuery(const pCommand: string; const pArgs: array of Variant): Integer;
    function GetQuery(FC:TFDConnection): TFDQuery; overload;
    function GetQuery<T: IInterface>(const pCommand: string; const pArgs: array of Variant): TList<T>; overload;
    function GetQuery<T: IInterface>(const pArgs: array of Variant; const pCommand: string): T;
  end;

implementation

{ TDao }

uses uConfig, System.SysUtils;

constructor TDao.Create;
begin

end;

destructor TDao.Destroy;
begin

  inherited;
end;

function TDao.ExecCommandQuery(const pCommand: string; const pArgs: array of Variant): Boolean;
var
  qryTemp : TFDQuery;
  FC : TFDConnection;
begin
  try
    try
      FC := GetConexao;
      qryTemp := GetQuery(FC);
      Result := (QryTemp.ExecSQL(pCommand, pArgs) > 0);
    except
      on E : Exception do
      begin
        TUtils.AddLog(GetCurrentDir+'\LogErroDao.log', 'Erro no metodo ExecCommandQuery - Error: ' + E.Message);
        raise Exception.Create('Erro no metodo ExecCommandQuery - Error: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qryTemp);
    FreeAndNil(FC);
  end;
end;

function TDao.GetConexao: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.LoginPrompt := False;

  with Result.Params do
  begin
    DriverID := 'MySQL';
    Database := TConfig.New.Configuracao('Database','Nome');
    UserName := TConfig.New.Configuracao('Database','Usuario');
    Password := TConfig.New.Configuracao('Database','Senha');
    Values['Server'] := TConfig.New.Configuracao('Database','Endereco');
    Values['Port']   := TConfig.New.Configuracao('Database','Porta');
  end;
end;

function TDao.GetCountQuery(const pCommand: string; const pArgs: array of Variant): Integer;
var
  Qr :TFDQuery;
  FC :TFDConnection;
begin
  try
    try
      Result := 0;
      FC := GetConexao;
      Qr := GetQuery(FC);
      Qr.Open(pCommand, pArgs);
      Result := Qr.Fields.Fields[0].AsInteger;
    except
      on E : Exception do
      begin
        TUtils.AddLog(GetCurrentDir+'\LogErroDao.log', 'Erro no metodo GetCountQuery - Error: ' + E.Message);
        raise Exception.Create('Erro no metodo GetCountQuery.' + E.Message);
      end;
    end;
  finally
    FreeAndNil(Qr);
    FreeAndNil(FC);
  end;
end;

function TDao.GetQuery(FC: TFDConnection): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := FC;
  Result.Close;
  Result.SQL.Clear;
end;

function TDao.GetObject<T: class, constructor>(const pCommand: string; const pArgs: array of Variant): T;
var
  Qr: TFDQuery;
  FC: TFDConnection;
begin
  FC := GetConexao;
  Qr := GetQuery(FC);
  try
    Qr.Open(pCommand, pArgs);
    Result := TObjectMapper.DataSetToObject<T>(Qr);
  finally
    Qr.Free;
    FC.Free;
  end;
end;

function TDao.GetList<T: class, constructor>(const pCommand: string; const pArgs: array of Variant): TObjectList<T>;
var
  Qr: TFDQuery;
  FC: TFDConnection;
begin
  FC := GetConexao;
  Qr := GetQuery(FC);
  try
    Qr.Open(pCommand, pArgs);
    Result := TObjectMapper.DataSetToList<T>(Qr);
  finally
    Qr.Free;
    FC.Free;
  end;
end;

class function TDao.New: IDao;
begin
  Result := Self.Create;
end;

end.
