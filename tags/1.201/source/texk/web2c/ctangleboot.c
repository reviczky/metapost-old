/*1:*/
#line 64 "./cwebdir/ctangle.w"

/*5:*/
#line 35 "./cwebdir/common.h"

#line 93 "./cwebdir/ctang-w2c.ch"
#include <stdio.h> 

extern char*versionstring;
#include <kpathsea/kpathsea.h> 
#line 37 "./cwebdir/common.h"

/*:5*//*61:*/
#line 888 "./cwebdir/ctangle.w"

#line 890 "./cwebdir/ctangle.w"
#include <stdlib.h>  

/*:61*/
#line 65 "./cwebdir/ctangle.w"

#define banner "This is CTANGLE, Version 3.64" \

#define max_bytes 90000 \

#define max_toks 270000
#define max_names 4000 \

#define max_texts 2500
#define hash_size 353
#define longest_name 10000
#define stack_size 50
#define buf_size 100 \

#define ctangle 0
#define cweave 1 \

#define and_and 04
#define lt_lt 020
#define gt_gt 021
#define plus_plus 013
#define minus_minus 01
#define minus_gt 031
#define not_eq 032
#define lt_eq 034
#define gt_eq 035
#define eq_eq 036
#define or_or 037
#define dot_dot_dot 016
#define colon_colon 06
#define period_ast 026
#define minus_gt_ast 027 \

#define xisalpha(c) (isalpha(c) &&((eight_bits) c<0200) ) 
#define xisdigit(c) (isdigit(c) &&((eight_bits) c<0200) ) 
#define xisspace(c) (isspace(c) &&((eight_bits) c<0200) ) 
#define xislower(c) (islower(c) &&((eight_bits) c<0200) ) 
#define xisupper(c) (isupper(c) &&((eight_bits) c<0200) ) 
#define xisxdigit(c) (isxdigit(c) &&((eight_bits) c<0200) )  \

#define length(c) (c+1) ->byte_start-(c) ->byte_start
#define print_id(c) term_write((c) ->byte_start,length((c) ) ) 
#define llink link
#define rlink dummy.Rlink
#define root name_dir->rlink \

#define chunk_marker 0 \

#define spotless 0
#define harmless_message 1
#define error_message 2
#define fatal_message 3
#define mark_harmless {if(history==spotless) history= harmless_message;}
#define mark_error history= error_message
#define confusion(s) fatal("! This can't happen: ",s)  \

#define max_file_name_length 1024
#define cur_file file[include_depth]
#define cur_file_name file_name[include_depth]
#define web_file_name file_name[0]
#define cur_line line[include_depth] \

#define show_banner flags['b']
#define show_progress flags['p']
#define show_happiness flags['h'] \

#define update_terminal fflush(stdout) 
#define new_line putchar('\n') 
#define putxchar putchar
#define term_write(a,b) fflush(stdout) ,fwrite(a,sizeof(char) ,b,stdout) 
#define C_printf(c,a) fprintf(C_file,c,a) 
#define C_putc(c) putc(c,C_file)  \

#define equiv equiv_or_xref \

#define section_flag max_texts \

#define string 02
#define join 0177
#define output_defs_flag (2*024000-1)  \

#define cur_end cur_state.end_field
#define cur_byte cur_state.byte_field
#define cur_name cur_state.name_field
#define cur_repl cur_state.repl_field
#define cur_section cur_state.section_field \

#define section_number 0201
#define identifier 0202 \

#define normal 0
#define num_or_id 1
#define post_slash 2
#define unbreakable 3
#define verbatim 4 \

#define max_files 256
#define translit_length 10 \

#define ignore 0
#define ord 0302
#define control_text 0303
#define translit_code 0304
#define output_defs_code 0305
#define format_code 0306
#define definition 0307
#define begin_C 0310
#define section_name 0311
#define new_section 0312 \

#define constant 03 \

#define isxalpha(c) ((c) =='_'||(c) =='$')  \

#define ishigh(c) ((unsigned char) (c) > 0177)  \
 \

#define compress(c) if(loc++<=limit) return(c)  \

#define macro 0
#define app_repl(c) {if(tok_ptr==tok_mem_end) overflow("token") ;*tok_ptr++= c;} \


#line 66 "./cwebdir/ctangle.w"

/*4:*/
#line 29 "./cwebdir/common.h"

#line 31 "./cwebdir/common.h"
typedef char unsigned eight_bits;
extern boolean program;
extern int phase;

/*:4*//*6:*/
#line 57 "./cwebdir/common.h"

char section_text[longest_name+1];
char*section_text_end= section_text+longest_name;
char*id_first;
char*id_loc;

/*:6*//*7:*/
#line 72 "./cwebdir/common.h"

extern char buffer[];
extern char*buffer_end;
extern char*loc;
extern char*limit;

/*:7*//*8:*/
#line 87 "./cwebdir/common.h"

typedef struct name_info{
char*byte_start;
struct name_info*link;
union{
struct name_info*Rlink;

char Ilk;
}dummy;
char*equiv_or_xref;
}name_info;
typedef name_info*name_pointer;
typedef name_pointer*hash_pointer;
extern char byte_mem[];
extern char*byte_mem_end;
extern name_info name_dir[];
extern name_pointer name_dir_end;
extern name_pointer name_ptr;
extern char*byte_ptr;
extern name_pointer hash[];
extern hash_pointer hash_end;
extern hash_pointer h;
#line 106 "./cwebdir/ctang-w2c.ch"

extern name_pointer id_lookup P3H(char*,char*,char);

extern name_pointer section_lookup P3H(char*,char*,char);
extern void print_section_name P1H(name_pointer);
extern void sprint_section_name P2H(char*,name_pointer);
#line 112 "./cwebdir/common.h"

/*:8*//*9:*/
#line 122 "./cwebdir/common.h"

