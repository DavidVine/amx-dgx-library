program_name='amx-dgx-api'


#if_not_defined __AMX_DGX_CONTROL__
#define __AMX_DGX_CONTROL__

/*
 * --------------------
 * amx-dgx-control
 *
 * For usage, check out the readme for the amx-dgx-library.
 * --------------------
 */

define_constant

char VERSION_AMX_DGX_CONTROL[] = 'v1.0.0'

#include 'amx-dgx-api'
#include 'amx-device-control'
//#include 'common'


/*
 * --------------------
 * Function Naming Format
 * 
 * dgxRequestXXXXXXXX
 *  - call the dgxRequest functions to request information from a DGX.
 * 
 * dgxSetXXXXXXX
 *  - call the dgxSet functions to set a value on a DGX (e.g., volume).
 * 
 * dgxEnableXXXXXXX
 *  - call the dgxEnable functions to enable a setting on the DGX which can be enabled or disabled.
 * 
 * dgxDisableXXXXXXX
 *  - call the dgxDisable functions to disable a setting on the DGX which can be enabled or disabled.
 * 
 * dgxCycleXXXXXX
 * - call the dgxCycle functions to toggle a setting on the DGX from enabled to disabled or vice versa.
 * --------------------
 */


/*
 * --------------------
 * Switch functions
 * --------------------
 */

/*
 * Function:	dgxEnableSwitch
 *
 * Arguments:	dev dgxSwitcher - DGX switcher
 * 				integer level - level
 * 				integer input - input
 * 				integer output - output
 *
 * Description:	Switch an input to an output on a DGX.
 */
define_function dgxEnableSwitch (dev dgxSwitcher, integer level, integer input, integer output)
{
	sendCommand (dgxSwitcher, "DGX_COMMAND_SWITCH,DGX_COMMAND_SUB_LEVEL,itoa(level),DGX_COMMAND_SUB_INPUT,itoa(input),DGX_COMMAND_SUB_OUTPUT,itoa(output),DGX_COMMAND_SUB_TAKE")
}

/*
 * Function:	dgxEnableSwitchMultipleOutputs
 *
 * Arguments:	dev dgxSwitcher - DGX switcher
 * 				integer level - level
 * 				integer input - input
 * 				integer outputs[] - output array
 *
 * Description:	Switch an input to multiple outputs on a DGX.
 */
define_function dgxEnableSwitchMultipleOutputs (dev dgxSwitcher, integer level, integer input, integer outputs[])
{
	char outputString[200]	// should be big enough to handle a DGX64
	integer i
	
	for (i = 1; i <= length_array(outputs); i++)
	{
		if(outputs[i] != 0)
		{
			if (length_string(outputString))
				outputString = "outputString,' ',itoa(outputs[i])"
			else
				outputString = "itoa(outputs[i])"
		}
	}
	
	sendCommand (dgxSwitcher, "DGX_COMMAND_SWITCH,DGX_COMMAND_SUB_LEVEL,itoa(level),DGX_COMMAND_SUB_INPUT,itoa(input),DGX_COMMAND_SUB_OUTPUT,outputString,DGX_COMMAND_SUB_TAKE")
}

/*
 * Function:	dgxDisableSwitchInput
 *
 * Arguments:	dev dgxSwitcher - DGX switcher
 * 				integer level - level
 * 				integer input - input
 *
 * Description:	Disconnect an input from all routed outputs on a DGX.
 */
define_function dgxDisableSwitchInput (dev dgxSwitcher, integer level, integer input)
{
	sendCommand (dgxSwitcher, "DGX_COMMAND_DISCONNECT,DGX_COMMAND_SUB_LEVEL,itoa(level),DGX_COMMAND_SUB_INPUT,itoa(input),DGX_COMMAND_SUB_TAKE")
}

