unit uSession;

interface

type
  iSession = interface
    ['{14712DD9-1CCB-4638-850A-579779FDE066}']

    //Funções de validação de empresa e usuário
    function ValidaEmpresa(Const NomeEmpresa: String):iSession;
    function ValidaLogin(Const Usuario, Senha:String):iSession;
    function ValidaPermissao(Const UsuarioID : Integer; Const Permissao : String):Boolean;

    //Dados da empresa e usuário logado ao sistema
    function EmpresaID:Integer;
    function EmpresaNome:String;
    function UsuarioID:Integer;
    function UsuarioNome:String;
  end;

  TSession = class(TInterfacedObject, iSession)
  private
    FEmpresaID : Integer;
    FEmpresaNome : String;
    FUsuarioID : Integer;
    FUsuarioNome : String;
  public
    function ValidaEmpresa(Const NomeEmpresa: String):iSession;
    function ValidaLogin(Const Usuario, Senha:String):iSession;
    function ValidaPermissao(Const UsuarioID : Integer; Const Permissao : String):Boolean;

    function EmpresaID:Integer;
    function EmpresaNome:String;
    function UsuarioID:Integer;
    function UsuarioNome:String;
    class function new : iSession;
  end;

implementation

{ TSession }

class function TSession.new: iSession;
begin
  Result := Self.Create;
end;

function TSession.EmpresaID: Integer;
begin

end;

function TSession.EmpresaNome: String;
begin

end;

function TSession.UsuarioID: Integer;
begin

end;

function TSession.UsuarioNome: String;
begin

end;

function TSession.ValidaEmpresa(const NomeEmpresa: String): iSession;
begin

end;

function TSession.ValidaLogin(const Usuario, Senha: String): iSession;
begin

end;

function TSession.ValidaPermissao(const UsuarioID: Integer; const Permissao: String): Boolean;
begin

end;

end.
