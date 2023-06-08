---
external help file: PSDependHelper-help.xml
Module Name: PSDependHelper
online version:
schema: 2.0.0
---

# Export-DependencyFile

## SYNOPSIS
Export dependencies as file

## SYNTAX

```
Export-DependencyFile [-Path] <FileInfo> [-Module] <ModuleSpecification> [<CommonParameters>]
```

## DESCRIPTION
Convert a collection of ModuleSpecification objects into a PSDepend file.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Path
The path where to create the dependency file.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Module
Specifies the dependency by module name and version

```yaml
Type: ModuleSpecification
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft.PowerShell.Commands.ModuleSpecification
## NOTES

## RELATED LINKS
