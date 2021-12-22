param (
  [parameter(Mandatory=$true, Position=0)]
  [Alias("Hidden")]
  [string]
  $img1,
  [parameter(Mandatory=$true, Position=1)]
  [Alias("Visible")]
  [string]
  $img2,
  [parameter(Mandatory=$false, Position=2)]
  [string]
  $out
)

$doubleVision = $null
$pngCrush = $null
$ruby = $null

function checkPath($ProgramEnum)
{
  $testConfig = $false;
  $config = $null;

  if (Test-Path -Path $PSScriptRoot\Settings.json -PathType Leaf)
  {
    $testConfig = $true;
    $config = (Get-Content $PSScriptRoot\Settings.json | ConvertFrom-Json);
  }

  if ($ProgramEnum -eq 0)
  {
    if ($env:PATH.Contains("doubleVision.bat"))
    {
      return 1;
    }
    else
    {
      if ($testConfig && Test-Path -Path $config.DoubleVisionInstall -PathType Leaf)
      {
        return $config.DoubleVisionInstall;
      }
      else
      {
        return 2;
      }
    }
  }
  elseif ($ProgramEnum -eq 1)
  {
    if ($env:PATH.Contains("pngCrush.exe"))
    {
      return 1;
    }
    else
    {
      if ($testConfig && Test-Path -Path $config.pngCrushInstall -PathType Leaf)
      {
        return $config.pngCrushInstall;
      }
      else
      {
        return 2;
      }
    }
  }
  elseif ($ProgramEnum -eq 2)
  {
    if ($env:PATH.Contains("ruby.exe"))
    {
      return 1;
    }
    else
    {
      if ($testConfig && Test-Path -Path $config.RubyInstall -PathType Leaf)
      {
        return $config.RubyInstall;
      }
      else
      {
        return 2;
      }
    }
  }
}

function checkImages()
{
  if (Test-Path -Path $img1 -PathType Leaf && Test-Path -Path $img2 -PathType Leaf)
  {
    return $true
  }
  else
  {
    return $false
  }
}

function runpngCrush($file, $outfile, $remove)
{
  if (Test-Path -Path "$($file)" -PathType Leaf)
  {
    Start-Process -FilePath "$($pngCrush)" "-g 0.002 $($file) $($outfile)" -NoNewWindow -Wait

    if ($remove -eq $true)
    {
      if (Test-Path -Path $file -PathType Leaf)
      {
        Remove-Item -Path "$($file)"
      }
    }
  }
}

if (checkImages)
{
  $check0 = checkPath 0
  $check1 = checkPath 1
  $check2 = checkPath 2

  if ($check0 -eq 1)
  {
    $doubleVision = "doubleVision.exe"
  }
  elseif ($check0 -eq 2)
  {
    Write-Error -Message "DoubleVision is not installed or could not be found from path or config."
  }
  else
  {
    $doubleVision = $check0
  }

  if ($check1 -eq 1)
  {
    $pngCrush = "pngcrush.exe"
  }
  elseif ($check1 -eq 2)
  {
    Write-Error -Message "PNG Crush is not installed or could not be found from path or config."
  }
  else
  {
    $pngCrush = $check1
  }

  if ($check2 -eq 1)
  {
    $ruby = "Gem"
  }
  elseif ($check2 -eq 2)
  {
    Write-Error -Message "Ruby Gem is not installed or could not be found from path or config."
  }
  else
  {
    $ruby = $check2
  }
}

if ($null -ne $doubleVision)
{
  #runpngCrush $img1 "$($img1)-temp" $false

  #Start-Process -FilePath "$($doubleVision)" "$($img1)-temp $($img2) $($out)-temp" -NoNewWindow -Wait
  Start-Process -FilePath "$($doubleVision)" "$($img1) $($img2) $($out)-temp" -NoNewWindow -Wait

  if (Test-Path -Path "$($img1)-temp" -PathType Leaf)
  {
    Remove-Item -Path "$($img1)-temp"
  }

  #runpngCrush "$($out)-temp" "$($out)" $true
}
