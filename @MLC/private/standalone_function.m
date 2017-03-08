function JJ=standalone_function(idv_to_evaluate,eval_idx,ngen,parameters);
    verb=parameters.verbose-1;
    JJ=zeros(1,length(idv_to_evaluate));
    %% Check if method was interupted
    if exist(fullfile(parameters.savedir,'MLC_incomplete.mat'),'file') && parameters.saveincomplete==1;
        ic=0;
        load(fullfile(parameters.savedir,'MLC_incomplete.mat'),'JJ','ic');
        istart=ic;
    else
        istart=1;
    end

    %% only one evaluator is used, the function given in parameters.evaluation_fuction is used.

    eval(['heval=@' parameters.evaluation_function ';']);
    f=heval;
    for i=istart:length(eval_idx);

        if parameters.saveincomplete==1
            ic=i;
            save(fullfile(parameters.savedir,'MLC_incomplete.mat'),'JJ','ic');
        end
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
    %% Delete incomplete evaluation savefile
    if  parameters.saveincomplete==1 && ~strcmp(parameters.evaluation_method,'multithread_function')...
            && ~strcmp(parameters.evaluation_method,'standalone_function_generation');
        delete(fullfile(parameters.savedir,'MLC_incomplete.mat'));
    end
end


















































