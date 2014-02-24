amx-dgx-library
===============


Files
-----
+ amx-dgx-api.axi
+ amx-dgx-control.axi
+ amx-dgx-listener.axi


Overview
--------
The **amx-dgx-library** NetLinx library is intended as a tool to make things easier for anyone tasked with programming an AMX system containing an AMX Enova DGX Switcher:

+ ENOVADGX8
+ ENOVADGX16
+ ENOVADGX32
+ ENOVADGX64

The built-in structures, constants, control functions, callback functions, and events assist you by simplifying control and feedback.

Everything is a function!

Consistent, descriptive control function names within **amx-dgx-control** make it easy for you to control the different aspects of the DGX (switching) and request information. E.g:

	/*
	 * Function:	dgxSwitch
	 *
	 * Arguments:	dev dgxSwitcher - DGX switcher
	 * 				integer level - level
	 * 				integer input - input
	 * 				integer output - output
	 *
	 * Description:	Switch an input to an output on the DGX.
	 */
	define_function dgxSwitch (dev dgxSwitcher, integer level, integer input, integer output)
	{
		amxSendCommand (dgxSwitcher, "DGX_COMMAND_SWITCH,DGX_LEVEL,itoa(level),DGX_INPUT,itoa(input),DGX_OUTPUT,itoa(output)")
	}

No longer are you required to refer to the DGX manual to work out what command headers are required or how to build a control string containing all the required values. This process was time consuming and often involved converting numeric data to string form and building string expressions which were long and complex.

With the control functions defined within **amx-dgx-control** values for DGX commands are simply passed through as arguments in the appropriate data types (constants defined within **amx-dgx-api** can be used where required) and the control functions do the hard work.

Similarly, you no longer have to build events (data/channel/level, etc...) to capture returning information from the DGX and parse the incoming string/command (coverting data types where required) to obtain the required information in the correct format. **amx-dgx-listener**, listens for all types of responses from the DGX and triggers pre-written callback functions which you can copy to the main program, uncomment and fill in. E.g:

	#define INCLUDE_DGX_NOTIFY_SWITCH
	define_function dgxNotifySwitch (dev dgxSwitcher, integer input, integer outputs[])
	{
		// dgxSwitcher is the D:P:S of the DGX switcher
		// input is the input on the switcher that was just switched to one or more outputs
		// outputs is an array containing the outputs on the switcher that the input was switched to
	}

Functions also assist to neaten up the programming and provide added readability to the code and the auto-prompter within the NetLinx Studio editor makes it easy to find the function you're looking for.

Extremely flexible!

All control and callback functions have a DEV parameter. This makes **amx-dgx-library** extremely flexible as you can use the same control/callback functions for different AV ports on a DGX or even multiple DGX's. For the control functions you simply pass through the dev for the DGX component you want to control and the dev parameter of the callback functions allows you to check to see which device triggered the notification.


amx-dgx-api
-----------
#####Dependencies:
+ none

#####Description:
Contains structure definitions which you can use to store information about an AMX Enova DGX switcher.

Contains constants for DGX NetLinx command headers and parameter values. These are used extensively by the accompanying library files **amx-dgx-control** and **amx-dgx-listener**. The constants defined within **amx-dgx-api** can also be referenced when passing values to control functions (where function parameters have a limited allowable set of values for one or more parameters) or checking to see the values of the callback function parameters.

#####Usage:
Include **amx-dgx-api** into the main program using the `#include` compiler directive. E.g:

	#include 'amx-dgx-api'

NOTE: If the main program file includes **amx-dgx-control** and/or **amx-dgx-listener** it is not neccessary to include **amx-dgx-api** in the main program file as well as each of them already includes **amx-dgx-api** but doing so will not cause any issues.


amx-dgx-control
---------------
#####Dependencies:
+ amx-dgx-api
+ amx-device-control (*see readme for amx-device-library for info*)
+ common (*see readme for amx-common-library for info*)

#####Description: 
Contains functions for controlling the various components of an AMX Enova DGX switcher and requesting information from the DGX.

Some functions defined within **amx-dgx-control** have an limited allowable set of values for one or more parameters. In these instances the allowable values will be printed within the accompanying commenting as constants defined within **amx-dgx-api**.

#####Usage:
Include **amx-dgx-control** into the main program using the `#include` compiler directive. E.g:

	#include 'amx-dgx-control'

and call the function(s) defined within **amx-dgx-control** from the main program file,. E.g:

	button_event [dvTp,btnShowLaptopOnProjector]
	{
		push:
		{
			dgxSwitch (dvDgxSwitcher, INPUT_LAPTOP, OUTPUT_PROJECTOR)
		}
	}

	button_event [dvTp,btnShowLaptopOnAll]
	{
		push:
		{
			stack_var integer outputs[10]

			outputs[1] = OUTPUT_PROJECTOR
			outputs[2] = OUTPUT_MONITOR_LEFT
			outputs[3] = OUTPUT_MONITOR_RIGHT
			set_length_array(outputs,3)

			dgxSwitchMulti (dvDgxSwitcher, INPUT_LAPTOP, outputs)
		}
	}


