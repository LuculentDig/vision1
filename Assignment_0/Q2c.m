function result=Q2c (im)
    result=im;
    new_red=result(:,:,2);
    new_green=result(:,:,1);
    result(:,:,1)=new_red;
    result(:,:,2)=new_green;
    
end
