function foo(){
    return "foo"
}
Describe 'My tests' {
    Context 'When run default context' {
        it 'should 1 be 1' {
            1 | Should -Be 1
        }
        it 'should Text match pattern' {
            "Text" | Should -Match "Tex*"
        }
        it 'should array have a 2 element' {
            @(1,2,3) | Should -Contain 2
        }
        it 'should return foo' {
            foo | Should -be "foo"
        }
    }
}