amx-dgx-listener
----------------
#####Dependencies:
+ amx-dgx-api
+ common (*see readme for amx-common-library for info*)

#####Description:
Contains dev arrays for listening to traffic returned from the AMX DGX switcher.

You should copy the required dev arrays to their main program and instantiate them with dev values corresponding to the DGX switcher components you wish to listen to.

Contains commented out callback functions and events required to capture information from the AMX Enova DGX switcher. The events (data_events, channel_events, & level_events) will parse the information returned from the DGX and call the associated callback functions passing the information through as arguments to the call back functions' parameter list.

Callback functions may be triggered from both unprompted data and responses to requests for information.

#####Usage:
Include **amx-dgx-listener** into the main program using the `#include` compiler directive. E.g:

	#include 'amx-dgx-listener'

Copy the required DEV arrays from **amx-dgx-listener**:

	define_variable

	#if_not_defined dvDgxSwitchers
	dev dvDgxSwitchers[] = { 5002:2:1, 5002:2:2 }
	#end_if

to the main program file and populate the contents of the DEV arrays with only the ports of the DGX that you want to listen to. E.g:

	define_device

	dvDgx1stFloor = 5002:2:1
	dvDgx2ndFloor = 5002:2:2
	dvDgx3rdFloor = 5002:2:3

	define_variable

	// DEV array for DGX video output ports copied from amx-dgx-listener
	dev dvDgxSwitchers[] = { dvDgx1stFloor, dvDgx2ndFloor, dvDgx3rdFloor }

NOTE: The order of the devices within the DEV arrays does not matter. You can have as few (1) or as many devices defined within the DEV array as you want to listen to.

Copy whichever callback functions you would like to use to monitor changes on the DGX or capture responses to requests for information in your main program file. The callback function should then be uncommented and the contents of the statement block filled in appropriately. The callback functions should not be uncommented within **amx-dgx-listener**. E.g:

Copy an empty, commented out callback function from **amx-dgx-listener** and the associated `#define` statement:

	/*
	#define INCLUDE_DGX_NOTIFY_OUTPUT_STATUS_CALLBACK
	define_function dgxNotifyOutputStatus (dev dgxSwitcher, integer output, integer input)
	{
		// dgxSwitcher is the D:P:S of the DGX switcher
		// output is the output on the switcher
		// input is the input on the switcher that is routed to the output or DGX_INPUT_NONE
	}
	*/

paste the callback function and `#define` statement into the main program file, uncomment, and add any code statements you want:

	#define INCLUDE_DGX_NOTIFY_OUTPUT_STATUS_CALLBACK
	define_function dgxNotifyOutputStatus (dev dgxSwitcher, integer output, integer input)
	{
		// dgxSwitcher is the D:P:S of the DGX switcher
		// output is the output on the switcher
		// input is the input on the switcher that is routed to the output or DGX_INPUT_NONE

		if (dgxSwitcher == dvDgx1stFloor)
		{
			switchStatus1stFloor[output] = input
		}
	}

The callback function will be automatically triggered whenever a change occurs on the DGX (that initiates an unsolicted feedback response) or a response to a request for information is received.

###IMPORTANT!
1. The `#define` compiler directive found directly above the callback function within **amx-dgx-listener** must also be copied to the main program and uncommented along with the callback function itself.

2. Due to the way the NetLinx compiler scans the program for `#define` staments **amx-dgx-listener** must be included in the main program file underneath any callback functions and associated `#define` statements or the callback functions will not trigger.

E.g:

		#program_name='main program'
		
		define_device
		
		dvDgx1stFloor = 5002:2:1
		dvDgx2ndFloor = 5002:2:2
		dvDgx3rdFloor = 5002:2:3
		
		define_variable
		
		// DEV arrays for amx-dgx-listener to use
		dev dvDgxSwitchers[] = { dvDgx1stFloor, dvDgx2ndFloor, dvDgx3rdFloor }

		#define INCLUDE_DGX_NOTIFY_SWITCH
		define_function dgxNotifySwitch (dev dgxSwitcher, integer input, integer outputs[])
		{
		}
		
		#define INCLUDE_DGX_NOTIFY_OUTPUT_STATUS_CALLBACK
		define_function dgxNotifyOutputStatus (dev dgxSwitcher, integer output, integer input)
		{
		}

		#define INCLUDE_DGX_NOTIFY_INPUT_STATUS_CALLBACK
		define_function dgxNotifyInputStatus (dev dgxSwitcher, integer input, integer outputs[])
		{
		}
		
		#include 'amx-dgx-listener'

---------------------------------------------------------------

Author: David Vine - AMX Australia  
Readme formatted with markdown  
Any questions, email <support@amxaustralia.com.au> or phone +61 (7) 5531 3103.