/*
 * Function:	dgxDisableSwitchMultipleInputs
 *
 * Arguments:	dev dgxSwitcher - DGX switcher
 * 				integer level - level
 * 				integer inputs[] - input array
 *
 * Description:	Disconnect an input from all routed outputs on a DGX.
 */
define_function dgxDisableSwitchMultipleInputs (dev dgxSwitcher, integer level, integer inputs[])
{
	char inputString[200]	// should be big enough to handle a DGX64
	integer i
	
	for (i = 1; i <= length_array(inputs); i++)
	{
		if(inputs[i] != 0)
		{
			if (length_string(inputString))
				inputString = "inputString,' ',itoa(inputs[i])"
			else
				inputString = "itoa(inputs[i])"
		}
	}
	
	sendCommand (dgxSwitcher, "DGX_COMMAND_DISCONNECT,DGX_COMMAND_SUB_LEVEL,itoa(level),DGX_COMMAND_SUB_INPUT,inputString,DGX_COMMAND_SUB_TAKE")
}

/*
 * Function:	dgxDisableOutput
 *
 * Arguments:	dev dgxSwitcher - DGX switcher
 * 				integer level - level
 * 				integer output - output
 *
 * Description:	Disconnect an output from any routed input on a DGX.
 */
define_function dgxDisableSwitchOutput (dev dgxSwitcher, integer level, integer output)
{
	sendCommand (dgxSwitcher, "DGX_COMMAND_DISCONNECT,DGX_COMMAND_SUB_LEVEL,itoa(level),DGX_COMMAND_SUB_OUTPUT,itoa(output),DGX_COMMAND_SUB_TAKE")
}

/*
 * Function:	dgxDisableOutputMulti
 *
 * Arguments:	dev dgxSwitcher - DGX switcher
 * 				integer level - level
 * 				integer outputs[] - output array
 *
 * Description:	Disconnect an output from any routed input on a DGX.
 */
define_function dgxDisableSwitchOutputMulti (dev dgxSwitcher, integer level, integer outputs[])
{
	char outputString[200]	// should be big enough to handle a DGX64
	integer i
	
	for (i = 1; i <= length_array(outputs); i++)
	{
		if(outputs[i] != 0)
		{
			if (length_string(outputString))
				outputString = "outputString,' ',itoa(outputs[i])"
			else
				outputString = "itoa(outputs[i])"
		}
	}
	
	sendCommand (dgxSwitcher, "DGX_COMMAND_DISCONNECT,DGX_COMMAND_SUB_LEVEL,itoa(level),DGX_COMMAND_SUB_OUTPUT,outputString,DGX_COMMAND_SUB_TAKE")
}


/*
 * --------------------
 * Status functions
 * --------------------
 */

/*
 * Function:	dgxRequestInputStatus
 *
 * Arguments:	dev dgxSwitcher - DGX switcher
 * 				integer level - level
 * 				integer input - input
 *
 * Description:	Request the status (routes) for an input on a DGX.
 */
define_function dgxRequestSwitchInputStatus (dev dgxSwitcher, integer level, integer input)
{
	sendCommand (dgxSwitcher, "DGX_COMMAND_STATUS_REQUEST,DGX_COMMAND_SUB_LEVEL,itoa(level),DGX_COMMAND_SUB_INPUT,itoa(input),DGX_COMMAND_SUB_TAKE")
}

/*
 * Function:	dgxRequestOutputStatus
 *
 * Arguments:	dev dgxSwitcher - DGX switcher
 * 				integer level - level
 * 				integer output - output
 *
 * Description:	Request the status (route) for an output on a DGX.
 */
define_function dgxRequestSwitchOutputStatus (dev dgxSwitcher, integer level, integer output)
{
	sendCommand (dgxSwitcher, "DGX_COMMAND_STATUS_REQUEST,DGX_COMMAND_SUB_LEVEL,itoa(level),DGX_COMMAND_SUB_OUTPUT,itoa(output),DGX_COMMAND_SUB_TAKE")
}

#end_if