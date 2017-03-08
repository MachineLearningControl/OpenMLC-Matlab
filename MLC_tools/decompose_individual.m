function ind=decompose_individual(expr)

    fvig=find(expr==' ');
    
        op=expr(2:fvig(1)-1);
	
        stru=[find(((cumsum(double(double(expr)=='('))-cumsum(double(double(expr)==')'))).*double(double(expr==' '))==1)) length(expr+1)];

 nbct=length(stru)-1;

ind=cell(1,nbct);
 for i=1:nbct
                ind{i}=expr(stru(i)+1:stru(i+1)-1);
            end


















































