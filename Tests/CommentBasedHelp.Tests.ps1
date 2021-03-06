Describe -Name 'ObjectDefinitions' -Tag 'Public', 'ObjectDefinitions' -Fixture {
    Context -Name 'Test script logic' -Fixture {
        $cases = Get-ChildItem ./Rubrik/Public | ForEach-Object {
            @{'o' = $_.BaseName}
        }

        It -Name "Help Definition - <o> - No Capitalized Links" -TestCases $cases { 
            param($o)
            $HelpString = Get-Content -Path ".\Rubrik\Public\$o.ps1" -Raw
            $HelpString -match '(?<p>.*?\.LINK.*?).*?\n(?<Link>.*)'

            $Matches.Link | Should -BeExactly $Matches.Link.ToLower()
        }

        It -Name "Help Definition - <o> - Correct Link Formatting" -TestCases $cases { 
            param($o)
            $HelpString = Get-Content -Path ".\Rubrik\Public\$o.ps1" -Raw
            $HelpString -match '(?<p>.*?\.LINK.*?).*?\n(?<Link>.*)'

            $Matches.Link.Trim() | Should -Be "https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/$o"
        }
    }
}