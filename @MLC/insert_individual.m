function mlc=insert_individual(mlc,ind)
%INSERT_INDIVIDUAL    Method of the MLC class. Allows insertion of known individual in a first generation
%   MLC_OBJ.INSERTINDIVIDUAL(IND) insert individual IND in the first
%   generation of the MLC object.
%
%   IND has to be a LISP expression compliant with the syntax used in the
%   MLC toolbox and contains only operations defined by <a
%   href="matlab:help OPSET">OPSET</a>.
%   An individual cannot be added in an other generation than the first
%   one. The first generation must not be filled or evaluated.
%
%   ex: 
%     mlc=MLC;
%     mlc.insert_individual('(+ S0 S1)');
%     mlc.insert_individual('(% 0.235 (tanh S0))');
%     mlc
%     mlc.population.individuals
%
%   See also MLC, GENERATE_POPULATION.
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

if isempty(mlc.population);
        fit=zeros(mlc.parameters.size,1);
        idv=cell(mlc.parameters.size,1);
        idv{1}=ind;
        mlc.population.individuals=idv;
        mlc.population.occurence=fit*0+1;
        mlc.population.fitnesses=fit*0-1;
        mlc.population.generatedfrom=fit*0;
        mlc.population.evaluation_problem=fit*0;
        mlc.population.selected=fit*0;
        mlc.individual_table.individuals=cell(mlc.parameters.size*mlc.parameters.fgen,1);
        mlc.individual_table.occurence=zeros(mlc.parameters.size*mlc.parameters.fgen,1);
        mlc.individual_table.fitnesses=zeros(mlc.parameters.size*mlc.parameters.fgen,1);
        mlc.individual_table.nb=0;
    else
        ngen=length(mlc.population);
        if ngen>1
            fprintf('Inserting individual in MLC already started is not recommanded.\n');
            fprintf('Inserting individual in MLC already started is not implemented.\n');
        elseif max(mlc.population(1).fitnesses)>-1
            fprintf('Population already evaluated...\n');
            fprintf('Start a new MLC problem to manually add individuals\n');
        else
            estaempty=zeros(1,mlc.parameters.size);
            for i=1:mlc.parameters.size
                estaempty(i)=isempty(mlc.population(1).individuals{i});
            end
            if max(estaempty)==0
                fprintf('Population Full\n');
                fprintf('Cannot add new individual\n');
            else
                idx=find(estaempty==1,1);
                mlc.population(1).individuals{idx}=ind;
            end
        end
    end
end



















































