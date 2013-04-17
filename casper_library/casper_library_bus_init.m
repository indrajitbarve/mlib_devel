function casper_library_bus_init(varargin)

	warning off Simulink:Engine:MdlFileShadowing;
	mdl = new_system('casper_library_bus', 'Library');
	warning on Simulink:Engine:MdlFileShadowing;

	add_block('built-in/Subsystem', 'casper_library_bus/bus_accumulator');
	bus_accumulator_gen('casper_library_bus/bus_accumulator');
	set_param('casper_library_bus/bus_accumulator', 'Position', [320 17 395 93]);

	add_block('built-in/Subsystem', 'casper_library_bus/bus_add');
	bus_add_gen('casper_library_bus/bus_add');
	set_param('casper_library_bus/bus_add', 'Position', [20 17 95 93]);

	add_block('built-in/Subsystem', 'casper_library_bus/bus_convert');
	bus_convert_gen('casper_library_bus/bus_convert');
	set_param('casper_library_bus/bus_convert', 'Position', [220 132 295 208]);

	add_block('built-in/Subsystem', 'casper_library_bus/bus_logical');
	bus_logical_gen('casper_library_bus/bus_logical');
	set_param('casper_library_bus/bus_logical', 'Position', [20 252 95 328]);

	add_block('built-in/Subsystem', 'casper_library_bus/bus_mult');
	bus_mult_gen('casper_library_bus/bus_mult');
	set_param('casper_library_bus/bus_mult', 'Position', [120 132 195 208]);

	add_block('built-in/Subsystem', 'casper_library_bus/bus_mux');
	bus_mux_gen('casper_library_bus/bus_mux');
	set_param('casper_library_bus/bus_mux', 'Position', [20 132 95 208]);

	add_block('built-in/Subsystem', 'casper_library_bus/bus_register');
	bus_register_gen('casper_library_bus/bus_register');
	set_param('casper_library_bus/bus_register', 'Position', [120 17 195 93]);

	add_block('built-in/Subsystem', 'casper_library_bus/bus_replicate');
	bus_replicate_gen('casper_library_bus/bus_replicate');
	set_param('casper_library_bus/bus_replicate', 'Position', [220 17 295 93]);

	add_block('built-in/Subsystem', 'casper_library_bus/bus_scale');
	bus_scale_gen('casper_library_bus/bus_scale');
	set_param('casper_library_bus/bus_scale', 'Position', [320 132 395 208]);

	set_param(mdl, ...
		'Name', sprintf('casper_library_bus'), ...
		'LibraryType', sprintf('BlockLibrary'), ...
		'Lock', sprintf('off'), ...
		'PreSaveFcn', sprintf('mdl2m(gcs, ''library'', ''on'');'), ...
		'SolverName', sprintf('ode45'), ...
		'SolverMode', sprintf('Auto'), ...
		'StartTime', sprintf('0.0'), ...
		'StopTime', sprintf('10.0'));

	save_system(mdl,[getenv('MLIB_DEVEL_PATH'), '/casper_library/', 'casper_library_bus']);
end % casper_library_bus_init

function bus_accumulator_gen(blk, varargin)

	bus_accumulator_mask(blk, varargin);
	bus_accumulator_init(blk, varargin);
end % bus_accumulator_gen

