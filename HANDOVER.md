# Biobot Uro Software Uninstall Scripts Handover

## Executive Summary

This repository contains a small Windows-only uninstall utility for Biobot Uro software. It is designed to remove installed Uro products silently, without requiring Python or any third-party runtime.

The main script is:

```powershell
Uninstall-Biobot-UroSoftware.ps1
```

The convenience launcher is:

```cmd
Run-Uninstall-Biobot-UroSoftware.cmd
```

The batch launcher checks for Administrator rights, relaunches itself elevated when needed, and then runs the PowerShell script with `ExecutionPolicy Bypass`.

## Repository Layout

```text
Uninstall_script/
+-- Uninstall-Biobot-UroSoftware.ps1
+-- Run-Uninstall-Biobot-UroSoftware.cmd
+-- HANDOVER.md
```

## What It Removes

The PowerShell script currently targets these Biobot Uro products:

- UroBiopsy
- UroConnect
- UroFusion
- UroReview
- UroTherapy

Detection is based on Windows uninstall registry entries and known installer locations under `C:\Program Files\Biobot\...`.

## Normal Usage

Run from an elevated Command Prompt or PowerShell session:

```cmd
Run-Uninstall-Biobot-UroSoftware.cmd
```

Or run the PowerShell script directly:

```powershell
powershell.exe -ExecutionPolicy Bypass -NoProfile -File .\Uninstall-Biobot-UroSoftware.ps1
```

Useful options:

```powershell
powershell.exe -ExecutionPolicy Bypass -NoProfile -File .\Uninstall-Biobot-UroSoftware.ps1 -DryRun
powershell.exe -ExecutionPolicy Bypass -NoProfile -File .\Uninstall-Biobot-UroSoftware.ps1 -ShowUI
powershell.exe -ExecutionPolicy Bypass -NoProfile -File .\Uninstall-Biobot-UroSoftware.ps1 -TimeoutSeconds 1800
```

## Logging

The default log location is:

```text
C:\ProgramData\BiobotUroSoftware\Uninstall-Biobot-UroSoftware.log
```

The log records start time, machine/user context, dry-run state, timeout, each product uninstall attempt, and final status.

## Operational Notes

- Run as Administrator.
- Use `-DryRun` first when checking a new machine or installer version.
- The default silent uninstall argument is `/S`, which is typical for NSIS uninstallers.
- If a future installer uses a different silent switch, update the `SilentArgs` field in the `$Products` list.
- Keep the `.cmd` and `.ps1` files in the same folder, because the launcher resolves the PowerShell path relative to itself.

## Maintenance Notes

- Product detection lives in the `$Products` array near the top of `Uninstall-Biobot-UroSoftware.ps1`.
- Registry scanning is handled by `Get-UninstallRegistryEntries`.
- Product matching is handled by `Get-InstalledEntriesForProduct`.
- The script checks both registry state and known uninstaller paths when deciding whether a product is still installed.
