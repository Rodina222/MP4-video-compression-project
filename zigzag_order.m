function array= zigzag_order(Image)
[m ,n]=size(Image);
if(m~=8 || n~=8) %Make sure input size 8*8
disp("Error in input Image, it must be of size 8*8");
return;
end
count=0;
index=1;
array=zeros(1,64);
while count<=7   % convert first half of the block
    if(rem(count,2)~=0) % if rem is not divisible by 2 then fill vector from the top of the diagonal
    x=0;
    y=count;
    while y>-1
     array(index)=Image(x+1,y+1);
       y=y-1;
       x=x+1;
       index=index+1;
    end
    end
    if(rem(count,2)==0) %if rem is divisible by 2 then fill array from the buttom of the diagonal
    x=count;
    y=0;
    while x>-1
       array(index)=Image(x+1,y+1);
       y=y+1;
       x=x-1;
       index=index+1;
    end
    end
    count=count+1;
end
%% second part
while count>7 && count<=15 % fill second half of array 

   if(rem(count,2)~=0)
    x=count-7;
    y=7;
    limit=x;
    while y>=limit
       array(index)=Image(x+1,y+1);
       y=y-1;
       x=x+1;
       index=index+1;
    end
    end
    if(rem(count,2)==0)
    x=7;
    y=count-7;
    limit=y;
    while x>=limit
       array(index)=Image(x+1,y+1);
       y=y+1;
       x=x-1;
       index=index+1;
    end
    end
    count=count+1;

end
end