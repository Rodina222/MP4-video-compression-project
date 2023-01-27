% This function takes input array of size 64 and returns Block of image
% with dimension 8*8 , it reverses zizag order in encoder 
% this function is used in the JPEG decoder
function Image =reverse_zigzag(array)
m=length(array);
if(m~=64) %Make sure input size 64
disp("Error in input Array, it must be of size 64");
return;
end
Image=zeros(8,8);
count=0;
index=1;
while count<=7   % fill first half of the block
    if(rem(count,2)~=0) % if rem is not divisible by 2 then fill image from the top of the diagonal
    x=0;
    y=count;
    while y>-1
       Image(x+1,y+1)=array(index);
       y=y-1;
       x=x+1;
       index=index+1;
    end
    end
    if(rem(count,2)==0) %if rem is divisible by 2 then fill image from the buttom of the diagonal
    x=count;
    y=0;
    while x>-1
       Image(x+1,y+1)=array(index);
       y=y+1;
       x=x-1;
       index=index+1;
    end
    end
    count=count+1;
end
%% second part
while count>7 && count<=15 % fill second half

   if(rem(count,2)~=0)
    x=count-7;
    y=7;
    limit=x;
    while y>=limit
       Image(x+1,y+1)=array(index);
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
       Image(x+1,y+1)=array(index);
       y=y+1;
       x=x-1;
       index=index+1;
    end
    end
    count=count+1;

end
end
