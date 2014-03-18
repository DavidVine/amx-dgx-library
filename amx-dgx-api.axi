program_name='amx-dgx-api'

#if_not_defined __AMX_DGX_API__
#define __AMX_DGX_API__

/*
 * --------------------
 * amx-dgx-api
 *
 * For usage, check out the readme for the amx-dgx-library.
 * --------------------
 */

define_constant

char VERSION_AMX_DGX_API[] = 'v1.0.0'


define_constant

integer DGX_8_MAX_VIDEO_INPUTS   = 8
integer DGX_8_MAX_VIDEO_OUTPUTS  = 8

integer DGX_16_MAX_VIDEO_INPUTS  = 16
integer DGX_16_MAX_VIDEO_OUTPUTS = 16

integer DGX_32_MAX_VIDEO_INPUTS  = 32
integer DGX_32_MAX_VIDEO_OUTPUTS = 32

integer DGX_64_MAX_VIDEO_INPUTS  = 64
integer DGX_64_MAX_VIDEO_OUTPUTS = 64

/*
 * --------------------
 * DGX ports
 * --------------------
 */

// note: DGX port 1 reserved for future functionality
integer DGX_PORT_SWITCHER = 2
integer DGX_PORT_BASIC_BCS_COMMANDS = 2
integer DGX_PORT_DIAGNOSTICS = 3
integer DGX_PORT_AUXILIARY_BCS_COMMANDS = 3
integer DGX_PORT_DUET_MODULE = 4


/*
 * --------------------
 * DGX command headers
 * --------------------
 */

char DGX_COMMAND_SWITCH[]         = 'C'
char DGX_COMMAND_DISCONNECT[]     = 'D'
char DGX_COMMAND_STATUS_REQUEST[] = 'S'

/*
 * --------------------
 * DGX command subheaders
 * --------------------
 */

char DGX_COMMAND_SUB_LEVEL[]  = 'L'
char DGX_COMMAND_SUB_INPUT[]  = 'I'
char DGX_COMMAND_SUB_OUTPUT[] = 'O'
char DGX_COMMAND_SUB_TAKE[]   = 'T'
char DGX_COMMAND_SUB_CANCEL[] = 'X'

/*
 * --------------------
 * DGX command subheaders
 * --------------------
 */

integer DGX_SWITCH_LEVEL_ALL = 0
integer DGX_SWITCH_LEVEL_VIDEO = 1
integer DGX_SWITCH_LEVEL_AUDIO = 2

#end_if