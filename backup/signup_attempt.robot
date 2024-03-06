*** Settings ***
Documentation        Cenarios de testes de tentativa cadastro de usuarios senha curta #template de suite

Resource             ../resources/base.resource

Test Template        Short password

Test Setup           Start Session
Test Teardown        Take Screenshot



*** Test Cases ***
Não pode cadastrar senha com menos de 2 digito    1

Não pode cadastrar senha com menos de 3 digitos    12

Não pode cadastrar senha com menos de 4 digitos    123

Não pode cadastrar senha com menos de 5 digitos    1234
   


*** Keywords ***
Short password        #templete de testes
    [Arguments]        ${short_pass}

    ${user}        Create Dictionary        name=Leo Gama    email=leo@gmail.com    password=${short_pass}

    Go to signup Page
    Submit signup from    ${user}

    Alert should be    Informe uma senha com pelo menos 6 digitos
