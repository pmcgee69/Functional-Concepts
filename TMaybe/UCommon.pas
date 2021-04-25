unit UCommon;

interface
uses
  System.Classes, System.SysUtils, Rtti;

type
  Tday               = (mon, tue, wed, thu, fri, sat, sun);
  day_strs           = array [Tday] of string;

const
  Default_Report_day = mon;
var
  report_day : Tday  = Default_Report_day;
  days : day_strs    = ('M',   'TU',  'W',   'TH',  'F',   'SAT', 'SUN');
  daym : day_strs    = ('MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN');
  dayl : day_strs    = ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY',
                                  'FRIDAY' , 'SATURDAY' , 'SUNDAY'     );

type Tmaybe<T> = record
         ok    : boolean;
         value : T
     end;

var  mDay : Tmaybe<Tday>;

function  get_mbday (s:string) : Tmaybe<Tday>;

function  writer(d : Tday) : string;

procedure Test_Maybe;


implementation

function get_mbday(s:string) : Tmaybe<Tday>;
begin
   var d : Tday := Default_Report_day;
   s := s.toupper;
   get_mbday.ok    := true;
   get_mbday.value := d;

   if s<>'' then
      while (s <> days[d]) and
            (s <> daym[d]) and
            (d <= sun) do begin
               inc(d);
               get_mbday.value := d;
      end;
   if d > sun then get_mbday.ok := false;
end;


function writer(d : Tday) : string;
begin
  result := Tvalue.From< Tday >(d).tostring;
end;


procedure Test_Maybe;

  procedure run_test(s : string);
    var d:Tmaybe<Tday>;
  begin
    d := get_mbday(s);
    write('[',s,']',#9);
    if d.ok then  write(' ok        - ', writer(d.value) )
            else  write('     nok   - ');
    writeln;
  end;

begin
  run_test('m'  );
  run_test(''   );
  run_test('TH' );
  run_test('ww' );
  run_test('mon');
  run_test('xxx');
  run_test('SAT');
  run_test('Egypt');
  writeln;
end;

end.



