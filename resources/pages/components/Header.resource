*** Settings ***
Documentation        Ações e elementos do componente header

Library    Browser


*** Keywords ***

Submit login from 
    [Arguments]        ${user}

    Fill Text    css=input[placeholder="E-mail"]    ${user}[email]
    Fill Text    css=input[placeholder=Senha]       ${user}[password]

    Click    xpath=//button[text()="Entrar"]   #css=button >> text=Entrar

Go to task form

    Click    css=.button-add

    