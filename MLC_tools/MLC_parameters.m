classdef MLC_parameters < handle
%MLC_PARAMETERS   Function for the constructor the MLC Class. Sets default values and calls parameters script.
%  PARAMETERS=set_MLC_parameters returns a pre-structure of parameters for
%  the MLC Class, with default values. (solves 'toy_problem').
%  PARAMETERS=set_MLC_parameters(FILENAME) returns a pre-structure of 
%  parameters for the MLC Class with default values overriden by
%  instructions in the FILENAME M-script. Ex: <a href="matlab:help GP_lorenz">GP_lorenz.m</a>
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

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DO NOT MODIFY THIS FILE, USE A SCRIPT TO CHANGE VALUES  %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
properties
    size
    sensors
    sensor_spec
    sensor_list
    controls
    sensor_prob
    leaf_prob
    range
    precision
    opsetrange
    opset
    formal
    end_character
    
    maxdepth
    maxdepthfirst
    mindepth
    mutmaxdepth
    mutmindepth
    mutsubtreemindepth
    generation_method
    gaussigma
    ramp
    maxtries
    mutation_types
    
    elitism
    probrep
    probmut
    probcro
    selectionmethod
    tournamentsize
    lookforduplicates
    simplify

    evaluation_method
    evaluation_function
    indfile
    Jfile
    exchangedir
    evaluate_all
    ev_again_best
    ev_again_nb
    ev_again_times
    artificialnoise
    execute_before_evaluation
    badvalue
    badvalues_elim
    preevaluation
    preev_function
    
    save
    saveincomplete
    verbose
    fgen
    show_best
    problem_variables
end

properties 
    savedir
end

properties (SetAccess = private, Hidden)   
    badvalues_elimswitch=1;
    dispswitch=0;
end

methods
    function parameters=elimswitch(parameters,value)
        parameters.badvalues_elimswitch=value;
    end
    function parameters=disp_switch(parameters,value)
        parameters.dispswitch=value;
    end
    
    %% Constructor
    function parameters=MLC_parameters(filename)
    %% Individuals specific parameters
        parameters.size=1000;
        parameters.sensors=1;
        parameters.sensor_spec=0;
        parameters.sensor_list=0:parameters.sensors-1;
        parameters.controls=1;
        parameters.sensor_prob=0.20;
        parameters.leaf_prob=0.3;
        parameters.range=10;
        parameters.precision=4;
        parameters.opsetrange=[1:3 9]; 
        parameters.formal=0;
        parameters.end_character='';


        %%  GP algortihm parameters (CHANGE IF YOU KNOW WHAT YOU DO)
        parameters.maxdepth=15;
        parameters.maxdepthfirst=5;
        parameters.mindepth=2;
        parameters.mutmindepth=2;
        parameters.mutmaxdepth=15;
        parameters.mutsubtreemindepth=2;
        parameters.generation_method='mixed_ramped_gauss';
        parameters.gaussigma=3;
        parameters.ramp=[2:8];
        parameters.maxtries=10;
        parameters.mutation_types=1:4;


        %%  Optimization parameters
        parameters.elitism=10;
        parameters.probrep=0.1;
        parameters.probmut=0.4;
        parameters.probcro=0.5;
        parameters.selectionmethod='tournament';
        parameters.tournamentsize=7;
        parameters.lookforduplicates=1;
        parameters.simplify=0;     

        %%  Evaluator parameters 
        parameters.evaluation_method='standalone_function';
        %parameters.evaluation_method='standalone_files';
        %parameters.evaluation_method='multithread_function';
        parameters.evaluation_function='toy_problem';
        parameters.indfile='ind.dat';
        parameters.Jfile='J.dat';
        parameters.exchangedir=fullfile(pwd,'evaluator0');
        parameters.evaluate_all=0;
        parameters.ev_again_best=0;
        parameters.ev_again_nb=5;
        parameters.ev_again_times=5;
        parameters.artificialnoise=0;
        parameters.execute_before_evaluation='';
        parameters.badvalue=10^36;
        parameters.badvalues_elim='first';
        %parameters.badvalues_elim='none';
        %parameters.badvalues_elim='all';
        parameters.preevaluation=0;
        parameters.preev_function='';

        %% MLC behaviour parameters 
        parameters.save=1;
        parameters.saveincomplete=1;
        parameters.verbose=2;
        parameters.fgen=250; 
        parameters.show_best=1;
        parameters.savedir=fullfile(pwd,'save_GP');

        %% Call configuration script if present
        if nargin==1
            fprintf(1,'%s\n',filename);
            run(filename)
        end
        
        
        parameters.savedir=fullfile(parameters.savedir,datestr(now,'yyyymmdd-HHMM'));
        [s,mess,messid] = mkdir(parameters.savedir);
        if s==1
            clear s;clear mess;clear messid;
        else
           fprintf('%s',mess);
        end

    end
end
end





















































