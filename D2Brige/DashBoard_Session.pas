unit DashBoard_Session;

interface

uses
  SysUtils, Classes,
  Prism.SessionBase, uSession;

type
  TDashBoardSession = class(TPrismSessionBase)
  private
    FPrisSession : TPrismSession;
    function SubDominio(URL:String):String;
  public
   constructor Create(APrismSession: TPrismSession); override;  //OnNewSession
   destructor Destroy; override; //OnCloseSession
  end;


implementation

Uses
  D2Bridge.Instance,
  DashBoardWebApp;

{$IFNDEF FPC}
{$R *.dfm}
{$ELSE}
{$R *.lfm}
{$ENDIF} 

constructor TDashBoardSession.Create(APrismSession: TPrismSession); //OnNewSession
begin
  inherited;
  FPrisSession := APrismSession;
  TSession.new.ValidaEmpresa(SubDominio(APrismSession.URI.Host));
end;

destructor TDashBoardSession.Destroy; //OnCloseSession
begin
 //Close ALL DataBase connection
 //Ex: Dm.DBConnection.Close;

 inherited;
end;

function TDashBoardSession.SubDominio(URL: String): String;
begin
  Result := Copy(URL, 1, Pos('.', URL) - 1);
end;

end.