#line 123 "./cwebdir/ctang-w2c.ch"
extern int history;
extern void err_print P1H(char*);
extern int wrap_up P1H(void);
extern void fatal P2H(char*,char*);
extern void overflow P1H(char*);
#line 128 "./cwebdir/common.h"

/*:9*//*10:*/
#line 137 "./cwebdir/common.h"

#line 141 "./cwebdir/ctang-w2c.ch"
extern int include_depth;
#line 139 "./cwebdir/common.h"
extern FILE*file[];
extern FILE*change_file;
extern char C_file_name[];
extern char tex_file_name[];
extern char idx_file_name[];
extern char scn_file_name[];
extern char file_name[][max_file_name_length];

extern char change_file_name[];
#line 148 "./cwebdir/ctang-w2c.ch"
extern int line[];
extern int change_line;
#line 150 "./cwebdir/common.h"
extern boolean input_has_ended;
extern boolean changing;
extern boolean web_file_open;
#line 157 "./cwebdir/ctang-w2c.ch"
extern void reset_input P1H(void);
extern int get_line P1H(void);
extern void check_complete P1H(void);
#line 156 "./cwebdir/common.h"

/*:10*//*11:*/
#line 158 "./cwebdir/common.h"

typedef unsigned short sixteen_bits;
extern sixteen_bits section_count;
extern boolean changed_section[];
extern boolean change_pending;
extern boolean print_where;

/*:11*//*12:*/
#line 170 "./cwebdir/common.h"

extern int argc;
extern char**argv;
extern boolean flags[];

/*:12*//*13:*/
#line 182 "./cwebdir/common.h"

extern FILE*C_file;
extern FILE*tex_file;
extern FILE*idx_file;
extern FILE*scn_file;
extern FILE*active_file;

/*:13*//*14:*/
#line 191 "./cwebdir/common.h"

#line 167 "./cwebdir/ctang-w2c.ch"
extern void common_init P1H(void);
#line 128 "./cwebdir/ctangle.w"

/*:14*/
#line 67 "./cwebdir/ctangle.w"

/*15:*/
#line 152 "./cwebdir/ctangle.w"

typedef struct{
eight_bits*tok_start;
sixteen_bits text_link;
}text;
typedef text*text_pointer;

/*:15*//*26:*/
#line 296 "./cwebdir/ctangle.w"

typedef struct{
eight_bits*end_field;
eight_bits*byte_field;
name_pointer name_field;
text_pointer repl_field;
sixteen_bits section_field;
}output_state;
typedef output_state*stack_pointer;

/*:26*/
#line 68 "./cwebdir/ctangle.w"

/*16:*/
#line 159 "./cwebdir/ctangle.w"

text text_info[max_texts];
text_pointer text_info_end= text_info+max_texts-1;
text_pointer text_ptr;
eight_bits tok_mem[max_toks];
eight_bits*tok_mem_end= tok_mem+max_toks-1;
eight_bits*tok_ptr;

/*:16*//*22:*/
#line 227 "./cwebdir/ctangle.w"

text_pointer last_unnamed;

/*:22*//*27:*/
#line 312 "./cwebdir/ctangle.w"

output_state cur_state;

output_state stack[stack_size+1];
stack_pointer stack_ptr;
stack_pointer stack_end= stack+stack_size;

/*:27*//*31:*/
#line 384 "./cwebdir/ctangle.w"

int cur_val;

/*:31*//*35:*/
#line 473 "./cwebdir/ctangle.w"

eight_bits out_state;
boolean protect;

/*:35*//*37:*/
#line 502 "./cwebdir/ctangle.w"

name_pointer output_files[max_files];
name_pointer*cur_out_file,*end_output_files,*an_output_file;
char cur_section_name_char;
char output_file_name[longest_name];

/*:37*//*44:*/
#line 599 "./cwebdir/ctangle.w"

boolean output_defs_seen= 0;

/*:44*//*50:*/
#line 710 "./cwebdir/ctangle.w"

char translit[128][translit_length];

/*:50*//*55:*/
#line 789 "./cwebdir/ctangle.w"

eight_bits ccode[256];

/*:55*//*58:*/
#line 845 "./cwebdir/ctangle.w"

boolean comment_continues= 0;

/*:58*//*60:*/
#line 884 "./cwebdir/ctangle.w"

name_pointer cur_section_name;
int no_where;

/*:60*//*74:*/
#line 1195 "./cwebdir/ctangle.w"

text_pointer cur_text;
eight_bits next_control;

/*:74*//*81:*/
#line 1350 "./cwebdir/ctangle.w"

extern sixteen_bits section_count;

/*:81*/
#line 69 "./cwebdir/ctangle.w"

/*40:*/
#line 533 "./cwebdir/ctangle.w"

#line 244 "./cwebdir/ctang-w2c.ch"
void phase_two P1H(void);
#line 535 "./cwebdir/ctangle.w"

/*:40*//*45:*/
#line 602 "./cwebdir/ctangle.w"

#line 260 "./cwebdir/ctang-w2c.ch"
void output_defs P1H(void);
#line 604 "./cwebdir/ctangle.w"

/*:45*//*47:*/
#line 648 "./cwebdir/ctangle.w"

#line 276 "./cwebdir/ctang-w2c.ch"
static void out_char P1H(eight_bits);
#line 650 "./cwebdir/ctangle.w"

/*:47*//*89:*/
#line 1457 "./cwebdir/ctangle.w"

#line 342 "./cwebdir/ctang-w2c.ch"
void phase_one P1H(void);
#line 1459 "./cwebdir/ctangle.w"

/*:89*//*91:*/
#line 1475 "./cwebdir/ctangle.w"

#line 358 "./cwebdir/ctang-w2c.ch"
void skip_limbo P1H(void);
#line 1477 "./cwebdir/ctangle.w"

/*:91*/
#line 70 "./cwebdir/ctangle.w"


