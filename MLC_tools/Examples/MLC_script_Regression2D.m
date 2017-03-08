% MLC_SCRIPT_REGRESSION2D parameters scropt for MLC
% Type mlc=MLC('MLC_script_Regression2D') to create corresponding MLC object
parameters.size = 1000;
parameters.sensors = 2;
parameters.sensor_spec = 0;
parameters.sensor_list = 0;
parameters.controls = 1;
parameters.sensor_prob = 0.2;
parameters.leaf_prob = 0.3;
parameters.range = 10;
parameters.precision = 4;
parameters.opsetrange = [1 2 3];
parameters.formal = 0;
parameters.end_character = '';
parameters.maxdepth = 15;
parameters.maxdepthfirst = 5;
parameters.mindepth = 2;
parameters.mutmaxdepth = 15;
parameters.mutmindepth = 2;
parameters.mutsubtreemindepth = 2;
parameters.generation_method = 'mixed_ramped_gauss';
parameters.gaussigma = 3;
parameters.ramp = [2 3 4 5 6 7 8];
parameters.maxtries = 10;
parameters.no_of_cascades = 0;
parameters.no_of_gen_per_cascade = 0;
parameters.archive_size = 0;
parameters.mutation_types = [1 2 3 4];
parameters.elitism = 1;
parameters.probrep = 0.1;
parameters.probmut = 0.4;
parameters.probcro = 0.5;
parameters.selectionmethod = 'tournament';
parameters.tournamentsize = 7;
parameters.lookforduplicates = 1;
parameters.simplify = 0;
parameters.evaluation_method = 'standalone_function';
parameters.evaluation_function = 'regression2D';
parameters.indfile = 'ind.dat';
parameters.Jfile = 'J.dat';
parameters.exchangedir = '/home/thomas/evaluator0';
parameters.evaluate_all = 0;
parameters.ev_again_best = 0;
parameters.ev_again_nb = 5;
parameters.ev_again_times = 5;
parameters.artificialnoise = 0;
parameters.execute_before_evaluation = '';
parameters.badvalue = 1e+36;
parameters.badvalues_elim = 'first';
parameters.preevaluation = 0;
parameters.preev_function = '';
parameters.save = 1;
parameters.saveincomplete = 1;
parameters.verbose = 2;
parameters.fgen = 250;
parameters.show_best = 1;
parameters.problem_variables.n_points = 10;
parameters.savedir = 'save_GP/regression2D';


















































