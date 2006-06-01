
@x
@!err_help:str_number; {a string set up by \&{errhelp}}
@y
@!err_help:str_number; {a string set up by \&{errhelp}}
@!filename_template:str_number; {a string set up by \&{filenametemplate}}
@z

@x
help_ptr:=0; use_err_help:=false; err_help:=0;
@y
help_ptr:=0; use_err_help:=false; err_help:=0; filename_template:=0;
@z

@x
@d err_help_code=2
@y
@d err_help_code=2
@d filename_template_code=3
@d print_with_leading_zeroes(#)== g := pool_ptr; 
              print_int(#); g := pool_ptr-g;
              if f>g then begin
                pool_ptr := pool_ptr - g;
                while f>g do begin 
                  print_char("0");
                  decr(f);
                  end;
                print_int(#);
              end;
              f := 0
@z

@x
primitive("errhelp",message_command,err_help_code);@/
@!@:err_help_}{\&{errhelp} primitive@>
@y
primitive("errhelp",message_command,err_help_code);@/
@!@:err_help_}{\&{errhelp} primitive@>
primitive("filenametemplate",message_command,filename_template_code);@/
@!@:filename_template_}{\&{filenametemplate} primitive@>
@z

@x
  else print("errhelp");
@y
  else if m=filename_template_code then print("filenametemplate")
  else print("errhelp");
@z

@x
  err_help_code:@<Save string |cur_exp| as the |err_help|@>;
@y
  err_help_code:@<Save string |cur_exp| as the |err_help|@>;
  filename_template_code:@<Save the filename template@>;
@z

@x
procedure open_output_file;
var @!c:integer; {\&{charcode} rounded to the nearest integer}
@!old_setting:0..max_selector; {previous |selector| setting}
@!s:str_number; {a file extension derived from |c|}
begin if job_name=0 then open_log_file;
c:=round_unscaled(internal[char_code]);
if c<0 then s:=".ps"
else @<Use |c| to compute the file extension |s|@>;
pack_job_name(s);
while not a_open_out(ps_file) do
  prompt_file_name("file name for output",s);
delete_str_ref(s);
@y
procedure open_output_file;
label @!continue; { after a digit is seen}
var @!c:integer; {\&{charcode} rounded to the nearest integer}
@!old_setting:0..max_selector; {previous |selector| setting}
@!s,n:str_number; {a file extension derived from |c|}
@!i:pool_pointer; { indexes into |filename_template| }
@!f,g:integer; {field widths}
begin if job_name=0 then open_log_file;
if filename_template=0 then begin
  c:=round_unscaled(internal[char_code]);
  if c<0 then s:=".ps"
  else @<Use |c| to compute the file extension |s|@>;
  pack_job_name(s);
  while not a_open_out(ps_file) do
    prompt_file_name("file name for output",s);
  end
else begin 
  {initializations}
  s := "";
  n := "";
  old_setting:=selector; selector:=new_string;
  f := 0;
  i := str_start[filename_template];
  while i<str_stop(filename_template) do begin
    if so(str_pool[i])="%" then begin
    continue:
      incr(i);
      if i<str_stop(filename_template) then
        begin 
          if so(str_pool[i])="j" then 
            print(job_name)
          else if so(str_pool[i])="d" then begin
             c:= round_unscaled(internal[day]);
             print_with_leading_zeroes(c);
             end
          else if so(str_pool[i])="m" then begin
             c:= round_unscaled(internal[month]);
             print_with_leading_zeroes(c);
             end
          else if so(str_pool[i])="y" then begin
             c:= round_unscaled(internal[year]);
             print_with_leading_zeroes(c);
             end
          else if so(str_pool[i])="H" then begin
             c:= round_unscaled(internal[time]) div 60;
             print_with_leading_zeroes(c);
             end
          else if so(str_pool[i])="M" then begin
             c:= round_unscaled(internal[time]) mod 60; 
             print_with_leading_zeroes(c);
             end
          else if so(str_pool[i])="c" then begin
            c:=round_unscaled(internal[char_code]);
            if c<0 then print("ps")
            else begin 
              print_with_leading_zeroes(c);
              end;
            end 
          else if (so(str_pool[i])>="0") and (so(str_pool[i])<="9") then begin
            if (f<10)  then
              f := (f*10) + so(str_pool[i])-"0";
            goto continue;
            end
          else
            print(str_pool[i])
        end
      end 
    else begin 
      if so(str_pool[i])="." then 
        if n="" then
          n := make_string;
      print(str_pool[i]);
      end;
    incr(i);
    end;  
  s := make_string;
  selector:= old_setting;
  if n="" then begin 
     n:=s;
     s:="";
  end;
  pack_file_name(n,"",s);
  while not a_open_out(ps_file) do
    prompt_file_name("file name for output",s);
  delete_str_ref(n);
  end;
delete_str_ref(s);
@z

@x
@* \[48] System-dependent changes.
@y
@ Saving the filename template

@<Save the filename template@>=
begin if filename_template<>0 then delete_str_ref(filename_template);
if length(cur_exp)=0 then filename_template:=0
else  begin filename_template:=cur_exp; add_str_ref(filename_template);
  end;
end
@* \[48] System-dependent changes.
@z