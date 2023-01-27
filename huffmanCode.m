function dict =huffmanCode(symbols,p)
%********** This function takes symbols and p-> Corresponding Probability
%of symbols

check=0;
for i=1:length(p)
check=check+p(i);
end
check=int8(check);
% check that the probability vector is valid (sum=1)
if(check~=1)
    disp("Error in Probability vector")
    return
end
symLength=length(symbols);
probLength=length(p);
if (symLength~=probLength)
 disp("Error in Dimensions");
 return
end
% intializations
s={{}};
list=zeros(1,length(p));
codeWord=strings(2,length(p));
for i=1:symLength
codeWord(1,i)=symbols(i);
end
% Intialize list with indices to be resorted later
for i=1:length(p)
    list(i)=i;
end
for i=1:length(list)
  s{i}{1}=list(i);
end
[p ,list]=sort_huffman(p,list);

% Generate code word for each symbol 
for i=length(p):-1:2
      sum=p(i)+p(i-1);
      p(i-1)=sum;
         for z=1:length(s{list(i)})
            codeWord(2,s{list(i)}{z})='0'+codeWord(2,s{list(i)}{z});
         end
         for z=1:length(s{list(i-1)})
            codeWord(2,s{list(i-1)}{z})='1'+codeWord(2,s{list(i-1)}{z});
         end
        
         for z=1:length(s{list(i)})
             s{list(i-1)}{length(s{list(i-1)})+1}=s{list(i)}{z};
         end
      p=p(1:i-1);
      list=list(1:i-1);
      [p ,list]=sort_huffman(p,list);

end
dict=cell(probLength,2);

for i=1:length(codeWord)
bits=convertStringsToChars(codeWord(2,i));
bits=char(num2cell(bits));
bits=reshape(str2num(bits),1,[]);
dict{i,1}=str2num(codeWord(1,i));
dict{i,2}=bits;
end

end