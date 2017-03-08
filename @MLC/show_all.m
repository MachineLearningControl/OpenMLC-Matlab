function show_all(mlc,fig)   
    if isempty(mlc.population)
        return
    else
        ngen=length(mlc.population);
        if min(mlc.population(ngen).fitnesses)==-1
            ngen=ngen-1;
        end
        if ngen<2
            return
        end
        
        if fig>1
        figure(fig-1)
        s=subplot(1,2,1);
        Jmax=max(mlc.population(ngen).fitnesses(mlc.population(ngen).fitnesses<mlc.parameters.badvalue));
        Jmin=min(mlc.population(ngen).fitnesses);
        mlc.show_convergence(1000,0,Jmax,0,1,[1:ngen],s);
        hold off
        s=subplot(1,2,2);
        k=ceil(log(Jmax/Jmin)/log(10));
        refvalues=[Jmin*10.^(0:k)];
            if ngen<=15
            mlc.genealogy(ngen,1,[],s)
            else
            mlc.genealogy([],[],[],s)
        end
        hold off
        set(gcf,'PaperPositionMode','auto')
        set(gcf,'Position',[100 100 650*2 500])
        else
            s=gca;
            Jmax=max(mlc.population(ngen).fitnesses(mlc.population(ngen).fitnesses<mlc.parameters.badvalue));
        Jmin=min(mlc.population(ngen).fitnesses);
        mlc.show_convergence(1000,0,Jmax,0,1,[1:ngen],s);
        end
            
    end
end
        


















































