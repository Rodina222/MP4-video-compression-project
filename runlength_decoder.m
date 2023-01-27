% This function take stream of integers (decimals) and
% returns 1 d array uncompressed using runlength
function symbols=runlength_decoder(stream)  
size=length(stream);
additional_size=0;
for i=1:size
if(stream(i)==0)
    additional_size=additional_size+stream(i+1)-2; % compute additional size that will be added by replacing each 0 and the integers after 0 by number of zeros.
end
end
symbols_size=size+additional_size;
symbols=zeros(1,symbols_size);
index=1;

for i=1:size
 if(stream(i)~=0)
     if(i>1 && stream(i-1)==0) % case of integer after 0 to avoid adding it in the output again
         continue;
     end
     symbols(index)=stream(i);
     index=index+1;
 elseif(stream(i)==0)
    for j=1:stream(i+1) % add zeros with number of integer after 0
       symbols(index)=0;
       index=index+1;
    end
 end

end
end