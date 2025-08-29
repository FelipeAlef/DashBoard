unit ORM.Mapper;

interface

uses
  System.SysUtils, System.Rtti, System.TypInfo, Data.DB,
  System.Generics.Collections, ORM.Attributes;

type
  TObjectMapper = class
  public
    class function DataSetToObject<T: class, constructor>(ADataSet: TDataSet): T;
    class function DataSetToList<T: class, constructor>(ADataSet: TDataSet): TObjectList<T>;
  end;

implementation

class function TObjectMapper.DataSetToObject<T>(ADataSet: TDataSet): T;
var
  Ctx: TRttiContext;
  Typ: TRttiType;
  Prop: TRttiProperty;
  Attr: TCustomAttribute;
  ColName: string;
begin
  Result := T.Create;
  if not Assigned(ADataSet) then Exit;

  Ctx := TRttiContext.Create;
  try
    Typ := Ctx.GetType(Result.ClassType);

    for Prop in Typ.GetProperties do
    begin
      for Attr in Prop.GetAttributes do
        if Attr is ColumnAttribute then
        begin
          ColName := ColumnAttribute(Attr).Name;
          if ADataSet.FindField(ColName) <> nil then
            Prop.SetValue(Result, TValue.FromVariant(ADataSet.FieldByName(ColName).Value));
        end;
    end;
  finally
    Ctx.Free;
  end;
end;

class function TObjectMapper.DataSetToList<T>(ADataSet: TDataSet): TObjectList<T>;
begin
  Result := TObjectList<T>.Create(True);
  ADataSet.First;
  while not ADataSet.Eof do
  begin
    Result.Add(DataSetToObject<T>(ADataSet));
    ADataSet.Next;
  end;
end;

end.

