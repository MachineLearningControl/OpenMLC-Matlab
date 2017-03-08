function [md,cp]=show_treedepth(mlc)
%SHOW_TREEDEPTH    Method of the MLC class. Graphs tree-depth repartition.
%
%   MLC_OBJ.SHOW_TREEDEPTH 
%
%   See also MLC, SHOW_CONVERGENCE, STATS, SHOW_STATS
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

if isempty(mlc.population)
    display('You need at least one population.');
    display('Use MLC_OBJ.generate_population.');
    return
end

mdepth=mlc.parameters.maxdepth;
pop=mlc.population;
md=zeros(length(pop(1).individuals),length(pop));
for j=1:length(pop);
for i=1:length(pop(1).individuals);
m=pop(j).individuals{i};
maxdepth=max(cumsum(m=='(')-cumsum(m==')'));
md(i,j)=maxdepth;
cp(i,j)=length(strfind(m,' '));

end
end
hmd=zeros(length(pop),mdepth);

for j=1:length(pop);
hmd(j,:)=hist(md(:,j),1:mdepth);
end

plot3(repmat(1:mdepth,[length(pop) 1])',repmat((1:length(pop))',[1 mdepth])',(hmd'))


















































