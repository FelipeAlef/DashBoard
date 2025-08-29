unit uConfig;

interface

uses
  IniFiles, System.SysUtils;

type
  IConfig = interface
    ['{D7726660-665C-413F-9498-83190CECA2A0}']
    function Configuracao(const Grupo, Config, Valor: String):IConfig; overload;
    function Configuracao(const Grupo, Config:String): String; overload;
  end;

  TConfig = Class(TInterfacedObject, IConfig)
  public
    constructor Create;
    destructor Destroy; override;
    class function New:IConfig;

    function Configuracao(const Grupo, Config, Valor: String):IConfig; overload;
    function Configuracao(const Grupo, Config:String): String; overload;
  end;

implementation

{ TConfig }

function TConfig.Configuracao(const Grupo,Config:String): String;
var
  loIniFIle : TInifile;
begin
  if FileExists(GetCurrentDir + '\Config.ini') then
  begin
    loIniFIle := TInifile.Create(GetCurrentDir + '\Config.ini');
    Result := loIniFile.ReadString(Grupo,Config, '');
    loIniFile.Free;
  end;
end;

function TConfig.Configuracao(const Grupo, Config, Valor: String):IConfig;
var loIniFIle : TInifile;
begin
  loIniFIle := tIniFile.Create(GetCurrentDir + '\Config.ini');
  loIniFile.WriteString(Grupo, Config, Valor);
  loIniFile.Free;
end;

constructor TConfig.Create;
begin

end;

destructor TConfig.Destroy;
begin

  inherited;
end;

class function TConfig.New: IConfig;
begin
  Result := Self.Create;
end;

end.

