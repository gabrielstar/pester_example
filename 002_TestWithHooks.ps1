Function Convert-CSVToJSON($FilePathCSV, $FilePathJSON)
{
    try
    {
        $csv = Get-Content -Path $FilePathCSV -ErrorAction Stop
        $csv = $csv | ConvertFrom-Csv | ConvertTo-Json | Out-File -Encoding UTF8 $FilePathJSON
    }
    catch [System.Management.Automation.ItemNotFoundException]
    {
        "IO Error while rading/writing file: {0},{1}" -f $FilePathCSV, $FilePathJSON
        "Terminating"
    }
    return

}
Describe 'File conversion tests' {
    Context 'when I convert existing CSV file to JSON' {
        BeforeAll {
            Convert-CSVToJSON -filePathCSV "$PSScriptRoot/TestData/data.csv" `
                        -filePathJSON "$PSScriptRoot/TestData/data.json"
        }
        AfterAll {
            Remove-Item -Path "$PSScriptRoot/TestData/data.json"
        }
        it 'should JSON file exist' {
            "$PSScriptRoot/TestData/data.json" | Should -Exist
        }

        it 'should JSON file be expected file' {
            $actual = Get-Content  -Path "$PSScriptRoot/TestData/data.json"
            $expected = Get-Content  -Path "$PSScriptRoot/TestData/data_expected.json"
            $expected | Should -Be $actual
        }
        it 'should not throw exception' {
            {
                Convert-CSVToJSON -filePathCSV "$PSScriptRoot/TestData/data.csv" `
                        -filePathJSON "$PSScriptRoot/TestData/data.json"
            } | Should -Not -Throw
        }
    }
}