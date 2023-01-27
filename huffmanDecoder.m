function sig = huffmanDecoder(bits, dict)

i = 1;
bits = sprintf('%d', bits);          
while i <= length(dict)
    code = sprintf('%d', dict{i,2}); % Converting encoder bits to strings.
    pattern = ['^' code];            % The pattern. '^' is the beginging of the string, we need the pattern
                                     % on the front to make sure it's the correct code
    if regexp(bits, pattern)         % Matching bits in the pattern
        try
            sig = [sig [dict{i,1}]]; % sig is now a cell array
        catch
            sig = {dict{i,1}};
        end
        i = 1;       
        len = length(bits);          % Taking the length of the bits
        lc = length(code) + 1;       % Updating the encoding part for the next iteration.
        if lc > len
            break;
        else
            bits = bits(lc:len);
        end
    else
        i = i + 1;
    end

end
sig=cell2mat(sig);                 % Converting the cell array to list
end