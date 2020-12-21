Import-Module $PSScriptRoot/005_ModuleTesting.psm1 -Force

Describe  "Exported functions tests" {
    Context "When I run A" {
        It "should return correct messafe" {
            A | Should -be "I am A and I am B"
        }
    }
    Context "When I run B" -Skip{
        It "should fail since B is not exported" {
            B | Should -be "I am B"
        }
    }
}


InModuleScope 005_ModuleTesting {
    Describe  "Module internal functions tests" {
        Context "When I run B" {
            It "should return correct content" {
                B | Should -be "I am B"
            }
        }
    }
}