#line 83 "./cwebdir/ctangle.w"

/*:1*//*2:*/
#line 91 "./cwebdir/ctangle.w"

#line 70 "./cwebdir/ctang-w2c.ch"
int main P2C(int,ac,char**,av)
#line 95 "./cwebdir/ctangle.w"
{
argc= ac;argv= av;
program= ctangle;
/*17:*/
#line 167 "./cwebdir/ctangle.w"

text_info->tok_start= tok_ptr= tok_mem;
text_ptr= text_info+1;text_ptr->tok_start= tok_mem;


/*:17*//*19:*/
#line 177 "./cwebdir/ctangle.w"

name_dir->equiv= (char*)text_info;

/*:19*//*23:*/
#line 230 "./cwebdir/ctangle.w"
last_unnamed= text_info;text_info->text_link= 0;

/*:23*//*38:*/
#line 512 "./cwebdir/ctangle.w"

cur_out_file= end_output_files= output_files+max_files;

/*:38*//*51:*/
#line 713 "./cwebdir/ctangle.w"

{
int i;
for(i= 0;i<128;i++)sprintf(translit[i],"X%02X",(unsigned)(128+i));
}

/*:51*//*56:*/
#line 792 "./cwebdir/ctangle.w"
{
int c;
for(c= 0;c<256;c++)ccode[c]= ignore;
ccode[' ']= ccode['\t']= ccode['\n']= ccode['\v']= ccode['\r']= ccode['\f']
= ccode['*']= new_section;
ccode['@']= '@';ccode['=']= string;
ccode['d']= ccode['D']= definition;
ccode['f']= ccode['F']= ccode['s']= ccode['S']= format_code;
ccode['c']= ccode['C']= ccode['p']= ccode['P']= begin_C;
ccode['^']= ccode[':']= ccode['.']= ccode['t']= ccode['T']= 
ccode['q']= ccode['Q']= control_text;
ccode['h']= ccode['H']= output_defs_code;
ccode['l']= ccode['L']= translit_code;
ccode['&']= join;
ccode['<']= ccode['(']= section_name;
ccode['\'']= ord;
}

/*:56*//*70:*/
#line 1116 "./cwebdir/ctangle.w"
section_text[0]= ' ';

/*:70*/
#line 98 "./cwebdir/ctangle.w"
;
common_init();
#line 76 "./cwebdir/ctang-w2c.ch"
if(show_banner){
printf("%s%s\n",banner,versionstring);
}
#line 101 "./cwebdir/ctangle.w"
phase_one();
phase_two();
return wrap_up();
}

/*:2*//*20:*/
#line 183 "./cwebdir/ctangle.w"

#line 178 "./cwebdir/ctang-w2c.ch"
int names_match P4C(name_pointer,p,char*,first,int,l,char,t)
#line 188 "./cwebdir/ctangle.w"
{
if(length(p)!=l)return 0;
return!strncmp(first,p->byte_start,l);
}

/*:20*//*21:*/
#line 198 "./cwebdir/ctangle.w"

void
#line 187 "./cwebdir/ctang-w2c.ch"
 init_node P1C(name_pointer,node)
#line 202 "./cwebdir/ctangle.w"
{
node->equiv= (char*)text_info;
}
void
#line 193 "./cwebdir/ctang-w2c.ch"
 init_p P2C(name_pointer,p,char,t){}
#line 207 "./cwebdir/ctangle.w"

/*:21*//*25:*/
#line 260 "./cwebdir/ctangle.w"

void
#line 202 "./cwebdir/ctang-w2c.ch"
 store_two_bytes P1C(sixteen_bits,x)
#line 264 "./cwebdir/ctangle.w"
{
if(tok_ptr+2> tok_mem_end)overflow("token");
*tok_ptr++= x>>8;
*tok_ptr++= x&0377;
}

/*:25*//*29:*/
#line 336 "./cwebdir/ctangle.w"

void
#line 211 "./cwebdir/ctang-w2c.ch"
 push_level P1C(name_pointer,p)
#line 340 "./cwebdir/ctangle.w"
{
if(stack_ptr==stack_end)overflow("stack");
*stack_ptr= cur_state;
stack_ptr++;
if(p!=NULL){
cur_name= p;cur_repl= (text_pointer)p->equiv;
cur_byte= cur_repl->tok_start;cur_end= (cur_repl+1)->tok_start;
cur_section= 0;
}
}

/*:29*//*30:*/
#line 355 "./cwebdir/ctangle.w"

void
#line 220 "./cwebdir/ctang-w2c.ch"
 pop_level P1C(int,flag)
#line 359 "./cwebdir/ctangle.w"
{
if(flag&&cur_repl->text_link<section_flag){
cur_repl= cur_repl->text_link+text_info;
cur_byte= cur_repl->tok_start;cur_end= (cur_repl+1)->tok_start;
return;
}
stack_ptr--;
if(stack_ptr> stack)cur_state= *stack_ptr;
}

/*:30*//*32:*/
#line 391 "./cwebdir/ctangle.w"

void
#line 228 "./cwebdir/ctang-w2c.ch"
 get_output P1H(void)
#line 394 "./cwebdir/ctangle.w"
{
sixteen_bits a;
restart:if(stack_ptr==stack)return;
if(cur_byte==cur_end){
cur_val= -((int)cur_section);
pop_level(1);
if(cur_val==0)goto restart;
out_char(section_number);return;
}
a= *cur_byte++;
if(out_state==verbatim&&a!=string&&a!=constant&&a!='\n')
C_putc(a);
else if(a<0200)out_char(a);
else{
a= (a-0200)*0400+*cur_byte++;
switch(a/024000){
case 0:cur_val= a;out_char(identifier);break;
case 1:if(a==output_defs_flag)output_defs();
else/*33:*/
#line 423 "./cwebdir/ctangle.w"

{
a-= 024000;
if((a+name_dir)->equiv!=(char*)text_info)push_level(a+name_dir);
else if(a!=0){
printf("\n! Not present: <");
print_section_name(a+name_dir);err_print(">");

}
goto restart;
}

/*:33*/
#line 412 "./cwebdir/ctangle.w"
;
break;
default:cur_val= a-050000;if(cur_val> 0)cur_section= cur_val;
out_char(section_number);
}
}
}

