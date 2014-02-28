program_name='amx-dgx-api'

#if_not_defined __AMX_DGX_LISTENER__
#define __AMX_DGX_LISTENER__

/*
 * --------------------
 * amx-dgx-listener
 *
 * For usage, check out the readme for the amx-dgx-library.
 * --------------------
 */

define_constant

char VERSION_AMX_DGX_LISTENER[] = 'v1.0.0'

include 'amx-dgx-api'
//#include 'common'



/*
 * --------------------
 * Device arrays
 * --------------------
 */

define_variable

#if_not_defined dvDgxSwitchers
dev dvDgxSwitchers[] = { 5002:2:0 }
#end_if

#if_not_defined dvDgxDiagnoticsAuxileries
dev dvDgxDiagnoticsAuxileries[] = { 5002:3:0 }
#end_if


/*
 * --------------------
 * Callback functions
 * --------------------
 */


#define INCLUDE_DGX_NOTIFY_SWITCH_CALLBACK
define_function dgxNotifySwitch (dev dgxSwitcher, integer input, integer outputs[])
{
	// dgxSwitcher is the D:P:S of the DGX switcher
	// input is the input on the switcher that is routed to the outputs
	// outputs is an array containing the outputs that input is routed to on the switcher
}

#define INCLUDE_DGX_NOTIFY_OUTPUT_STATUS_CALLBACK
define_function dgxNotifyOutputStatus (dev dgxSwitcher, integer output, integer input)
{
	// dgxSwitcher is the D:P:S of the DGX switcher
	// output is the output on the switcher
	// input is the input on the switcher that is routed to the output
}

#define INCLUDE_DGX_NOTIFY_INPUT_STATUS_CALLBACK
define_function dgxNotifyInputStatus (dev dgxSwitcher, integer input, integer outputs[])
{
	// dgxSwitcher is the D:P:S of the DGX switcher
	// input is the input on the switcher that is routed to the outputs
	// outputs is an array containing the outputs that input is routed to on the switcher
}



/*
 * --------------------
 * Events to capture responses from the DVX or update notifications
 * --------------------
 */

define_event


/*
 * --------------------
 * Data events
 * --------------------
 */

data_event[dvDgxSwitchers]
{
	command:
	{
		#warn '@TODO - amx-dgx-listener - data_event to capture returned commands from DGX switchers'
	}
}

data_event[dvDgxDiagnoticsAuxileries]
{
	command:
	{
		#warn '@TODO - amx-dgx-listener - data_event to capture responses on the diagnostics/auxilery ports'
	}
}


#end_if