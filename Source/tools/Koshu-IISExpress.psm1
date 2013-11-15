Param(
	[Parameter(Position=0,Mandatory=1)] [hashtable]$config
)

#------------------------------------------------------------
# Variables
#------------------------------------------------------------

$iisExpressDefaultPath = "C:\Program Files (x86)\IIS Express"
$webservers = [ordered]@{}

#------------------------------------------------------------
# Commands
#------------------------------------------------------------

function Start-IISExpress {
	[CmdletBinding()]
	param(
		[Parameter(Position=0,Mandatory=1,ValueFromPipeline=$True)][string]$path,
		[Parameter(Position=1,Mandatory=1,ValueFromPipeline=$True)][int]$port=8080,
		[Parameter(Position=2,Mandatory=0,ValueFromPipeline=$True)][string]$name=$null
	)

	if (-not (test-path $path)) {
		throw "The given application path does not exist ($path)"
	}

	if ($name -eq $null -or $name -eq '') {
		$name = ($path | split-path -leaf)
	}

	$iisExpressPath = $config.iisExpressPath
	if ($iisExpressPath -eq $null) {
		$iisExpressPath = $iisExpressDefaultPath
	}

	$iisExpress = "$iisExpressPath\iisexpress.exe"

	if (-not (test-path $iisExpress)) {
		throw "Could not find IIS Express at the given path: $iisExpress"
	}

	$process = start-process $iisExpress "/path:$path /port:$port" -windowstyle hidden -passthru
	$processId = $process.Id
	if ($processId -eq $null) {
		write-host "Starting webserver for $name failed. Maybe the port $port is already in use?." -fore red
	} else {
		write-host "Starting webserver for $name at http://localhost:$port/. Process: $processId." -fore yellow
		$instance = [ordered]@{
			"name"=$name
			"port"=$port
			"path"=$path
			"processId"=$processId
			"processName"=$process.name
		}
		$webservers.add($name, $instance)
	}
}

function Stop-IISExpress {
	[CmdletBinding()]
	param(
		[Parameter(Position=0,Mandatory=1,ValueFromPipeline=$True)][string]$name
	)

	$instance = $webservers.get_item($name)
	if ($instance -eq $null) {
		write-host "Could not find an instance named $name." -fore red
	} else {
		$processId = $instance.processId
		write-host "Stopping webserver for $name. Process: $processId." -fore yellow
		stop-process -id $processId
		$webservers.remove($name)
	}
}

function Stop-AllIISExpress {
	[CmdletBinding()]
	param(
	)

	write-host "Stopping all running webservers" -fore yellow
	$webservers.getenumerator() | % {
		$instance = $_.value

		$name = $instance.name
		$processId = $instance.processId

		write-host "Stopping webserver for $name. Process: $processId." -fore yellow
		stop-process -id $processId
	}
	$webservers = [ordered]@{}
}

function Get-IISExpress {
	[CmdletBinding()]
	param(
	)

	write-host "Currently running webservers" -fore yellow
	$webservers.getenumerator() | % {
		$_.value | out-string
	}
}


#------------------------------------------------------------
# Export
#------------------------------------------------------------

export-modulemember -function Start-IISExpress, Stop-IISExpress, Stop-AllIISExpress, Get-IISExpress