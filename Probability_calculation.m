function [symbols,probabilities]= Probability_calculation(vector)

counter =0;
checker =0;
symbols=[];

for i=1:length(vector)      % this for loop aims to extract the unique symbols from the block

    if i == 1
        symbols=[vector(i)];
    end
   
   for k=1:length(symbols)
       if vector(i) == symbols(k)
          checker = checker +1;    
       end
   end

   if checker == 0 && i ~= 1
        symbols=[symbols, vector(i)];
   end

    counter=0;
    checker=0;
    
end

count = 0;
frequency =[];

for r = 1:  length(symbols)     % this for loop aims to calculate the frequency of each symbol
    for z= 1:length(vector)
       if symbols(r) == vector(z)
       count = count+1;
       end
    end
    frequency = [frequency, count];
    count = 0;
end

sum_of_elements= length(vector);
probability = 0;
probabilities=[];

for y= 1:length(frequency)       % this for loop aims to calculate the probability of each symbol

probability= frequency(y)/ sum_of_elements;

probabilities= [probabilities, probability];

end

end

