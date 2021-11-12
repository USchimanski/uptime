<#
================================================================================

         FILE:  Uptime.ps1

        USAGE:  Uptime.ps1 [-p] [-s] [-h] [-v]

  DESCRIPTION:  Show uptime from the computer

      OPTIONS:  ---
 REQUIREMENTS:  ---
         BUGS:  ---
        NOTES:  ---
       AUTHOR:  Uwe Schimanski, uws@seabaer-ag.de
      COMPANY:  Seab@er Software
      Version:  20.03.02
      CREATED:  17.02.2020
     REVISION:  
================================================================================
      Version:  20.03.02
  DESCRIPTION:  Revised BootTime with if
================================================================================
#>

Param
(
	[Switch]$Pretty,	# Parameter without value
	[Switch]$Since,
	[Switch]$Version,
	[Switch]$Help
)

try
{
	# output uptime
	# <time> up <daysup> days, <Zeitup>
	# output -p
	# up <week> weeks, <daysup> days, <hoursup> hours, <minutesup> minutes
	
	$my_debug = "false" # true or false
	$ProgVersion = "21.03.30"
	$Company = "Seab@er Software"
	$ProgName = $MyInvocation.MyCommand.Name

    # Uptime start
	if ($PSVersionTable.PSVersion.Major -lt 6 )
	{
		$cimString = (Get-WmiObject Win32_OperatingSystem).LastBootUpTime
		$BootTime = [Management.ManagementDateTimeConverter]::ToDateTime($cimString)
	}
	else
	{
		$cimString = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
		$BootTime = $cimString
	}

	$BootDate = "{0:dd.MM.yyyy HH:mm:ss}" -f ($BootTime)
	$Now = "{0:dd.MM.yyyy HH:mm:ss}" -f (Get-Date)
	$NowTime = "{0:HH:mm:ss}" -f (Get-Date)
	$Up = New-TimeSpan -Start $BootTime -End (Get-Date)
	$UpDays = $Up.Days
	$UpHours = $Up.Hours
	$UpMinutes = $Up.Minutes
	$UpTime = $Up.Hours.ToString() + ":" + $Up.Minutes.ToString()
	$BackColor = (get-host).ui.rawui.BackgroundColor
	$FrontColor = (Get-Host).ui.rawui.ForegroundColor
	[console]::ForegroundColor = "$FrontColor"
	[console]::BackgroundColor = "$BackColor"

	if ($UpDays -le 6)
	{
		$UpWeek = 0
		$UpDaysAll = $UpDays
	}
	else
	{
		$A = $UpDays / 7
		$UpWeek = [math]::Truncate($A)
		$B = $UpWeek -as [int] # convert to integer
		$C = $B * 7
		$D = $UpDays - $C
		$UpDaysAll = $UpDays
		$UpDays = $D
	}
	# -- For debugging
	if ( "$my_debug" -eq "true")
	{
		$TypeA = $A.GetType().Name
		$TypeB = $B.GetType().Name
		$TypeC = $C.GetType().Name
		$TypeD = $D.GetType().Name
		$TypeUpWeek = $UpWeek.GetType().Name
		$TypeUpDaysAll = $UpDaysAll.GetType().Name
		$TypeUpDays = $UpDays.GetType().Name
		Write-Host -ForegroundColor Yellow "     Parameter: $Pretty"
		Write-Host -ForegroundColor Yellow "     Up Days A: $A"
		Write-Host -ForegroundColor Yellow "     Up Days B: $B"
		Write-Host -ForegroundColor Yellow "     Up Days C: $C"
		Write-Host -ForegroundColor Yellow "     Up Days D: $D"
		Write-Host -ForegroundColor Yellow "       Up Days: $UpDays"
		Write-Host -ForegroundColor Yellow "      Up Weeks: $UpWeek"
		
		Write-Host -ForegroundColor Yellow "        Type A: $TypeA"
		Write-Host -ForegroundColor Yellow "        Type B: $TypeB"
		Write-Host -ForegroundColor Yellow "        Type C: $TypeC"
		Write-Host -ForegroundColor Yellow "        Type D: $TypeD"
		Write-Host -ForegroundColor Yellow "   Type UpWeek: $TypeUpWeek"
		Write-Host -ForegroundColor Yellow "Type UpDaysAll: $TypeUpDaysAll"
		Write-Host -ForegroundColor Yellow "   Type UpDays: $TypeUpDays"
		Write-Host -ForegroundColor Yellow "------------------------------"
		#$Up
	}
	
	if ($Pretty)
	{
		Write-Host -ForegroundColor Gray "up $UpWeek weeks, $UpDays days, $UpHours hours, $UpMinutes minutes"
	}
	elseif ($Since)
	{
		Write-Host -ForegroundColor Gray "$BootDate"
	}
	elseif ($Version)
	{
		Write-Host -ForegroundColor Yellow "$ProgName - $ProgVersion"
		Write-Host -ForegroundColor Yellow "Copyright © 2020 $Company."
		Write-Host -ForegroundColor Yellow "Lizenz GPLv3+: GNU GPL Version 3 oder höher <https://gnu.org/licenses/gpl.html>."
		Write-Host -ForegroundColor Yellow "Dies ist freie Software: Sie können sie ändern und weitergeben."
		Write-Host -ForegroundColor Yellow "Es gibt keinerlei Garantien, soweit wie es das Gesetz erlaubt.`n"
		Write-Host -ForegroundColor Yellow "Geschrieben von Uwe Schimanski"
	}
	elseif ($Help)
	{
		Write-Host -ForegroundColor Yellow "Usage:"
		Write-Host -ForegroundColor Yellow " $ProgName [options]`n"
		Write-Host -ForegroundColor Yellow "Options:"
		Write-Host -ForegroundColor Yellow " -p, -pretty  Show uptime in pretty format"
		Write-Host -ForegroundColor Yellow " -h, -help    Display this help and exit"
		Write-Host -ForegroundColor Yellow " -s, -since   System up time"
		Write-Host -ForegroundColor Yellow " -v, -version Output version information and exit"
	}
	else
	{
		Write-Host -ForegroundColor Gray "$NowTime up $UpDaysAll days, $UpTime"
	}
}
catch
{
	Write-Host -ForegroundColor Red "Exception found. `n$_"
}