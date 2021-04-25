program Maybe_Example;
{$APPTYPE CONSOLE}
uses
  System.SysUtils,
  System.IOUtils,
  System.Classes,
  UCommon in 'UCommon.pas';

function Get_Report_Day : boolean;
var s     : string;
    mbday : Tmaybe<Tday>;
begin
    result := true;

    if paramcount() = 1 then s := paramstr(1)
    else begin
       write('Report for what day?  <', days[report_day], '>  ');
       readln(s);
    end;

    mbday := get_mbday(s.ToUpper);

    if mbday.ok then
       report_day := mbday.value
    else begin
       writeln;
       writeln('Invalid day specified.');
       result := false;
    end;
end;


begin
  Test_Maybe;
  writeln;

  if Get_Report_Day then begin
     writeln;
     writeln( 'Returned day enum : ',writer(report_day) );
  end;

  writeln;
  readln;
end.