/*:32*//*36:*/
#line 481 "./cwebdir/ctangle.w"

void
#line 236 "./cwebdir/ctang-w2c.ch"
 flush_buffer P1H(void)
#line 484 "./cwebdir/ctangle.w"
{
C_putc('\n');
if(cur_line%100==0&&show_progress){
printf(".");
if(cur_line%500==0)printf("%d",cur_line);
update_terminal;
}
cur_line++;
}

/*:36*//*41:*/
#line 536 "./cwebdir/ctangle.w"

void
#line 252 "./cwebdir/ctang-w2c.ch"
 phase_two P1H(void){
#line 539 "./cwebdir/ctangle.w"
web_file_open= 0;
cur_line= 1;
/*28:*/
#line 325 "./cwebdir/ctangle.w"

stack_ptr= stack+1;cur_name= name_dir;cur_repl= text_info->text_link+text_info;
cur_byte= cur_repl->tok_start;cur_end= (cur_repl+1)->tok_start;cur_section= 0;

/*:28*/
#line 541 "./cwebdir/ctangle.w"
;
/*43:*/
#line 595 "./cwebdir/ctangle.w"

if(!output_defs_seen)
output_defs();

/*:43*/
#line 542 "./cwebdir/ctangle.w"
;
if(text_info->text_link==0&&cur_out_file==end_output_files){
printf("\n! No program text was specified.");mark_harmless;

}
else{
if(cur_out_file==end_output_files){
if(show_progress)
printf("\nWriting the output file (%s):",C_file_name);
}
else{
if(show_progress){
printf("\nWriting the output files:");

printf(" (%s)",C_file_name);
update_terminal;
}
if(text_info->text_link==0)goto writeloop;
}
while(stack_ptr> stack)get_output();
flush_buffer();
writeloop:/*42:*/
#line 572 "./cwebdir/ctangle.w"

for(an_output_file= end_output_files;an_output_file> cur_out_file;){
an_output_file--;
sprint_section_name(output_file_name,*an_output_file);
fclose(C_file);
C_file= fopen(output_file_name,"w");
if(C_file==0)fatal("! Cannot open output file:",output_file_name);

printf("\n(%s)",output_file_name);update_terminal;
cur_line= 1;
stack_ptr= stack+1;
cur_name= (*an_output_file);
cur_repl= (text_pointer)cur_name->equiv;
cur_byte= cur_repl->tok_start;
cur_end= (cur_repl+1)->tok_start;
while(stack_ptr> stack)get_output();
flush_buffer();
}

/*:42*/
#line 563 "./cwebdir/ctangle.w"
;
if(show_happiness)printf("\nDone.");
}
}

/*:41*//*46:*/
#line 605 "./cwebdir/ctangle.w"

void
#line 268 "./cwebdir/ctang-w2c.ch"
 output_defs P1H(void)
#line 608 "./cwebdir/ctangle.w"
{
sixteen_bits a;
push_level(NULL);
for(cur_text= text_info+1;cur_text<text_ptr;cur_text++)
if(cur_text->text_link==0){
cur_byte= cur_text->tok_start;
cur_end= (cur_text+1)->tok_start;
C_printf("%s","#define ");
out_state= normal;
protect= 1;
while(cur_byte<cur_end){
a= *cur_byte++;
if(cur_byte==cur_end&&a=='\n')break;
if(out_state==verbatim&&a!=string&&a!=constant&&a!='\n')
C_putc(a);

else if(a<0200)out_char(a);
else{
a= (a-0200)*0400+*cur_byte++;
if(a<024000){
cur_val= a;out_char(identifier);
}
else if(a<050000){confusion("macro defs have strange char");}
else{
cur_val= a-050000;cur_section= cur_val;out_char(section_number);
}

}
}
protect= 0;
flush_buffer();
}
pop_level(0);
}

/*:46*//*48:*/
#line 651 "./cwebdir/ctangle.w"

static void
#line 285 "./cwebdir/ctang-w2c.ch"
 out_char P1C(eight_bits,cur_char)
