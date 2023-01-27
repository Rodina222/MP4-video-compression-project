function [unique_numbers, prob] = probability(vec)
len = length(vec);
[num_of_occurence, unique_numbers]=hist(vec,unique(vec));
prob = num_of_occurence./len;

end