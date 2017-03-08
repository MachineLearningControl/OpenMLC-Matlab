function b=my_log(arg1)
    protec=0.00001;
    arg1(arg1==0)=protec/10;
    b=log10(max(abs(arg1),protec));
end


















