#line 655 "./cwebdir/ctangle.w"
{
char*j,*k;
restart:
switch(cur_char){
case'\n':if(protect&&out_state!=verbatim)C_putc(' ');
if(protect||out_state==verbatim)C_putc('\\');
flush_buffer();if(out_state!=verbatim)out_state= normal;break;
/*52:*/
#line 719 "./cwebdir/ctangle.w"

case identifier:
if(out_state==num_or_id)C_putc(' ');
j= (cur_val+name_dir)->byte_start;
k= (cur_val+name_dir+1)->byte_start;
while(j<k){
if((unsigned char)(*j)<0200)C_putc(*j);

else C_printf("%s",translit[(unsigned char)(*j)-0200]);
j++;
}
out_state= num_or_id;break;

/*:52*/
#line 662 "./cwebdir/ctangle.w"
;
/*53:*/
#line 732 "./cwebdir/ctangle.w"

case section_number:
if(cur_val> 0)C_printf("/*%d:*/",cur_val);
else if(cur_val<0)C_printf("/*:%d*/",-cur_val);
else if(protect){
cur_byte+= 4;
cur_char= '\n';
goto restart;
}else{
sixteen_bits a;
a= 0400**cur_byte++;
a+= *cur_byte++;
C_printf("\n#line %d \"",a);

cur_val= *cur_byte++;
cur_val= 0400*(cur_val-0200)+*cur_byte++;
for(j= (cur_val+name_dir)->byte_start,k= (cur_val+name_dir+1)->byte_start;
j<k;j++){
if(*j=='\\'||*j=='"')C_putc('\\');
C_putc(*j);
}
C_printf("%s","\"\n");
}
break;

/*:53*/
#line 663 "./cwebdir/ctangle.w"
;
/*49:*/
#line 681 "./cwebdir/ctangle.w"

case plus_plus:C_putc('+');C_putc('+');out_state= normal;break;
case minus_minus:C_putc('-');C_putc('-');out_state= normal;break;
case minus_gt:C_putc('-');C_putc('>');out_state= normal;break;
case gt_gt:C_putc('>');C_putc('>');out_state= normal;break;
case eq_eq:C_putc('=');C_putc('=');out_state= normal;break;
case lt_lt:C_putc('<');C_putc('<');out_state= normal;break;
case gt_eq:C_putc('>');C_putc('=');out_state= normal;break;
case lt_eq:C_putc('<');C_putc('=');out_state= normal;break;
case not_eq:C_putc('!');C_putc('=');out_state= normal;break;
case and_and:C_putc('&');C_putc('&');out_state= normal;break;
case or_or:C_putc('|');C_putc('|');out_state= normal;break;
case dot_dot_dot:C_putc('.');C_putc('.');C_putc('.');out_state= normal;
break;
case colon_colon:C_putc(':');C_putc(':');out_state= normal;break;
case period_ast:C_putc('.');C_putc('*');out_state= normal;break;
case minus_gt_ast:C_putc('-');C_putc('>');C_putc('*');out_state= normal;
break;

/*:49*/
#line 664 "./cwebdir/ctangle.w"
;
case'=':case'>':C_putc(cur_char);C_putc(' ');
out_state= normal;break;
case join:out_state= unbreakable;break;
case constant:if(out_state==verbatim){
out_state= num_or_id;break;
}
if(out_state==num_or_id)C_putc(' ');out_state= verbatim;break;
case string:if(out_state==verbatim)out_state= normal;
else out_state= verbatim;break;
case'/':C_putc('/');out_state= post_slash;break;
case'*':if(out_state==post_slash)C_putc(' ');

default:C_putc(cur_char);out_state= normal;break;
}
}

/*:48*//*57:*/
#line 813 "./cwebdir/ctangle.w"

eight_bits
#line 293 "./cwebdir/ctang-w2c.ch"
 skip_ahead P1H(void)
#line 816 "./cwebdir/ctangle.w"
{
eight_bits c;
while(1){
if(loc> limit&&(get_line()==0))return(new_section);
*(limit+1)= '@';
while(*loc!='@')loc++;
if(loc<=limit){
loc++;c= ccode[(eight_bits)*loc];loc++;
if(c!=ignore||*(loc-1)=='>')return(c);
}
}
}

/*:57*//*59:*/
#line 848 "./cwebdir/ctangle.w"

#line 302 "./cwebdir/ctang-w2c.ch"
int skip_comment P1C(boolean,is_long_comment)
#line 851 "./cwebdir/ctangle.w"
{
char c;
while(1){
if(loc> limit){
if(is_long_comment){
if(get_line())return(comment_continues= 1);
else{
err_print("! Input ended in mid-comment");

return(comment_continues= 0);
}
}
else return(comment_continues= 0);
}
c= *(loc++);
if(is_long_comment&&c=='*'&&*loc=='/'){
loc++;return(comment_continues= 0);
}
if(c=='@'){
if(ccode[(eight_bits)*loc]==new_section){
err_print("! Section name ended in mid-comment");loc--;

return(comment_continues= 0);
}
else loc++;
}
}
}

/*:59*//*62:*/
#line 900 "./cwebdir/ctangle.w"

eight_bits
#line 317 "./cwebdir/ctang-w2c.ch"
 get_next P1H(void)
