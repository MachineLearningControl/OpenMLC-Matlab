function mlc=evaluate_population(mlc,~)
%EVALUATE_POPULATION    Method of the MLC class. Evaluates population.
%
%   MLC_OBJ.EVALUATE_POPULATION evaluates cost of individuals and update
%   the MLC object MLC_OBJ.
%
%   All options are set in the MLC object (See <a href="matlab:help MLC">MLC</a>).
%
%   Implemented: - evaluation with m-file function (standalone and
%                  multihread), external evaluation with file exchange.
%                - detection of bad individuals (above a threshold) and
%                  their replacement.
%                - evaluation or not of already evaluated individuals.
%                - averaging of all past cost values for a given individual
%                  if evaluation are repeated (for experiments or numerics
%                  with random noise).
%
%   See also MLC, GENERATE_POPULATION, EVOLVE_POPULATION, REMOVE_BADVALUES
%
%   Copyright (C) 2016 Thomas Duriez, Steven Brunton, Bernd Noack
%   This file is part of the OpenMLC Toolbox. Distributed under GPL v3.

%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.

 
%% Start program


%% Utility
verb=mlc.parameters.verbose;
ngen=length(mlc.population);                                          %% number of current generation
nind=length(mlc.population(ngen).individuals);                        %% number of individuals
%% Common variables for every method
if (mlc.parameters.evaluate_all>0 && mlc.parameters.badvalues_elimswitch)
    eval_idx=1:nind;
    if verb>0;fprintf('Starting evaluation of generation %i\n',ngen);end
else
    eval_idx=find(mlc.population(ngen).fitnesses==-1);                %% select individuals with unknown fitness
    if verb>0;fprintf('Completing evaluation of generation %i\n',ngen);end
end
if verb>0;fprintf('%i indivuals to evaluate\n',length(eval_idx));end
idv_to_evaluate=mlc.population(ngen).individuals(eval_idx);
gen_param=mlc.parameters;
JJ=zeros(1,length(eval_idx));


%% Beginning of evaluation
if verb>1;fprintf(['Evaluation method: "' mlc.parameters.evaluation_method '"\n']);end

heval=[];
eval(['heval=@' mlc.parameters.evaluation_method ';']);

JJ=feval(heval,idv_to_evaluate,eval_idx,ngen,mlc.parameters);

%% Database management
if verb>0;fprintf('Updating database\n');end
for i=1:length(eval_idx);
    if verb>2;fprintf('Individual %i from generation %i\n',eval_idx(i),ngen);end
    if verb>2;fprintf('%s\n',mlc.population(ngen).individuals{eval_idx(i)});end
    J=JJ(i);
    if isnan(J) || isinf(J)
        if verb>4;fprintf('That''s a NaN !\n');end
        J=mlc.parameters.badvalue;
    end
    
    if J>mlc.parameters.badvalue;
        J=mlc.parameters.badvalue;
    end
    
    if verb>4
        if mlc.population(ngen).occurence(eval_idx(i))-1>0 && J~= mlc.population(ngen).fitnesses(eval_idx(i))
            fprintf('Past occurence: %i\n', mlc.population(ngen).occurence(eval_idx(i))-1);
            fprintf('New value: %e\n',J)
            fprintf('Old value: %e\n', mlc.population(ngen).fitnesses(eval_idx(i)));
            mlc.population(ngen).evaluation_problem(eval_idx(i))=1;
            fprintf('Inconsistency in the J values !\n')
            fprintf('If the work is numeric without source of noise it might be a problem\n')
        end
    end
    
    
    if J~= mlc.population(ngen).fitnesses(eval_idx(i))
        mlc.population(ngen).evaluation_problem(eval_idx(i))=1;
    end
    %mlc.population(ngen).fitnesses(eval_idx(i))=(mlc.population(ngen).fitnesses(eval_idx(i))*(mlc.population(ngen).occurence(eval_idx(i))-1)...
    %    + J)/mlc.population(ngen).occurence(eval_idx(i)); %% newJ = (meanJ*previous occurence + actualJ)/all_occurences
    % Update individual table mlc.individual_table or create if not
    % present
    k=find(strcmp(mlc.population(ngen).individuals{eval_idx(i)},mlc.individual_table.individuals));
    if isempty(k)
        mlc.individual_table.nb=mlc.individual_table.nb+1;
        mlc.individual_table.individuals{mlc.individual_table.nb}=mlc.population(ngen).individuals{eval_idx(i)};
        mlc.individual_table.occurence(mlc.individual_table.nb)=1;
        %mlc.individual_table.fitnesses(mlc.individual_table.nb)=mlc.population(ngen).fitnesses(eval_idx(i));
        mlc.individual_table.pastfitness{mlc.individual_table.nb}=J;
        mlc.population(ngen).fitnesses(eval_idx(i))=J;
        mlc.individual_table.fitnesses(mlc.individual_table.nb)=J;
    else
        mlc.individual_table.occurence(k)=mlc.individual_table.occurence(k)+1;
        %mlc.individual_table.fitnesses(k)=mlc.population(ngen).fitnesses(eval_idx(i));
        mlc.individual_table.pastfitness{k}=[mlc.individual_table.pastfitness{k} J];
        if mlc.parameters.evaluate_all==2 %% evaluate all but without average
            mlc.population(ngen).fitnesses(eval_idx(i))=J;
        else
            mlc.population(ngen).fitnesses(eval_idx(i))=mean(mlc.individual_table.pastfitness{k});
        end
        mlc.individual_table.fitnesses(k)=mean(mlc.individual_table.pastfitness{k});
    end
    if verb>2;fprintf('J=%.4e\n',J);end
    if verb>2;fprintf('J_mean=%.4e\n',mlc.population(ngen).fitnesses(eval_idx(i)));end
