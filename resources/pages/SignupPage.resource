*** Settings ***
Documentation        Elementos e ações da pagina de cadastro

Library    Browser

Resource       ../env.resource


*** Keywords ***

Go to signup Page
    Go To            ${BASE_URL}/signup
            
    Wait For Elements State    xpath=//h1        visible       5
    Get Text                   css=h1        equal         Faça seu cadastro

Submit signup from
    [Arguments]        ${user}
        
    Fill Text    css=input[name=name]             ${user}[name]
    Fill Text    css=input[name=email]            ${user}[email]
    Fill Text    xpath=//input[@id='password']    ${user}[password]

    Click       css=button[type=submit] >> text=Cadastrar