#line 903 "./cwebdir/ctangle.w"
{
static int preprocessing= 0;
eight_bits c;
while(1){
if(loc> limit){
if(preprocessing&&*(limit-1)!='\\')preprocessing= 0;
if(get_line()==0)return(new_section);
else if(print_where&&!no_where){
print_where= 0;
/*76:*/
#line 1225 "./cwebdir/ctangle.w"

store_two_bytes(0150000);
if(changing)id_first= change_file_name;
else id_first= cur_file_name;
id_loc= id_first+strlen(id_first);
if(changing)store_two_bytes((sixteen_bits)change_line);
else store_two_bytes((sixteen_bits)cur_line);
{int a= id_lookup(id_first,id_loc,0)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);}

/*:76*/
#line 912 "./cwebdir/ctangle.w"
;
}
else return('\n');
}
c= *loc;
if(comment_continues||(c=='/'&&(*(loc+1)=='*'||*(loc+1)=='/'))){
skip_comment(comment_continues||*(loc+1)=='*');

if(comment_continues)return('\n');
else continue;
}
loc++;
if(xisdigit(c)||c=='.')/*65:*/
#line 978 "./cwebdir/ctangle.w"
{
id_first= loc-1;
if(*id_first=='.'&&!xisdigit(*loc))goto mistake;
if(*id_first=='0'){
if(*loc=='x'||*loc=='X'){
loc++;while(xisxdigit(*loc))loc++;goto found;
}
}
while(xisdigit(*loc))loc++;
if(*loc=='.'){
loc++;
while(xisdigit(*loc))loc++;
}
if(*loc=='e'||*loc=='E'){
if(*++loc=='+'||*loc=='-')loc++;
while(xisdigit(*loc))loc++;
}
found:while(*loc=='u'||*loc=='U'||*loc=='l'||*loc=='L'
||*loc=='f'||*loc=='F')loc++;
id_loc= loc;
return(constant);
}

/*:65*/
#line 924 "./cwebdir/ctangle.w"

else if(c=='\''||c=='"'||(c=='L'&&(*loc=='\''||*loc=='"')))
/*66:*/
#line 1006 "./cwebdir/ctangle.w"
{
char delim= c;
id_first= section_text+1;
id_loc= section_text;*++id_loc= delim;
if(delim=='L'){
delim= *loc++;*++id_loc= delim;
}
while(1){
if(loc>=limit){
if(*(limit-1)!='\\'){
err_print("! String didn't end");loc= limit;break;

}
if(get_line()==0){
err_print("! Input ended in middle of string");loc= buffer;break;

}
else if(++id_loc<=section_text_end)*id_loc= '\n';

}
if((c= *loc++)==delim){
if(++id_loc<=section_text_end)*id_loc= c;
break;
}
if(c=='\\'){
if(loc>=limit)continue;
if(++id_loc<=section_text_end)*id_loc= '\\';
c= *loc++;
}
if(++id_loc<=section_text_end)*id_loc= c;
}
if(id_loc>=section_text_end){
printf("\n! String too long: ");

term_write(section_text+1,25);
err_print("...");
}
id_loc++;
return(string);
}

/*:66*/
#line 926 "./cwebdir/ctangle.w"

else if(isalpha(c)||isxalpha(c)||ishigh(c))
/*64:*/
#line 972 "./cwebdir/ctangle.w"
{
id_first= --loc;
while(isalpha(*++loc)||isdigit(*loc)||isxalpha(*loc)||ishigh(*loc));
id_loc= loc;return(identifier);
}

/*:64*/
#line 928 "./cwebdir/ctangle.w"

else if(c=='@')/*67:*/
#line 1050 "./cwebdir/ctangle.w"
{
c= ccode[(eight_bits)*loc++];
switch(c){
case ignore:continue;
case translit_code:err_print("! Use @l in limbo only");continue;

case control_text:while((c= skip_ahead())=='@');

if(*(loc-1)!='>')
err_print("! Double @ should be used in control text");

continue;
case section_name:
cur_section_name_char= *(loc-1);
/*69:*/
#line 1098 "./cwebdir/ctangle.w"
{
char*k;
/*71:*/
#line 1118 "./cwebdir/ctangle.w"

k= section_text;
while(1){
if(loc> limit&&get_line()==0){
err_print("! Input ended in section name");

loc= buffer+1;break;
}
c= *loc;
/*72:*/
#line 1142 "./cwebdir/ctangle.w"

if(c=='@'){
c= *(loc+1);
if(c=='>'){
loc+= 2;break;
}
if(ccode[(eight_bits)c]==new_section){
err_print("! Section name didn't end");break;

}
if(ccode[(eight_bits)c]==section_name){
err_print("! Nesting of section names not allowed");break;

}
*(++k)= '@';loc++;
}

/*:72*/
#line 1127 "./cwebdir/ctangle.w"
;
loc++;if(k<section_text_end)k++;
if(xisspace(c)){
c= ' ';if(*(k-1)==' ')k--;
}
*k= c;
}
if(k>=section_text_end){
printf("\n! Section name too long: ");

term_write(section_text+1,25);
printf("...");mark_harmless;
}
if(*k==' '&&k> section_text)k--;

/*:71*/
#line 1100 "./cwebdir/ctangle.w"
;
if(k-section_text> 3&&strncmp(k-2,"...",3)==0)
cur_section_name= section_lookup(section_text+1,k-3,1);
else cur_section_name= section_lookup(section_text+1,k,0);
if(cur_section_name_char=='(')
/*39:*/
#line 516 "./cwebdir/ctangle.w"

{
for(an_output_file= cur_out_file;
an_output_file<end_output_files;an_output_file++)
if(*an_output_file==cur_section_name)break;
if(an_output_file==end_output_files){
if(cur_out_file> output_files)
*--cur_out_file= cur_section_name;
else{
overflow("output files");
}
}
}

/*:39*/
#line 1106 "./cwebdir/ctangle.w"
;
return(section_name);
}

/*:69*/
#line 1064 "./cwebdir/ctangle.w"
;
case string:/*73:*/
#line 1164 "./cwebdir/ctangle.w"
{
id_first= loc++;*(limit+1)= '@';*(limit+2)= '>';
while(*loc!='@'||*(loc+1)!='>')loc++;
if(loc>=limit)err_print("! Verbatim string didn't end");

id_loc= loc;loc+= 2;
return(string);
}

/*:73*/
#line 1065 "./cwebdir/ctangle.w"
;
case ord:/*68:*/
#line 1077 "./cwebdir/ctangle.w"

id_first= loc;
if(*loc=='\\'){
if(*++loc=='\'')loc++;
}
while(*loc!='\''){
if(*loc=='@'){
if(*(loc+1)!='@')
err_print("! Double @ should be used in ASCII constant");

else loc++;
}
loc++;
if(loc> limit){
err_print("! String didn't end");loc= limit-1;break;

}
}
loc++;
return(ord);

/*:68*/
#line 1066 "./cwebdir/ctangle.w"
;
default:return(c);
}
}

/*:67*/
#line 929 "./cwebdir/ctangle.w"

else if(xisspace(c)){
if(!preprocessing||loc> limit)continue;

else return(' ');
}
else if(c=='#'&&loc==buffer+1)preprocessing= 1;
mistake:/*63:*/
#line 950 "./cwebdir/ctangle.w"

switch(c){
case'+':if(*loc=='+')compress(plus_plus);break;
case'-':if(*loc=='-'){compress(minus_minus);}
else if(*loc=='>')if(*(loc+1)=='*'){loc++;compress(minus_gt_ast);}
else compress(minus_gt);break;
case'.':if(*loc=='*'){compress(period_ast);}
else if(*loc=='.'&&*(loc+1)=='.'){
loc++;compress(dot_dot_dot);
}
break;
case':':if(*loc==':')compress(colon_colon);break;
case'=':if(*loc=='=')compress(eq_eq);break;
case'>':if(*loc=='='){compress(gt_eq);}
else if(*loc=='>')compress(gt_gt);break;
case'<':if(*loc=='='){compress(lt_eq);}
else if(*loc=='<')compress(lt_lt);break;
case'&':if(*loc=='&')compress(and_and);break;
case'|':if(*loc=='|')compress(or_or);break;
case'!':if(*loc=='=')compress(not_eq);break;
}

/*:63*/
#line 936 "./cwebdir/ctangle.w"

return(c);
}
}

