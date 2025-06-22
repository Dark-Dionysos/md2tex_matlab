%% Copyright (C) 2025 Angus Z. Wong
%%
%% This program is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program.  If not, see <https://www.gnu.org/licenses/>.

%% -*- texinfo -*-
%% @deftypefn {} {@var{retval} =} md2tex (@var{input1}, @var{input2})
%%
%% @seealso{}
%% @end deftypefn

%% Author: Angus Z. Wong
%% Created: 2025-06-20

function [] = md2tex_octave (filepath,head="withtitle",author="none")
% comfirmation the argument typr is correct
if ~ischar(author)
  error("the author type is wrong, it must be char!");
end
if strcmp(head,"withtitle")==0 && strcmp(head,"notitle")==0
  error("the head type must be either withtitle or notitle!");
end
% read the file
fid = fopen(filepath);
if fid == -1
  error("fail to open the file!");
else
  lines = fskipl(fid, Inf);
  frewind(fid);
  md = cell(1,lines);
  for i = 1:lines
    md{i}=fgetl(fid);
  endfor
  fclose(fid);
endif
% add heading and tail
md = strjoin(md,'\n');
if strcmp(author,"none")==1
  md = strcat("\\documentclass[11pt]{article}\n\\usepackage{array,graphicx,url,ulem,utfsym}\n\\begin{document}\n",md,"\n\\end{document}");
else
  md = strcat("\\documentclass[11pt]{article}\n\\usepackage{array,graphicx,url,ulem,utfsym}\n\\begin{document}\n\\author{",author,"}\n",md,"\n\\end{document}");
end
if strcmp(head,"withtitle")==1
  % replace heading1
  md = regexprep(md,'^#\s(\w+.*)$','\\title{$1}\n\\maketitle','lineanchors','dotexceptnewline');
  % replace heading2
  md = regexprep(md,'^#{2}\s(\w+.*)$','\\section{$1}','lineanchors','dotexceptnewline');
  % replace heading3
  md = regexprep(md,'^#{3}\s(\w+.*)$','\\subsection{$1}','lineanchors','dotexceptnewline');
  % replace heading4
  md = regexprep(md,'^#{4}\s(\w+.*)$','\\subsubsection{$1}','lineanchors','dotexceptnewline');
end
if strcmp(head,"notitle")==1
  % replace heading1
  md = regexprep(md,'^#\s(\w+.*)$','\\section{$1}\n','lineanchors','dotexceptnewline');
  % replace heading2
  md = regexprep(md,'^#{2}\s(\w+.*)$','\\subsection{$1}','lineanchors','dotexceptnewline');
  % replace heading3
  md = regexprep(md,'^#{3}\s(\w+.*)$','\\subsubsection{$1}','lineanchors','dotexceptnewline');
