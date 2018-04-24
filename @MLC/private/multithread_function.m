function JJ=multithread_function(idv_to_evaluate,eval_idx,ngen,parameters);
    verb=parameters.verbose-1;
    JJ=zeros(1,length(idv_to_evaluate));
    
    istart=1;
    

    %% only one evaluator is used, the function given in parameters.evaluation_fuction is used.

    eval(['heval=@' parameters.evaluation_function ';']);
    f=heval;
    parfor i=istart:length(eval_idx);

        if verb>1;fprintf('Individual %i from generation %i\n',eval_idx(i),ngen);end
        if verb>2;fprintf('%s\n',idv_to_evaluate{i});end
        % translate into formal expression if needed
        if parameters.formal==1
            m=readmylisp_to_formal_MLC(idv_to_evaluate{i},parameters);
        else
            m=idv_to_evaluate{i};
        end
        JJ(i)=feval(f,m,parameters,eval_idx(i));
    end
    
end



