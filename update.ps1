#Requires -RunAsAdministrator

Set-StrictMode -version Latest

$DotFilesPath = Split-Path $MyInvocation.MyCommand.Path
pushd $DotFilesPath
try {
	./cup all -y
	./gvim -c "PlugUpdate" -c "qa!"
} finally {
	popd
}
