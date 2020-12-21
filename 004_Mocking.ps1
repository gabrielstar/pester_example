function Get-File($FilePath){
    return Get-Content -Path $FilePath -ErrorAction Stop
}

function Convert-CSVToJSON($FilePathCSV, $FilePathJSON)
{
    try
    {
        $csv = Get-File -FilePath $FilePathCSV
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
    Context 'When I convert existing CSV file to JSON' {
        it 'should produce JSON file if source file is empty' {
            Mock Get-File { return "" }
            Convert-CSVToJSON "" "$TestDrive/data.json"
            "$TestDrive/data.json" | Should -Exist
        }
        it 'should JSON file be expected file' {
            $testFilePath = "$TestDrive/data.json"
            Mock Get-File { return Get-Content "$PSScriptRoot/TestData/data.csv" }
            Convert-CSVToJSON "" "$testFilePath"
            $actual = Get-Content  -Path "$testFilePath"
            $expected = Get-Content  -Path "$PSScriptRoot/TestData/data_expected.json"
            $expected | Should -Be $actual
        }
    }
}