Param(
	[Parameter(Position=0,Mandatory=1)] [hashtable]$parameters,
	[Parameter(Position=1,Mandatory=1)] [hashtable]$config
)

# -----------------------------------------------------
# Put your initialization code here
# -----------------------------------------------------

$parameters		| out-string		# Outputs the parameters available to you
$config			| out-string		# Outputs the config properties available to you