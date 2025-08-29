unit uDaoConexao;

interface

uses FireDAC.Comp.Client, FireDac.DApt, Data.DB, uDaoUtils;


type

  iDaoConexao = interface
    ['{FE570459-442C-44D3-909E-31E790D000CD}']
    function Connect : TCustomConnection;
  end;

  TDaoConexao = class(TInterfacedObject, iDaoConexao)
  private
    FConn : TFDConnection;
  public
    constructor create;
    destructor destroy; override;
    class function new:iDaoConexao;
    function Connect : TCustomConnection;
  end;

implementation

{ TDaoConexao }

function TDaoConexao.Connect: TCustomConnection;
begin
  Result := FConn;
end;

constructor TDaoConexao.create;
begin
  FConn := TDao.New.GetConexao;
end;

destructor TDaoConexao.destroy;
begin
  FConn.Free;
  inherited;
end;

class function TDaoConexao.new: iDaoConexao;
begin
  Result := Self.create;
end;

end.
