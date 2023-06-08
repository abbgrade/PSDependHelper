---
external help file: PSDependHelper-help.xml
Module Name: PSDependHelper
online version:
schema: 2.0.0
---

# Import-Dependency

## SYNOPSIS
Import dependencies from PowerShell scripts and manifests.

## SYNTAX

```
Import-Dependency [-Path] <FileInfo> [-Recurse] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Path
Path to the PowerShell script or manifest.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Recurse
If set, dependencies of required modules are imported recursively.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.PowerShell.Commands.ModuleSpecification
## NOTES

## RELATED LINKS
