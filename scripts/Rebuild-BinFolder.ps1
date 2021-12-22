$root = "D:\Files\System\Programs\"
$programs = @("scrcpy"
              "adb"
              "Pixivutil"
              "Git\bin"
              "Advanced Renamer"
              "aircrack-ng\bin\64-bit"
              "bfg"
              "binvox"
              "Bulk Rename Utility\All"
              "CMake\bin"
              "composer"
              "cygwin64"
              "D"
              "D1"
              "DMC"
              "elm-format"
              "emacs\bin"
              "fciv"
              "ffmpeg\bin"
              "gifski\win"
              "msys64"
              "Pear"
              "php"
              "Go\bin"
              "nodejs"
              "php"
              "phpcbf"
              "phpcs"
              "php-cs-fixer"
              "Python26"
              "Python27"
              "Python37"
              "r\R-3.5.1patched\bin"
              "ruby25\Ruby25-x64\bin"
              "shellcheck"
              "tidy\bin"
              "uncrustify",
              "ipref",
              "xmllint\bin",
              "gsfw"
            )

$tempPath = $env:Path;

ForEach ($program in $programs) {
  $programPath = "$root$program" ;
  $tempPath = [regex]::Replace($tempPath, ";"+[regex]::Escape($programPath)+";", ";");
  if ($program -match $programs[$programs.Length - 1])
  {
    $tempPath = [regex]::Replace($tempPath, ";"+[regex]::Escape($programPath), "");
  }
  "Adding Path: [$programPath]";
  $tempPath += ";$programPath";
}

[System.Environment]::SetEnvironmentVariable('SystemFiles',$tempPath,[System.EnvironmentVariableTarget]::Machine)

"Path: [$env:Path]"