/*:62*//*75:*/
#line 1199 "./cwebdir/ctangle.w"

void
#line 326 "./cwebdir/ctang-w2c.ch"
 scan_repl P1C(eight_bits,t)
#line 1203 "./cwebdir/ctangle.w"
{
sixteen_bits a;
if(t==section_name){/*76:*/
#line 1225 "./cwebdir/ctangle.w"

store_two_bytes(0150000);
if(changing)id_first= change_file_name;
else id_first= cur_file_name;
id_loc= id_first+strlen(id_first);
if(changing)store_two_bytes((sixteen_bits)change_line);
else store_two_bytes((sixteen_bits)cur_line);
{int a= id_lookup(id_first,id_loc,0)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);}

/*:76*/
#line 1205 "./cwebdir/ctangle.w"
;}
while(1)switch(a= get_next()){
/*77:*/
#line 1235 "./cwebdir/ctangle.w"

case identifier:a= id_lookup(id_first,id_loc,0)-name_dir;
app_repl((a/0400)+0200);
app_repl(a%0400);break;
case section_name:if(t!=section_name)goto done;
else{
/*78:*/
#line 1268 "./cwebdir/ctangle.w"
{
char*try_loc= loc;
while(*try_loc==' '&&try_loc<limit)try_loc++;
if(*try_loc=='+'&&try_loc<limit)try_loc++;
while(*try_loc==' '&&try_loc<limit)try_loc++;
if(*try_loc=='=')err_print("! Missing `@ ' before a named section");



}

/*:78*/
#line 1241 "./cwebdir/ctangle.w"
;
a= cur_section_name-name_dir;
app_repl((a/0400)+0250);
app_repl(a%0400);
/*76:*/
#line 1225 "./cwebdir/ctangle.w"

store_two_bytes(0150000);
if(changing)id_first= change_file_name;
else id_first= cur_file_name;
id_loc= id_first+strlen(id_first);
if(changing)store_two_bytes((sixteen_bits)change_line);
else store_two_bytes((sixteen_bits)cur_line);
{int a= id_lookup(id_first,id_loc,0)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);}

/*:76*/
#line 1245 "./cwebdir/ctangle.w"
;break;
}
case output_defs_code:if(t!=section_name)err_print("! Misplaced @h");

else{
output_defs_seen= 1;
a= output_defs_flag;
app_repl((a/0400)+0200);
app_repl(a%0400);
/*76:*/
#line 1225 "./cwebdir/ctangle.w"

store_two_bytes(0150000);
if(changing)id_first= change_file_name;
else id_first= cur_file_name;
id_loc= id_first+strlen(id_first);
if(changing)store_two_bytes((sixteen_bits)change_line);
else store_two_bytes((sixteen_bits)cur_line);
{int a= id_lookup(id_first,id_loc,0)-name_dir;app_repl((a/0400)+0200);
app_repl(a%0400);}

/*:76*/
#line 1254 "./cwebdir/ctangle.w"
;
}
break;
case constant:case string:
/*79:*/
#line 1279 "./cwebdir/ctangle.w"

app_repl(a);
while(id_first<id_loc){
if(*id_first=='@'){
if(*(id_first+1)=='@')id_first++;
else err_print("! Double @ should be used in string");

}
app_repl(*id_first++);
}
app_repl(a);break;

/*:79*/
#line 1258 "./cwebdir/ctangle.w"
;
case ord:
/*80:*/
#line 1295 "./cwebdir/ctangle.w"
{
int c= (eight_bits)*id_first;
if(c=='\\'){
c= *++id_first;
if(c>='0'&&c<='7'){
c-= '0';
if(*(id_first+1)>='0'&&*(id_first+1)<='7'){
c= 8*c+*(++id_first)-'0';
if(*(id_first+1)>='0'&&*(id_first+1)<='7'&&c<32)
c= 8*c+*(++id_first)-'0';
}
}
else switch(c){
case't':c= '\t';break;
case'n':c= '\n';break;
case'b':c= '\b';break;
case'f':c= '\f';break;
case'v':c= '\v';break;
case'r':c= '\r';break;
case'a':c= '\7';break;
case'?':c= '?';break;
case'x':
if(xisdigit(*(id_first+1)))c= *(++id_first)-'0';
else if(xisxdigit(*(id_first+1))){
++id_first;
c= toupper(*id_first)-'A'+10;
}
if(xisdigit(*(id_first+1)))c= 16*c+*(++id_first)-'0';
else if(xisxdigit(*(id_first+1))){
++id_first;
c= 16*c+toupper(*id_first)-'A'+10;
}
break;
case'\\':c= '\\';break;
case'\'':c= '\'';break;
case'\"':c= '\"';break;
default:err_print("! Unrecognized escape sequence");

}
}

app_repl(constant);
if(c>=100)app_repl('0'+c/100);
if(c>=10)app_repl('0'+(c/10)%10);
app_repl('0'+c%10);
app_repl(constant);
}
break;

/*:80*/
#line 1260 "./cwebdir/ctangle.w"
;
case definition:case format_code:case begin_C:if(t!=section_name)goto done;
else{
err_print("! @d, @f and @c are ignored in C text");continue;

}
case new_section:goto done;

/*:77*/
#line 1210 "./cwebdir/ctangle.w"

