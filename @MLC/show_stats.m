
function show_stats(mlc,loglin)
%SHOW_STATS    Method of the MLC class. Graphs cost repartition.
%
%   MLC_OBJ.SHOW_STATS 
%   MLC_OBJ.SHOW_STATS(LINLOG) plots minimum, average, standart deviation
%   and maximum of cost values through the generations.
%
%   LINLOG       - logarithmic (0) or linear (1) scale (default 1).
%
%   See also MLC, SHOW_CONVERGENCE, STATS, SHOW_TREEDEPTH
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

if nargin<2
    loglin=0;
end
pop=mlc.population;
lgen=length(pop);
if isempty(mlc.population)
    display('You need at least two evaluated generations.');
    display('Use MLC_OBJ.stats.');
    return
end
if min(pop(lgen).fitnesses)==-1
    lgen=lgen-1;
end
if lgen<2
    display('You need at least two evaluated generations.');
    display('Use MLC_OBJ.stats.');
    return
end

minJ=zeros(1,lgen);
meanJ=minJ;
stdJ=minJ;
maxJ=minJ;
if isempty(pop(1).fitnesses)
    fprintf('Maybe start the GP before you ask some stats\n');
    fprintf('(And that''s me beeing polite here...)\n');
else
    for ngen=1:lgen;
        
        
        minJ(ngen)=min(pop(ngen).fitnesses);
        meanJ(ngen)=mean(pop(ngen).fitnesses(pop(ngen).fitnesses<mlc.parameters.badvalue/10));
        stdJ(ngen)=std(pop(ngen).fitnesses(pop(ngen).fitnesses<mlc.parameters.badvalue/10));
        maxJ(ngen)=max(pop(ngen).fitnesses(pop(ngen).fitnesses<mlc.parameters.badvalue/10));
        medJ(ngen)=median(pop(ngen).fitnesses(pop(ngen).fitnesses<mlc.parameters.badvalue/10));
        
        grid on
        
    end
    my_statistics=[minJ;meanJ;stdJ;medJ;maxJ];
    
        plot(1:lgen,my_statistics,'linewidth',1.2);
        legend('Minimum','Average','Std deviation','Median','Maximum')
        grid on
        if loglin==0
            set(gca,'Yscale','log')
        end
        set(gca,'fontsize',13)
    set(gcf,'PaperPositionMode','auto')
    set(gcf,'Position',[100 100 600 500])
   % print('-depsc2', '-loose', '../../main/figures/c7/c7_basic_stats.eps');
end




















































