function bits=huffmanEncoder(signal, dict)
%********* it takes signal with symbols and dictionary of huffman code
%********* it returns bits 
bits=[];
m=length(signal);
% loop over all signal to replace it with bits
for i=1:m
    % Searching in dict for the corresponding codeword of symbol
    for j=1:length(dict)
        symbol=dict{j,1};

        if (signal(i)==symbol)
            bits=[bits, dict{j,2}];
        end
    end

end

end