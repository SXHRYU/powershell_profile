	# List of custom functions with their respective descriptions.
	# In order to look for them to be ordered and be readable the formatting should be preserved.
$list_of_custom_functions = @(
	'run_docker', 
		"`t 'run_docker' для запуска Docker. `n",
	'django_server',
		"`t 'django_server' для запуска Django локал-сервера. Нужно находиться в папке с manage.py. `n",
	'django_python_shell',
		"`t 'django_python_shell' для запуска Python Shell проекта Django. Нужно находиться в папке с manage.py. `n",
	'fastapi_server',
		"`t 'fastapi_server' для запуска FastAPI локал сервера. Нужно находиться в папке с main.py. `n"
	'cd_ssh',
		"`t 'cd_ssh' для перехода к папке .ssh (где файлы known_hosts и id_ECDSA и т. д.). `n",
	'cd_program',
		"`t 'cd_program' для перехода к папке 'program_fun', где содержатся проекты. `n",
	'venv_create',
		"`t 'venv' для создания виртуальной среды Python (папка venv создаётся в текущей директории). `n",
	'venv_activate',
		"`t 'venv' для активации виртуальной среды Python (нужно находиться в папке с путём к среде). `n",
	'run_virtual("%имя/UUID виртуальной машины%")',
		"`t 'run_virtual(vmname|UUID)' для запуска виртуальной машины. Принимает название или UUID машины.",
		"`t 'vm_list', чтобы получить список всех виртуальных машин. `n"
)

	# function to have text (STDIN/STDOUT) be colored green.
function Green
{
	process { Write-Host $_ -ForegroundColor Green }
}

	# print out a list of my functions as listed above.
function MyFunctions 
{
	foreach($item in $list_of_custom_functions)
	{
		Write-Output $item
	}
}

Write-Output "`n________________________________________________________________"
Write-Output "`nВведите 'MyFunctions', чтобы показать все кастомные функции. `n" | Green
Write-Output "Все импортированные модули (например, posh-git) находятся в C:\Program Files\WindowsPowerShell\Modules `n" | Green
Write-Output "________________________________________________________________ `n"
Write-Output ($($PSversionTable.Keys)[0] + " " + $($PSversionTable.Values)[0].ToString() + "`n")



##############################################################################
##############################################################################

function run_docker { Invoke-Item "C:\Program Files\Docker\Docker\Docker Desktop.exe" }
function django_server { python manage.py runserver }
function django_python_shell { python manage.py shell }
function fastapi_server { uvicorn main:app --reload }
function cd_ssh { cd "C:\%USER_PATH%\.ssh\" }
function cd_program { cd "C:\%PATH_TO_DIRECTORY%\program_fun\" }
function venv_create { python -m venv venv }
function venv_activate { ./venv/Scripts/Activate.ps1 }
function run_virtual( [string]$arg1 )
	{
		# launching VirtualBox and passing in the name of the machine.
		cd "C:\Program Files\Oracle\VirtualBox"; 
		.\VirtualBoxVM --startvm $arg1;	
	}
function vm_list 
	{ 
		cd "C:\Program Files\Oracle\VirtualBox"; 
		.\VBoxManage.exe list vms
	}

Import-Module posh-git
$GitPromptSettings.EnablePromptStatus = $false


# Custom aliases
function LessPipeline
	{
		[CmdletBinding()]
		param
		(
			[Parameter(ValueFromPipeline)]
			[string[]]$PipedInput
		)
		process
		{
		& "C:\Program Files (x86)\Git\%USER%\bin\less.exe" "$PipedInput"
		}
	}

function sudoFunction( [string]$command )
	{
		Start-Process -Verb runas $command
	}

function Get-PublicIP { $(curl https://ipinfo.io/ip).Parsedhtml.body.innertext }

# DOESN'T ACTUALLY WORK IN PIPELINE!
Set-Alias -Name "less" -Value LessPipeline
Set-Alias -Name "sudo" -Value SudoFunction
Set-Alias -Name "MyPublicIP" -Value Get-PublicIP
Set-Alias -Name "ifconfig" -Value ipconfig
