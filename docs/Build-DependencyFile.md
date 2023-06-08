---
external help file: PSDependHelper-help.xml
Module Name: PSDependHelper
online version:
schema: 2.0.0
---

# Build-DependencyFile

## SYNOPSIS
Create a dependency file from the content of a directory.

## SYNTAX

```
Build-DependencyFile [-Directory] <DirectoryInfo> [-Path] <FileInfo> [<CommonParameters>]
```

## DESCRIPTION
Scan a directory for PowerShell manifests and scripts, extract the dependencies and create a PSDepend file.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Directory
The directory, to scan for dependencies.

```yaml
Type: DirectoryInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
The path, where to create the file.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
