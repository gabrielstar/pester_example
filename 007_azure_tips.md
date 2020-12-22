Tips for writing your own logic in azure pipelines (as scripts):

* If possible, use Azure existing tasks to do what you want to do, write your own logic if you need to
* When developing custom logic for your pipeline put it in a script and not as 'inline' element - that makes it testable

This is good and testable:

      - task: PowerShell@2
        displayName: Run Pester tests with Coverage
        inputs:
          filePath: '$(System.DefaultWorkingDirectory)\006_InvokePester.ps1'
          pwsh: true

This is not so good:

      - powershell: |
          $dirs=@('Results','Coverage')
          foreach($dir in $dirs){
            New-Item -ItemType Directory -Force -Path "$(System.DefaultWorkingDirectory)\$dir"
          }
        displayName: Prepare Tests Directories

* If something can be generalized, consider writing a Task 