case')':app_repl(a);
if(t==macro)app_repl(' ');
break;
default:app_repl(a);
}
done:next_control= (eight_bits)a;
if(text_ptr> text_info_end)overflow("text");
cur_text= text_ptr;(++text_ptr)->tok_start= tok_ptr;
}

/*:75*//*82:*/
#line 1357 "./cwebdir/ctangle.w"

void
#line 334 "./cwebdir/ctang-w2c.ch"
 scan_section P1H(void)
#line 1360 "./cwebdir/ctangle.w"
{
name_pointer p;
text_pointer q;
sixteen_bits a;
section_count++;no_where= 1;
if(*(loc-1)=='*'&&show_progress){
printf("*%d",section_count);update_terminal;
}
next_control= 0;
while(1){
/*83:*/
#line 1396 "./cwebdir/ctangle.w"

while(next_control<definition)

if((next_control= skip_ahead())==section_name){
loc-= 2;next_control= get_next();
}

/*:83*/
#line 1371 "./cwebdir/ctangle.w"
;
if(next_control==definition){
/*84:*/
#line 1403 "./cwebdir/ctangle.w"
{
while((next_control= get_next())=='\n');
if(next_control!=identifier){
err_print("! Definition flushed, must start with identifier");

continue;
}
app_repl(((a= id_lookup(id_first,id_loc,0)-name_dir)/0400)+0200);

app_repl(a%0400);
if(*loc!='('){
app_repl(string);app_repl(' ');app_repl(string);
}
scan_repl(macro);
cur_text->text_link= 0;
}

/*:84*/
#line 1373 "./cwebdir/ctangle.w"

continue;
}
if(next_control==begin_C){
p= name_dir;break;
}
if(next_control==section_name){
p= cur_section_name;
/*85:*/
#line 1428 "./cwebdir/ctangle.w"

while((next_control= get_next())=='+');
if(next_control!='='&&next_control!=eq_eq)
continue;

/*:85*/
#line 1381 "./cwebdir/ctangle.w"
;
break;
}
return;
}
no_where= print_where= 0;
/*86:*/
#line 1433 "./cwebdir/ctangle.w"

/*87:*/
#line 1438 "./cwebdir/ctangle.w"

store_two_bytes((sixteen_bits)(0150000+section_count));


/*:87*/
#line 1434 "./cwebdir/ctangle.w"
;
scan_repl(section_name);
/*88:*/
#line 1442 "./cwebdir/ctangle.w"

if(p==name_dir||p==0){
(last_unnamed)->text_link= cur_text-text_info;last_unnamed= cur_text;
}
else if(p->equiv==(char*)text_info)p->equiv= (char*)cur_text;

else{
q= (text_pointer)p->equiv;
while(q->text_link<section_flag)
q= q->text_link+text_info;
q->text_link= cur_text-text_info;
}
cur_text->text_link= section_flag;


/*:88*/
#line 1436 "./cwebdir/ctangle.w"
;

/*:86*/
#line 1387 "./cwebdir/ctangle.w"
;
}

/*:82*//*90:*/
#line 1460 "./cwebdir/ctangle.w"

void
#line 350 "./cwebdir/ctang-w2c.ch"
 phase_one P1H(void){
#line 1463 "./cwebdir/ctangle.w"
phase= 1;
section_count= 0;
reset_input();
skip_limbo();
while(!input_has_ended)scan_section();
check_complete();
phase= 2;
}

/*:90*//*92:*/
#line 1478 "./cwebdir/ctangle.w"

void
#line 366 "./cwebdir/ctang-w2c.ch"
 skip_limbo P1H(void)
#line 1481 "./cwebdir/ctangle.w"
{
char c;
while(1){
if(loc> limit&&get_line()==0)return;
*(limit+1)= '@';
while(*loc!='@')loc++;
if(loc++<=limit){
c= *loc++;
if(ccode[(eight_bits)c]==new_section)break;
switch(ccode[(eight_bits)c]){
case translit_code:/*93:*/
#line 1507 "./cwebdir/ctangle.w"

while(xisspace(*loc)&&loc<limit)loc++;
loc+= 3;
if(loc> limit||!xisxdigit(*(loc-3))||!xisxdigit(*(loc-2))
||(*(loc-3)>='0'&&*(loc-3)<='7')||!xisspace(*(loc-1)))
err_print("! Improper hex number following @l");

else{
unsigned i;
char*beg;
sscanf(loc-3,"%x",&i);
while(xisspace(*loc)&&loc<limit)loc++;
beg= loc;
while(loc<limit&&(xisalpha(*loc)||xisdigit(*loc)||*loc=='_'))loc++;
if(loc-beg>=translit_length)
err_print("! Replacement string in @l too long");

else{
strncpy(translit[i-0200],beg,loc-beg);
translit[i-0200][loc-beg]= '\0';
}
}

/*:93*/
#line 1491 "./cwebdir/ctangle.w"
;break;
case format_code:case'@':break;
case control_text:if(c=='q'||c=='Q'){
while((c= skip_ahead())=='@');
if(*(loc-1)!='>')
err_print("! Double @ should be used in control text");

break;
}
default:err_print("! Double @ should be used in limbo");

}
}
}
}

/*:92*//*94:*/
#line 1533 "./cwebdir/ctangle.w"

void
#line 374 "./cwebdir/ctang-w2c.ch"
 print_stats P1H(void){
#line 1536 "./cwebdir/ctangle.w"
printf("\nMemory usage statistics:\n");
printf("%ld names (out of %ld)\n",
(long)(name_ptr-name_dir),(long)max_names);
printf("%ld replacement texts (out of %ld)\n",
(long)(text_ptr-text_info),(long)max_texts);
printf("%ld bytes (out of %ld)\n",
(long)(byte_ptr-byte_mem),(long)max_bytes);
printf("%ld tokens (out of %ld)\n",
(long)(tok_ptr-tok_mem),(long)max_toks);
}

/*:94*/