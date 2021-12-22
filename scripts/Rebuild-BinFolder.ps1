param(
	[switch]$output
)

$root = "%APROG_DIR%\"
$programs = @("C:\Perl64\bin"
	            "adb"
							"bfg"
							"bin"
							"Caffeine"
							"CMake\bin"
							"colortool"
							"composer"
							"cygwin64"
							"D\dmd2\windows\bin"
							"D1\dmd\windows\bin"
							"depot_tools"
							"depotdownloader"
							"DMC\dm\bin"
							"dnSpy"
							"elm-format"
							"emacs\bin"
							"ExportTool"
							"fciv"
							"ffmpeg\bin"
							"FileZilla FTP Client"
							"gifski\win"
							"Git\bin"
							"Git\cmd"
							"gnuwin32\bin"
							"Go\bin"
							"gsfw"
							"haste"
							"iperf"
							"JProfiler\bin"
							"KiTTY"
							"nmap"
							"Pear"
							"Phing"
							"php-cs-fixer"
							"php"
							"phpcbf"
							"phpcs"
							"pngcrush"
							"PuTTY"
							"r\R-3.5.1patched\bin"
							"resize"
							"ruby25\Ruby25-x64\bin"
							"shellcheck"
							"terraform"
							"tidy\bin"
							"TortoiseSVN\bin"
							"uncrusify"
							"ungit"
							"VisualD"
							"whois"
							"xmllint\bin"
							"C:\Qt\5.15.2\msvc2019_64\bin"
							"D:\Progra~2\Gpg4win\bin"
							"C:\Progra~1\NVIDIA GPU Computing Toolkit\CUDA\v11.5\libnvvp"
							"C:\Progra~1\NVIDIA GPU Computing Toolkit\CUDA\v11.5\bin"
							"D:\Progra~1\Guiffy"
							"C:\Windows\system32\config\systemprofile\AppData\Local\Microsoft\WindowsApps"
							"C:\Progra~1\NVIDIA Corporation\NVIDIA NvDLISR"
							"C:\Progra~1\NVIDIA Corporation\Nsight Compute 2021.3.0\"
							"C:\Progra~1\MariaDB\MariaDB Connector C 64-bit\lib\"
							"C:\Progra~1\MariaDB\MariaDB Connector C 64-bit\lib\plugin\"
							"C:\ProgramData\ComposerSetup\bin"
							"D:\Progra~1\Gpg4win\..\GnuPG\bin"
							"D:\Progra~2\Gpg4win\bin_64"
							"D:\Progra~2\Gpg4win\bin"
							"D:\Progra~2\GnuPG\bin"
							"D:\ProgramData\Anaconda3"
							"D:\ProgramData\Anaconda3\Library\mingw-w64\bin"
							"D:\ProgramData\Anaconda3\Library\usr\bin"
							"D:\ProgramData\Anaconda3\Library\bin"
							"D:\ProgramData\Anaconda3\Scripts"
            )

$tempPath = "";

$machinePath = ([System.Environment]::GetEnvironmentVariable('path',[System.EnvironmentVariableTarget]::Machine));

$localPath = ([System.Environment]::GetEnvironmentVariable('path',[System.EnvironmentVariableTarget]::User));

ForEach ($program in $programs) {
	$programPath = "";
	if ("$($program)".Contains("C:\") -or "$($program)".Contains("D:\") -or "$($program)".Contains("E:\")) {
		$programPath = "$($program)";
	} else {
		$programPath = "$($root)$($program)";
	}
	if ($tempPath -eq "") {
		$tempPath = "$($programPath)";
	} else {
		$tempPath = "$($tempPath);$($programPath)";
	}
	if ($output) {
    "Adding Path: [$programPath]";
	}
}

$newMachinePath = "$machinePath%APROG_FOLD%;"

[System.Environment]::SetEnvironmentVariable('APROG_FOLD',$tempPath,[System.EnvironmentVariableTarget]::Machine)

[System.Environment]::SetEnvironmentVariable('path',$newMachinePath,[System.EnvironmentVariableTarget]::Machine)

[System.Environment]::SetEnvironmentVariable('path',$localPath,[System.EnvironmentVariableTarget]::User)

if ($output) {
	Write-Host "Path added: [$($tempPath)]"
}
