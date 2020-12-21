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
            $testFilePath="$TestDrive/data.json"
            Convert-CSVToJSON -filePathCSV "$PSScriptRoot/TestData/data.csv" `
                        -filePathJSON "$testFilePath"
        }
        AfterAll {
            Remove-Item -Path "$testFilePath"
        }
        it 'should JSON file exist' {
            "$testFilePath" | Should -Exist
        }
        it 'should JSON file be expected file' {
            $actual = Get-Content  -Path "$testFilePath"
            $expected = Get-Content  -Path "$PSScriptRoot/TestData/data_expected.json"
            $expected | Should -Be $actual
        }
        it 'should not throw exception' -Tag E2E{
            {
                Convert-CSVToJSON -filePathCSV "$PSScriptRoot/TestData/data.csv" `
                        -filePathJSON "$testFilePath"
            } | Should -Not -Throw
        }
    }
}