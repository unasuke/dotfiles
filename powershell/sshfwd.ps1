<#
.SYNOPSIS
  Attach an SSH port forward to an existing ControlMaster session, or start a backgrounded tunnel.

.EXAMPLE
  sshfwd myhost 8080
  sshfwd myhost 8080 3000
  sshfwd -Cancel myhost 8080
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$TargetHost,

    [Parameter(Mandatory = $true, Position = 1)]
    [ValidateRange(1, 65535)]
    [int]$RemotePort,

    [Parameter(Position = 2)]
    [ValidateRange(0, 65535)]
    [int]$LocalPort = 0,

    [Alias('c')]
    [switch]$Cancel
)

if ($LocalPort -eq 0) { $LocalPort = $RemotePort }

$spec = "${LocalPort}:localhost:${RemotePort}"

if ($Cancel) {
    & ssh -O cancel -L $spec $TargetHost 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "cancelled forward ${TargetHost}:${RemotePort} -> localhost:${LocalPort}"
        return
    }

    # ControlMaster cancel failed; find the backgrounded ssh process instead.
    $procs = Get-Process ssh -ErrorAction SilentlyContinue |
        Where-Object { $_.CommandLine -match "ssh.*-N.*-L.*${spec}.*${TargetHost}" }
    if ($procs) {
        $procs | Stop-Process
        Write-Host "killed background ssh (PID $($procs.Id -join ', ')) for ${TargetHost}:${RemotePort} -> localhost:${LocalPort}"
        return
    }

    Write-Error "sshfwd: no active forward found for ${spec} on ${TargetHost}"
    exit 1
}

# Prefer attaching to an existing ControlMaster session (Windows OpenSSH 8.0+).
& ssh -O forward -L $spec $TargetHost 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "forwarded ${TargetHost}:${RemotePort} -> localhost:${LocalPort}"
    return
}

Write-Host "no active ControlMaster for ${TargetHost}; starting background tunnel..."
$proc = Start-Process -FilePath ssh `
    -ArgumentList @('-N', '-L', $spec, $TargetHost) `
    -WindowStyle Hidden `
    -PassThru
Write-Host "background ssh PID $($proc.Id); stop with: sshfwd -Cancel ${TargetHost} ${RemotePort}"
