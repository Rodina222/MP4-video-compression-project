function received_symbols= my_Arithmetic_decoder(received_bits,symbols_num,probs,symbols)

received_num=0;
upper_bound=0;
lower_bound=0;
received_symbols=[];

line = zeros(1,length(probs)+1);
number_of_points = length(line);
line(1) = 0;
line(2:number_of_points) = probs;

shifted_probs=zeros(1,length(probs)+1);
shifted_probs(2:length(shifted_probs))= probs;


for i = 1:length(received_bits) %it converts the received bits to a decimal number.

received_num= received_num+received_bits(i)*(2^-i);
    
end


for i=2:number_of_points   %determines the position of the points on the line.

   line(i) = line(i-1)+line(i); 

end


while (symbols_num > 0)

[symbol,upper_bound,lower_bound]= symbol_detector(line,received_num,symbols);
received_symbols = [received_symbols symbol];

new_line= line;   % changing the new line boundaries according to the output of symbol_detector function
new_line(1)= lower_bound;
new_line(length(new_line))= upper_bound;

out_line= Line_shaping(new_line,shifted_probs);


line= out_line;

symbols_num = symbols_num-1;


end

end

function [symbol,upper_bound,lower_bound]= symbol_detector(line,received_num,symbols) % detects the symbol with comparing the received number with the points on the line


for j =1 :length(line)

    if(received_num < line(j) && received_num > line(j-1) )
       upper_bound=  line(j);
       lower_bound=   line(j-1);
       symbol= symbols(j-1);

   end

end

end

function  out_line= Line_shaping(line,shifted_probs) % draw the new line with the points according to the new boundaries.

difference= line(length(line))-line(1);

for k=2:length(line)-1

     line(k)= (difference * shifted_probs(k))+line(k-1);

end

out_line = line;

end