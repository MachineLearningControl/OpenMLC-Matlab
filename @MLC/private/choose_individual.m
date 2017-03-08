function idx=choose_individual(mlc,nindivs)
%CHOOSE_INDIVIVIDUAL    Private function of the MLC CLASS. Implements individual selection.
%    idx=choose_individual(MLC_OBJ,NINDIVS) returns NINDIVS indices
%    corresponding to individuals in the preceding generation. This funtion
%    is called by <a href="matlab:help
%    fill_population">fill_population</a>. 
%
%    Two selection methods are implemented, tournament and fitness
%    proportional. See <a href="matlab:help MLC/parameters">MLC parameters</a>.
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

 
%% Output initialization and other tiny stuff
    idx=zeros(1,nindivs);
    ngen=length(mlc.population)-1;                      %% the ngen+1 generation is being processed but we work on ngen.
    nind=length(mlc.population(ngen).individuals);      %% number of individuals
%% Method selection
    switch mlc.parameters.selectionmethod
%% Method: Tournament
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A tournament consist in choosing a number tournamentsize of             %
% individuals by a random process (equal weight for each individual). Out %
% of these individuals the one with the best fitness is chosen. If two are%
% needed two tournaments are performed                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



    case 'tournament'
        selected=zeros(1,mlc.parameters.tournamentsize);  %% initialisation of selected individuals for tournament
        for i=1:mlc.parameters.tournamentsize        %% selecting the individuals
            n=ceil(rand*nind);                   %% random integer between 1 and nind
            while max(n==selected)               %% avoid repetition 
                n=ceil(rand*nind);
            end
            selected(i)=n;
        end
        f=mlc.population(ngen).fitnesses(selected);         %% retrieve individuals fitness
        [~,k]=min(f);                            %% find the MINIMUM
        idx(1)=selected(k);                      %% and here we are

        if nindivs==2                            %% if needed, run another time
            selected=zeros(1,mlc.parameters.tournamentsize);
            for i=1:mlc.parameters.tournamentsize
                n=ceil(rand*nind);
                while max(n==[selected idx(1)])  %% avoid repetition and selecting the same
                    n=ceil(rand*nind);
                end
                selected(i)=n;
            end
            f=mlc.population(ngen).fitnesses(selected);
            [~,k]=min(f);
            idx(2)=selected(k);
        end
        case 'fitness_proportional'
            adj_fit=1./(1+mlc.population(ngen).fitnesses); % between 0 and 1
            probs=adj_fit/sum(adj_fit);              % beter indies have better probs and sum(probs)=1
            table=cumsum(probs);                     % lookup table for random number between 0 and 1
            n=rand(1,nindivs);
            [~,idx]=min(abs(repmat(n,[nind 1])-repmat(table,[1 nindivs])));                        
    end
end
        
            


















































