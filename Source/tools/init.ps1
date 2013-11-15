Param(
	[Parameter(Position=0,Mandatory=1)] [hashtable]$parameters,
	[Parameter(Position=1,Mandatory=1)] [hashtable]$config
)

# -----------------------------------------------------
# Put your initialization code here
# -----------------------------------------------------

$module = (join-path (resolve-path $parameters.packageDir) 'source\tools\Koshu-IISExpress.psm1')
import-module $module -disablenamechecking -global -args $config