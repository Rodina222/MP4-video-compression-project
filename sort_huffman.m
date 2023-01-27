function [p ,index]=sort_huffman(probability_list,index_list)
lenP=length(probability_list);
lenI=length(index_list);


if (lenP~=lenI)
    disp("Error in lists dimension.")
return;
end
for j=1:lenP
    for i=1:j
        if(probability_list(i)<probability_list(j))
            temp=probability_list(i);
            probability_list(i)=probability_list(j);
            probability_list(j)=temp;
             temp2=index_list(i);
             index_list(i)=index_list(j);
             index_list(j)=temp2;
        end
    end
end
p=probability_list;
index=index_list;

end