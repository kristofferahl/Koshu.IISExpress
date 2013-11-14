# Koshu.IISExpress

IIS Express plugin for Koshu. Contains common koshu tasks for starting, stopping and listing instances of IIS Express.

## Usage

### Configuration

It is possible to override the default path for where IIS Express is located by adding a config section to your task file.

	config @{
		"Koshu.IISExpress"=@{
			"IISExpressPath"="C:\Path\To\Your\IISExpress"
		}
	}

### Starting IIS Express

	Start-IISExpress -path 'C:\Path\To\Application' -port 8080 -name "MyApplication"

### Stopping IIS Express

	Stop-IISExpress -name "MyApplication"
	
### Stopping all IIS Express instances

	Stop-AllIISExpress

### Listing IIS Express instances

	Get-IISExpress

## License
MIT (http://opensource.org/licenses/mit-license.php)

## Contact
Kristoffer Ahl (project founder)  
Email: koshu@77dynamite.net  
Twitter: http://twitter.com/kristofferahl  
Website: http://www.77dynamite.com/