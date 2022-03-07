	# List of custom functions with their respective descriptions.
	# In order to look for them to be ordered and be readable the formatting should be preserved.
$list_of_custom_functions = @(
	'run_docker', 
		"`t 'run_docker' для запуска Docker. `n",
	'django_server',
		"`t 'django_server' для запуска Django локал-сервера. `n",
	'django_python_shell',
		"`t 'django_python_shell' для запуска Python Shell проекта Django. `n",
	'cd_ssh',
		"`t 'cd_ssh' для перехода к папке .ssh (где файлы known_hosts и id_ECDSA и т. д. `n",
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
Write-Output "________________________________________________________________ `n"



##############################################################################
##############################################################################

function run_docker { Invoke-Item "%path_to_docker_executable%/Docker Desktop.exe" }
function django_server { python "%path_to_django_project%/manage.py" runserver }
function django_python_shell { python "%path_to_django_project%/manage.py" shell }
function cd_ssh { cd "C:\Users\user\.ssh\" }
function run_virtual( [string]$arg1 ) 
{
	#launching VirtualBox and passing in the name of the machine.
	cd "C:\Program Files\Oracle\VirtualBox"; 
	.\VirtualBoxVM --startvm $arg1;	
}
function vm_list 
{ 
	cd "C:\Program Files\Oracle\VirtualBox"; 
	.\VBoxManage.exe list vms
}
