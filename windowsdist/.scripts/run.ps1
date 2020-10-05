# ~~~~~~~~~~~~~~~~~~ Paths ~~~~~~~~~~~~~~~~~~ #
$username = $env:USERNAME
$pythonVersion = "3.8.5"
$pythonUrl = "https://www.python.org/ftp/python/$pythonVersion/python-$pythonVersion.exe"
$pythonDownloadPath = "C:\Users\$username\python-$pythonVersion.exe"
$pythonInstallDir = "C:\Users\$username\Python$pythonVersion"
$pythonScriptDir = "$pythonInstallDir\Scripts"
$application = "crplog"
$venvDir = "$pythonInstallDir\venv\$application"
$cwd = Get-Location
# ~~~~~~~~~~~~~~~~~~ Python ~~~~~~~~~~~~~~~~~~ #
if (-Not (Test-Path $pythonInstallDir)) {
    (New-Object Net.WebClient).DownloadFile($pythonUrl, $pythonDownloadPath)
    & $pythonDownloadPath InstallAllUsers=0 Include_launcher=0 Include_test=0 TargetDir=$pythonInstallDir
        if ($LASTEXITCODE -ne 0) {
        throw "Re-Run after installing python"
    }
    }
$env:path = "$pythonInstallDir;${pythonScriptDir}"
pip install virtualenv -q
if (-Not (Test-Path $venvDir)){
virtualenv $venvDir
}
Set-Location $venvDir/Scripts
./activate
python -m pip install --upgrade --quiet pip
Set-Location $cwd
# ~~~~~~~~~~~~~~~~~~ Package ~~~~~~~~~~~~~~~~~~ #
pip install $application -q
pip install $application -Uq
python -m $application'.main'