function b=my_div(arg1,arg2)
    protec=0.001;
    arg2(arg2==0)=protec/10;
    b=sign(arg2).*arg1./max(abs(arg2),protec);
end


















































