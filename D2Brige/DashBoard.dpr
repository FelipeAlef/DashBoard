program DashBoard;

{$IFDEF D2BRIDGE}
 {$APPTYPE CONSOLE}
{$ENDIF}



uses
  Vcl.Forms,
  D2Bridge.ServerControllerBase in 'C:\Delphi\D12\D2Bridge\D2Bridge Framework\D2Bridge.ServerControllerBase.pas' {D2BridgeServerControllerBase: TDataModule},
  Prism.SessionBase in 'C:\Delphi\D12\D2Bridge\D2Bridge Framework\Prism\Prism.SessionBase.pas' {PrismSessionBase: TPrismSessionBase},
  DashBoardWebApp in 'DashBoardWebApp.pas' {DashBoardWebAppGlobal},
  DashBoard_Session in 'DashBoard_Session.pas' {DashBoardSession},
  D2BridgeFormTemplate in 'D2BridgeFormTemplate.pas',
  Unit_D2Bridge_Server_Console in 'Unit_D2Bridge_Server_Console.pas',
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  uSession in 'Src\Session\uSession.pas',
  uConfig in 'Src\Config\uConfig.pas',
  uDaoConexao in 'Src\Dao\uDaoConexao.pas',
  uDaoUtils in 'Src\Dao\uDaoUtils.pas',
  uUtils in 'Src\Utils\uUtils.pas',
  ORM.Mapper in 'Src\Dao\ORM.Mapper.pas',
  ORM.Attributes in 'Src\Dao\ORM.Attributes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar:= False;
  TD2BridgeServerConsole.Run
  
end.
