###############################
#Konica  #
################################
$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$drivername = "KONICA MINOLTA C368SeriesPCL"
$portName = "IP_172.16.17.250"
$PortAddress = "172.16.17.250"

###################
#Staging Drivers   #
###################
C:\Windows\System32\pnputil.exe /add-driver "$psscriptroot\Drivers\KOAXPJ__.INF" /install

#######################
#Installing Drivers   #
#######################

Add-PrinterDriver -Name $drivername

##########################################################
#Install Printerport | check if the port already exist   #
##########################################################
$checkPortExists = Get-Printerport -Name $portname -ErrorAction SilentlyContinue
if (-not $checkPortExists) 
{
Add-PrinterPort -name $portName -PrinterHostAddress $PortAddress
}

####################################
#Check if PrinterDriver Exists     #
####################################
$printDriverExists = Get-PrinterDriver -name $DriverName -ErrorAction SilentlyContinue


##################
#Install Printer #
##################
if ($printDriverExists)
{
Add-Printer -Name "UK-LDN-KONICA" -PortName $portName -DriverName $DriverName
}
else
{
Write-Warning "Printer Driver not installed"
}

Printui.exe / Sr /n “UK-LDN-KONICA” /a “.\config.dat”

SLEEP 360