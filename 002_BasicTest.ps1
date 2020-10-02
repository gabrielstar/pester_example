Function CSVToJSON($filePathCSV, $filePathJSON)
{
    try
    {
        $csv = Get-Content -Path $filePathCSV -ErrorAction Stop
        $csv = $csv | ConvertFrom-Csv | ConvertTo-Json | Out-File -Encoding UTF8 $filePathJSON
    }
    catch [System.Management.Automation.ItemNotFoundException]
    {
        "IO Error while rading/writing file: {0},{1}" -f $filePathCSV, $filePathJSON
        "Terminating"
    }
    return

}
Describe 'File conversion tests' {
    Context 'when I convert existing CSV file to JSON' {
        BeforeAll {
            CSVToJSON -filePathCSV "$PSScriptRoot/TestData/data.csv" `
                        -filePathJSON "$PSScriptRoot/TestData/data.json"
        }
        it 'should JSON file exist' {
            "$PSScriptRoot/TestData/data.json" | Should -Exist
        }

        it 'should JSON file be expected file' {
            $actual = Get-Content  -Path "$PSScriptRoot/TestData/data.json"
            $expected = Get-Content  -Path "$PSScriptRoot/TestData/data.json"
            $expected | Should -Be $actual
        }
        it 'should not throw exception' {
            {
                CSVToJSON -filePathCSV "$PSScriptRoot/TestData/data.csv" `
                        -filePathJSON "$PSScriptRoot/TestData/data.json"
            } | Should -Not -Throw
        }
    }
}