function bus_accumulator_mask(blk, varargin)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskInitialization', sprintf('bus_accumulator_init(gcb, ...\n    ''reset'', reset, ...\n    ''enable'', enable, ...\n    ''n_bits_in'', n_bits_in, ...\n    ''bin_pt_in'', bin_pt_in, ...\n    ''type_in'', type_in, ...\n    ''cmplx'', cmplx, ...\n    ''n_bits_out'', n_bits_out, ...\n    ''overflow'', overflow, ...\n    ''misc'', misc);'), ...
		'MaskType', sprintf('bus_accumulator'), ...
		'MaskDescription', sprintf('Accumulate components of bus'), ...
		'MaskPromptString', sprintf('reset port|enable port|input bit widths|input binary points|input types (Unsigned=0, Signed=1)|complex inputs|output bit widths|overflow strategy (Wrap=0, Saturate=1, Flag as error=2)|misc support'), ...
		'MaskStyleString', sprintf('checkbox,checkbox,edit,edit,edit,checkbox,edit,edit,checkbox'), ...
		'MaskCallbackString', sprintf('||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('reset=&1;enable=&2;n_bits_in=@3;bin_pt_in=@4;type_in=@5;cmplx=&6;n_bits_out=@7;overflow=@8;misc=&9;'), ...
		'MaskValueString', sprintf('on|on|[]|3|1|on|16|1|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_accumulator_mask

function bus_accumulator_init(blk, varargin)

end % bus_accumulator_init

function bus_add_gen(blk, varargin)

	bus_add_mask(blk, varargin);
	bus_add_init(blk, varargin);
end % bus_add_gen

function bus_add_mask(blk, varargin)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskInitialization', sprintf('bus_add_init(gcb, ...\n    ''n_bits_a'', n_bits_a, ...\n    ''bin_pt_a'', bin_pt_a, ...\n    ''type_a'', type_a, ...\n    ''n_bits_b'', n_bits_b, ...\n    ''bin_pt_b'', bin_pt_b, ...\n    ''type_b'', type_b, ...\n    ''n_bits_out'', n_bits_out, ...\n    ''bin_pt_out'', bin_pt_out, ...\n    ''type_out'', type_out, ...\n    ''overflow'', overflow, ...        \n    ''quantization'', quantization, ...\n    ''add_latency'', add_latency, ...\n    ''cmplx'', cmplx, ...\n    ''misc'', misc);'), ...
		'MaskType', sprintf('bus_add'), ...
		'MaskDescription', sprintf('Add components of two busses'), ...
		'MaskPromptString', sprintf('a input bit widths|a input binary points |a input type (Unsigned=0, Signed=1)|b input bit widths|b input binary points|b input type (Unsigned=0, Signed=1)|complex|misc support|output bit widths|output binary points|output type (Unsigned=0, Signed=1)|quantization strategy (Truncate=0, Round  (unbiased: +/- Inf)=1)|overflow strategy (Wrap=0, Saturate=1, Flag as error=2)|add latency'), ...
		'MaskStyleString', sprintf('edit,edit,edit,edit,edit,edit,checkbox,checkbox,edit,edit,edit,edit,edit,edit'), ...
		'MaskTabNameString', sprintf('input,input,input,input,input,input,input,input,output,output,output,output,output,latency'), ...
		'MaskCallbackString', sprintf('|||||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits_a=@1;bin_pt_a=@2;type_a=@3;n_bits_b=@4;bin_pt_b=@5;type_b=@6;cmplx=&7;misc=&8;n_bits_out=@9;bin_pt_out=@10;type_out=@11;quantization=@12;overflow=@13;add_latency=@14;'), ...
		'MaskValueString', sprintf('[]|3|1|4|3|1|on|on|8|3|1|0|1|1'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_add_mask

function bus_add_init(blk, varargin)

end % bus_add_init

function bus_convert_gen(blk, varargin)

	bus_convert_mask(blk, varargin);
	bus_convert_init(blk, varargin);
end % bus_convert_gen

function bus_convert_mask(blk, varargin)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskInitialization', sprintf('bus_convert_init(gcb, ...\n    ''n_bits_in'', n_bits_in, ...\n    ''bin_pt_in'', bin_pt_in, ...\n    ''type_in'', type_in, ...\n    ''cmplx'', cmplx, ...\n    ''n_bits_out'', n_bits_out, ...\n    ''bin_pt_out'', bin_pt_out, ...\n    ''type_out'', type_out, ...\n    ''quantization'', quantization, ...\n    ''overflow'', overflow, ...\n    ''latency'', latency, ...\n    ''misc'', misc);'), ...
		'MaskType', sprintf('bus_cast'), ...
		'MaskDescription', sprintf('Convert components of busses'), ...
		'MaskPromptString', sprintf('input bit widths|input binary points |input types|input complex|output bit widths|output binary points|output type (Unsigned=0, Signed=1)|quantization strategy (Truncate=0, Round  (unbiased: +/- Inf)=1, Round (unbiased: Even Values)=2)|overflow strategy (Wrap=0, Saturate=1, Flag as error=2)|latency|misc support'), ...
		'MaskStyleString', sprintf('edit,edit,edit,checkbox,edit,edit,edit,edit,edit,edit,checkbox'), ...
		'MaskTabNameString', sprintf('input,input,input,input,output,output,output,output,output,latency,input'), ...
		'MaskCallbackString', sprintf('||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits_in=@1;bin_pt_in=@2;type_in=@3;cmplx=&4;n_bits_out=@5;bin_pt_out=@6;type_out=@7;quantization=@8;overflow=@9;latency=@10;misc=&11;'), ...
		'MaskValueString', sprintf('[]|8|1|off|8|4|1|1|1|2|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_convert_mask

function bus_convert_init(blk, varargin)

end % bus_convert_init

function bus_logical_gen(blk, varargin)

	bus_logical_mask(blk, varargin);
	bus_logical_init(blk, varargin);
end % bus_logical_gen

function bus_logical_mask(blk, varargin)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskInitialization', sprintf('bus_logical_init(gcb, ...\n    ''logical_function'', logical_function, ...\n    ''en'', en, ...\n    ''n_bits_a'', n_bits_a, ...\n    ''bin_pt_a'', bin_pt_a, ...\n    ''type_a'', type_a, ...\n    ''n_bits_b'', n_bits_b, ...\n    ''bin_pt_b'', bin_pt_b, ...\n    ''type_b'', type_b, ...\n    ''n_bits_out'', n_bits_out, ...\n    ''bin_pt_out'', bin_pt_out, ...\n    ''type_out'', type_out, ...\n    ''latency'', latency, ...\n    ''cmplx'', cmplx, ...\n    ''align_bp'', align_bp, ...\n    ''misc'', misc);'), ...
		'MaskType', sprintf('bus_logical'), ...
		'MaskDescription', sprintf('Form the logical product of two busses'), ...
		'MaskPromptString', sprintf('logical function|align binary point|latency|a input bit widths|a input binary points |a input type (Unsigned=0, Signed=1)|b input bit widths|b input binary points|b input type (Unsigned=0, Signed=1)|complex|en port|misc support|output bit widths|output binary points|output type (Unsigned=0, Signed=1)'), ...
		'MaskStyleString', sprintf('popup(AND|NAND|OR|NOR|XOR|XNOR),checkbox,edit,edit,edit,edit,edit,edit,edit,checkbox,checkbox,checkbox,edit,edit,edit'), ...
		'MaskTabNameString', sprintf('operation,operation,operation,input,input,input,input,input,input,input,input,input,output,output,output'), ...
		'MaskCallbackString', sprintf('||||||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('logical_function=&1;align_bp=&2;latency=@3;n_bits_a=@4;bin_pt_a=@5;type_a=@6;n_bits_b=@7;bin_pt_b=@8;type_b=@9;cmplx=&10;en=&11;misc=&12;n_bits_out=@13;bin_pt_out=@14;type_out=@15;'), ...
		'MaskValueString', sprintf('AND|on|1|[]|3|1|4|3|1|on|on|on|8|3|1'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_logical_mask

function bus_logical_init(blk, varargin)

end % bus_logical_init

function bus_mult_gen(blk, varargin)

	bus_mult_mask(blk, varargin);
	bus_mult_init(blk, varargin);
end % bus_mult_gen

function bus_mult_mask(blk, varargin)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskInitialization', sprintf('bus_mult_init(gcb, ...\n    ''n_bits_a'', n_bits_a, ...\n    ''bin_pt_a'', bin_pt_a, ...\n    ''type_a'', type_a, ...\n    ''cmplx_a'', cmplx_a, ...\n    ''n_bits_b'', n_bits_b, ...\n    ''bin_pt_b'', bin_pt_b, ...\n    ''type_b'', type_b, ...\n    ''cmplx_b'', cmplx_b, ...\n    ''n_bits_out'', n_bits_out, ...\n    ''bin_pt_out'', bin_pt_out, ...\n    ''type_out'', type_out, ...\n    ''quantization'', quantization, ...\n    ''overflow'', overflow, ...\n    ''mult_latency'', mult_latency, ...\n    ''add_latency'', add_latency, ...\n    ''misc'', misc);'), ...
		'MaskType', sprintf('bus_mult'), ...
		'MaskDescription', sprintf('Multiply components of two busses'), ...
		'MaskPromptString', sprintf('a input bit widths|a input binary points |a input type (Unsigned=0, Signed=1)|a input complex|b input bit widths|b input binary points|b input type (Unsigned=0, Signed=1)|b input complex|output bit widths|output binary points|output type (Unsigned=0, Signed=1)|quantization strategy (Truncate=0, Round  (unbiased: +/- Inf)=1)|overflow strategy (Wrap=0, Saturate=1, Flag as error=2)|multiplier latency|adder latency|misc support'), ...
		'MaskStyleString', sprintf('edit,edit,edit,checkbox,edit,edit,edit,checkbox,edit,edit,edit,edit,edit,edit,edit,checkbox'), ...
		'MaskTabNameString', sprintf('input,input,input,input,input,input,input,input,output,output,output,output,output,latency,latency,input'), ...
		'MaskCallbackString', sprintf('|||||||||||||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on,on,on,on,on,on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits_a=@1;bin_pt_a=@2;type_a=@3;cmplx_a=&4;n_bits_b=@5;bin_pt_b=@6;type_b=@7;cmplx_b=&8;n_bits_out=@9;bin_pt_out=@10;type_out=@11;quantization=@12;overflow=@13;mult_latency=@14;add_latency=@15;misc=&16;'), ...
		'MaskValueString', sprintf('[]|4|1|on|[]|3|1|on|12|7|1|0|0|3|1|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_mult_mask

function bus_mult_init(blk, varargin)

end % bus_mult_init

function bus_mux_gen(blk, varargin)

	bus_mux_mask(blk, varargin);
	bus_mux_init(blk, varargin);
end % bus_mux_gen

function bus_mux_mask(blk, varargin)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskInitialization', sprintf('bus_mux_init(gcb, ...\n    ''n_bits'', n_bits, ...\n    ''cmplx'', cmplx, ...\n    ''misc'', misc, ...\n    ''mux_latency'', mux_latency);'), ...
		'MaskType', sprintf('bus_mux'), ...
		'MaskDescription', sprintf('Mux components of bus'), ...
		'MaskPromptString', sprintf('input bit widths|mux latency|complex data|misc support'), ...
		'MaskStyleString', sprintf('edit,edit,checkbox,checkbox'), ...
		'MaskTabNameString', sprintf('input,latency,input,input'), ...
		'MaskCallbackString', sprintf('|||'), ...
		'MaskEnableString', sprintf('on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits=@1;mux_latency=@2;cmplx=&3;misc=&4;'), ...
		'MaskValueString', sprintf('[]|1|on|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_mux_mask

function bus_mux_init(blk, varargin)

end % bus_mux_init

function bus_register_gen(blk, varargin)

	bus_register_mask(blk, varargin);
	bus_register_init(blk, varargin);
end % bus_register_gen

function bus_register_mask(blk, varargin)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskInitialization', sprintf('bus_register_init(gcb, ...\n    ''reset'', reset, ...\n    ''enable'', enable, ...\n    ''cmplx'', cmplx, ...\n    ''n_bits'', n_bits, ...\n    ''misc'', misc);'), ...
		'MaskType', sprintf('bus_register'), ...
		'MaskDescription', sprintf('Register components of bus'), ...
		'MaskPromptString', sprintf('reset port|enable port|complex data|input bit widths|misc support'), ...
		'MaskStyleString', sprintf('checkbox,checkbox,checkbox,edit,checkbox'), ...
		'MaskCallbackString', sprintf('||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on'), ...
		'MaskVariables', sprintf('reset=&1;enable=&2;cmplx=&3;n_bits=@4;misc=&5;'), ...
		'MaskValueString', sprintf('on|on|on|[]|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_register_mask

function bus_register_init(blk, varargin)

end % bus_register_init

function bus_replicate_gen(blk, varargin)

	bus_replicate_mask(blk, varargin);
	bus_replicate_init(blk, varargin);
end % bus_replicate_gen

function bus_replicate_mask(blk, varargin)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskInitialization', sprintf('bus_replicate_init(gcb, ...\n    ''replication'', replication, ...\n    ''misc'', misc);'), ...
		'MaskType', sprintf('bus_replicate'), ...
		'MaskDescription', sprintf('Output bus formed by replicating input bus a number of times'), ...
		'MaskPromptString', sprintf('replication factor|misc support'), ...
		'MaskStyleString', sprintf('edit,checkbox'), ...
		'MaskCallbackString', sprintf('|'), ...
		'MaskEnableString', sprintf('on,on'), ...
		'MaskVisibilityString', sprintf('on,on'), ...
		'MaskToolTipString', sprintf('on,on'), ...
		'MaskVariables', sprintf('replication=@1;misc=&2;'), ...
		'MaskValueString', sprintf('0|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_replicate_mask

function bus_replicate_init(blk, varargin)

end % bus_replicate_init

function bus_scale_gen(blk, varargin)

	bus_scale_mask(blk, varargin);
	bus_scale_init(blk, varargin);
end % bus_scale_gen

function bus_scale_mask(blk, varargin)

	set_param(blk, ...
		'Mask', sprintf('on'), ...
		'MaskSelfModifiable', sprintf('on'), ...
		'MaskInitialization', sprintf('bus_scale_init(gcb, ...\n    ''n_bits_in'', n_bits_in, ...\n    ''bin_pt_in'', bin_pt_in, ...\n    ''type_in'', type_in, ...\n    ''cmplx'', cmplx, ...\n    ''scale_factor'', scale_factor, ...\n    ''misc'', misc);'), ...
		'MaskType', sprintf('bus_scale'), ...
		'MaskDescription', sprintf('Convert components of busses'), ...
		'MaskPromptString', sprintf('input bit widths|input binary points |input types|input complex|scale factor (2^?)|misc support'), ...
		'MaskStyleString', sprintf('edit,edit,edit,checkbox,edit,checkbox'), ...
		'MaskTabNameString', sprintf('input,input,input,input,output,input'), ...
		'MaskCallbackString', sprintf('|||||'), ...
		'MaskEnableString', sprintf('on,on,on,on,on,on'), ...
		'MaskVisibilityString', sprintf('on,on,on,on,on,on'), ...
		'MaskToolTipString', sprintf('on,on,on,on,on,on'), ...
		'MaskVariables', sprintf('n_bits_in=@1;bin_pt_in=@2;type_in=@3;cmplx=&4;scale_factor=@5;misc=&6;'), ...
		'MaskValueString', sprintf('[]|8|1|off|2|on'), ...
		'BackgroundColor', sprintf('[0.501961, 1.000000, 0.501961]'));

end % bus_scale_mask

function bus_scale_init(blk, varargin)

end % bus_scale_init

