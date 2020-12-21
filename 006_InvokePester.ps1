Invoke-Pester `
    -ExcludeTagFilter E2E `
    -Script "$PSScriptRoot\005_ModuleTesting.ps1" `
    -OutputFile $PSScriptRoot\Results\pesterTEST.xml `
    -OutputFormat 'NUnitXML' `
    -PassThru `
    -CodeCoverageOutputFile $PSScriptRoot\Coverage\pesterCoverageTEST.xml `
    -CodeCoverage "$PSScriptRoot\005_ModuleTesting.psm1"