end

%% Eliminate meaningless individuals (All the individuals with fitness=badvalue)
switch mlc.parameters.badvalues_elim
    case 'none'
    case 'first'
        if ngen==1
            if verb>1;fprintf('Replacing bad individuals\n');end
            mlc=mlc.remove_badvalues;
        end
    case 'all'
        if verb>1;fprintf('Replacing bad individuals\n');end
        mlc=mlc.remove_badvalues;
end



%% End of evaluate_population


% Sort population
if nargin<2 % if nargin < 2 then we are in the original call,
    % not a call from remove_badvalues or this loop.
    % this is where we evaluate again the best individuals
    [~,idx]=sort(mlc.population(ngen).fitnesses,'ascend');
    mlc.population(ngen).individuals=mlc.population(ngen).individuals(idx);
    mlc.population(ngen).fitnesses=mlc.population(ngen).fitnesses(idx);
    mlc.population(ngen).occurence=mlc.population(ngen).occurence(idx);
    mlc.population(ngen).generatedfrom=mlc.population(ngen).generatedfrom(idx);
    mlc.population(ngen).selected=mlc.population(ngen).selected(idx);
 
    if mlc.parameters.ev_again_best
        if verb>0;fprintf('Reevaluating best individuals\n');end
        for i=1:mlc.parameters.ev_again_times
            for j=1:mlc.parameters.ev_again_nb
                mlc.population(ngen).occurence(j)=mlc.population(ngen).occurence(j)+1;
                mlc.population(ngen).fitnesses(j)=-1;
            end
            mlc.parameters.elimswitch(0);
            mlc.evaluate_population('again');
            mlc.parameters.elimswitch(1);
            [~,idx]=sort(mlc.population(ngen).fitnesses,'ascend');
            mlc.population(ngen).individuals=mlc.population(ngen).individuals(idx);
            mlc.population(ngen).fitnesses=mlc.population(ngen).fitnesses(idx);
            mlc.population(ngen).occurence=mlc.population(ngen).occurence(idx);
            mlc.population(ngen).generatedfrom=mlc.population(ngen).generatedfrom(idx);
            mlc.population(ngen).selected=mlc.population(ngen).selected(idx);
        end
        [~,idx]=sort(mlc.population(ngen).fitnesses,'ascend');
        mlc.population(ngen).individuals=mlc.population(ngen).individuals(idx);
        mlc.population(ngen).fitnesses=mlc.population(ngen).fitnesses(idx);
        mlc.population(ngen).occurence=mlc.population(ngen).occurence(idx);
        mlc.population(ngen).generatedfrom=mlc.population(ngen).generatedfrom(idx);
        mlc.population(ngen).selected=mlc.population(ngen).selected(idx);
        
    end
    if verb>0;fprintf('Population successfully evaluated\n');end
end



end






































































