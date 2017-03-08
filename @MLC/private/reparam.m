function [m]=reparam(m,gen_param)
    preevok=0; 
    fail_count=0;
    while preevok==0
        [m]=change_const(m,gen_param);
        preevok=1;
        if gen_param.preevaluation
            eval(['peval=@' gen_param.preev_function ';']);
            f=peval;
            preevok=feval(f,m,gen_param);
        end
        if preevok==0
            fail_count=fail_count+1;
        end
        if fail_count>gen_param.maxtries
            m=[];
            preevok=-1;
        end
    end
end
	 

    


















