end
% replace font sytle
% Bold and Italics
md = regexprep(md,'\*{3}((\w+\s)*\w+)\*{3}','\\textbf{\\textit{$1}}','lineanchors','dotexceptnewline');
% Bold
md = regexprep(md,'\*{2}((\w+\s)*\w+)\*{2}','\\textbf{$1}','lineanchors','dotexceptnewline');
% Italics
md = regexprep(md,'\*((\w+\s)*\w+)\*','\\textit{$1}','lineanchors','dotexceptnewline');
% delete line
md = regexprep(md,'~{2}((\w+\s)*\w+)~{2}','\\sout{$1}','lineanchors','dotexceptnewline');
% code area
md = regexprep(md,'`((\w+\s)*\w+)`','\\verb\|$1\|','lineanchors','dotexceptnewline');
% to do list
md = regexprep(md,'^\-\s\[x\]','\\usym{2611}','lineanchors','dotexceptnewline');
md = regexprep(md,'^\-\s\[\s\]','\\usym{2610}','lineanchors','dotexceptnewline');
% picture
md = regexprep(md,'!\[((\w+\s)*\w+)\]\((\S+)\s"(\S+\s)*\S+"\)','\\begin{figure}\n\\centering\n\\includegrapphics{$3}\n\\caption{$1}\n\\end{figure}\n','lineanchors','dotexceptnewline');
md = regexprep(md,'!\[((\w+\s)*\w+)\]\(((\S+\s)*?\S+)\)','\\begin{figure}\n\\centering\n\\includegrapphics{$3}\n\\caption{$1}\n\\end{figure}\n','lineanchors','dotexceptnewline');
% website address
md = regexprep(md,'<(\S+)>','\\url{$1}','lineanchors','dotexceptnewline');
md = regexprep(md,'\[((\w+\s)*\w+)\]\((\S+)\)','$1 \(\\url{$1}\)','lineanchors','dotexceptnewline');
md = regexprep(md,'\[((\w+\s)*\w+)\]\((\S+)\s"(\w+\s)*\w+"\)','$1 \(\\url{$1}\)','lineanchors','dotexceptnewline');
% fenced block
md = regexprep(md,'^`{3}\n(.*\n)+?^`{3}','\\begin{verbatim}\n$1\\end{verbatim}','lineanchors','dotexceptnewline');
% quotation
md = regexprep(md,'((^>\s?.*\n)+)','\\begin{quote}\n$1\\end{quote}\n','lineanchors','dotexceptnewline');
md = regexprep(md,'^>\s?','\t','lineanchors','dotexceptnewline');
% list
%% enumeration
md = regexprep(md,'((^\s*\d\.\s.*\n)+)','\\begin{enumerate}\n$1\\end{enumerate}\n','lineanchors','dotexceptnewline');
md = regexprep(md,'^\d\.\s','\t\\item ','lineanchors','dotexceptnewline');
%% itemize
md = regexprep(md,'((^\s*-\s.*\n)+)','\\begin{itemize}\n$1\\end{itemize}\n','lineanchors','dotexceptnewline');
md = regexprep(md,'^-\s','\t\\item ','lineanchors','dotexceptnewline');
% table
[tstart,tend] = regexp(md,'(^\|.*\|\n)+','once','lineanchors','dotexceptnewline');
while ~isempty(tstart)
  md = tableconvert(md,tstart,tend);
  [tstart,tend] = regexp(md,'(^\|.*\|\n)+','once','lineanchors','dotexceptnewline');
end
% footnote
[s,e,te,m,t] = regexp(md,'(\[\^\w+\]):\s?((\S+\s)*?\S+)\n','lineanchors','dotexceptnewline');
if ~isempty(t)
  for i = 1:length(t)
    reppat = strcat('\\footnote{',t{i}{2},'}');
    footnotelabel = regexptranslate("escape",t{i}{1});
    footnotecontent = strcat(footnotelabel,':\s?((\S+\s)*?\S+)\n');
    % delete the footnotecontent
    md = regexprep(md,footnotecontent,'');
    md = regexprep(md,footnotelabel,reppat); % t{i}{1}need translate to regexp
  endfor
endif
fid = fopen('result.tex','w');
fputs(fid,md);
endfunction

function output_string = tableconvert (string,string_start,string_end)
%% tell the number of rows
table = string(string_start:string_end);
[column_s, column_e] = regexp(table,'^\|.*\|\n','once','lineanchors','dotexceptnewline');
one_column = table(column_s:column_e);
row_s = regexp(one_column,'\|.*?[^\|]','lineanchors','dotexceptnewline');
row_num = length(row_s)-1;
%% construct string made up by 'c' fro row format in tabular enviroment.
c_string = num2str(ones(1,row_num));
c_string = erase(c_string,' ');
c_string = strrep(c_string,'1','c');
%% the preamble and tail of tabular enviroment
heading = strcat("\\begin{tabular}{",c_string,"}\n\\hline\n");
tail = "\\hline\n\\end{tabular}\n";
table = strcat(heading,table,tail);
%% replace the line under the title
table = regexprep(table,'(\|\s*\-+\s*)+\|','\\hline');
%% repalce the seperator at the first
table = regexprep(table,'^\|','','lineanchors','dotexceptnewline');
%% replace the seperator at the end
table = regexprep(table,'\|$','\\\','lineanchors','dotexceptnewline');
%% replace the seperator
table = strrep(table,'|','&');
output_string = strcat(string(1:string_start-1),table,string(string_end+1:end));
endfunction
