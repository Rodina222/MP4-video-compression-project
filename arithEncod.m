function bits=arithEncod(probability,symbols,sequence)
pLen=length(probability);
symLen=length(symbols);
if(pLen~=symLen ) % to make sure that that symbols list length= probability list length 
disp("Error");
return;
end
N=numel(sequence); % Length of sequence
map=zeros(1,pLen+1);        % intialization of array to be filled with the range of probabilities for each char in seq
% Fill first row with accumaltion of probabilities
for i=2:pLen+1
  map(i)=map(i-1)+probability(i-1);
end

for i=2:N
    char=sequence(i-1); % get char of the sequence
    index=find(symbols==char); % get index of the char in the symbols list
    l=map(index);           % assign range of char probability to lower bound and upper bound to fill a new row in map matrix
    u=map(index+1);         
    interval=u-l;
    map(1)=l;
   for j=2:(pLen+1)
  map(j)=map(j-1)+interval*probability(j-1); % fill array with the new probabilities
   end
end
   char=sequence(N);
    index=find(symbols==char);
    l=map(index);
    u=map(index+1);
    code=getCode(u ,l);
disp(code)

code=convertStringsToChars(code);
l=length(code);
bits=[];

for i=1:l 
bits=[bits str2num(code(i))];


end
end

function code=getCode(upper ,lower)

prob=zeros(1,3);
prob(2)=0.5; prob(3)=1; % intialization of prob array
codeword=["0","1"];
found=false;
%loop till we find a range of probability for binary code less than upper
%and lower (inputs )of function
while found==false
     for i=1:length(prob)
        if(lower<=prob(i))
            if(i==3) % last index of array 
            part=2;  % indication of taking which codeword from array codeword
            low=prob(i-1);
            high=prob(i);
            elseif(i==2)   % there are two cases if index in between
                  if(prob(i)>=upper )
                    part=1;
                    low=prob(i-1);
                    high=prob(i);
                    else
                    part=2;
                    low=prob(i);
                    high=prob(i+1);
                   end
            else
            part=1;
            low=prob(i);
            high=prob(i+1);
            end
           
            
            if(high<upper && low>=lower)
               found=true;
                code=codeword(i);
            end
            if(high<=upper && low>lower)
                found=true;
                 code=codeword(i);
              if(high==upper)
                code=codeword(i)+"0";
              end
            end
            interval=high-low;
            prob(1)=low;

            for j=2:length(prob) % fill prob array with a new range of probabilities
             prob(j)=prob(j-1)+interval/2;
            end
            % accumulate bits to binary codes
            if(part==1)
                temp=codeword(part);
            codeword(1)=codeword(part)+'0'; 
            codeword(2)=temp+'1';
            elseif (part==2)
                 temp=codeword(part);
            codeword(1)=codeword(part)+'0';
            codeword(2)=temp+'1';
            end
           break;
        end
end
end

end