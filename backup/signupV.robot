*** Settings ***
Documentation        Cenarios de testes do cadastro de usuarios

Library    FakerLibrary

Resource       ../resources/base.robot

Test Setup       Start Session
Test Teardown    Take Screenshot


*** Variables ***

${name} =         Leo Gama
${email} =        gama@gmail.com
${password} =     pwd123


*** Test Cases ***

Deve poder cadastrar um novo usuario

#    ${name} =         FakerLibrary.Name
#    ${email} =        FakerLibrary.Free Email
#    ${password} =     Set Variable    pwd123 

    #${name} =         Set Variable    Leo Gama
    #${email} =        Set Variable    gama@gmail.com
    #${password} =     Set Variable    pwd123

    Remove user from database    ${email}
    
    #Start Session    
    Go To            http://localhost:3000/signup
        
    Wait For Elements State    xpath=//h1        visible       5
    Get Text                   css=h1        equal         Faça seu cadastro

    Fill Text    id=name                          ${name}
    Fill Text    css=#email                       ${email}
    Fill Text    xpath=//input[@id='password']    ${password}

    Click    id=buttonSignup

    Wait For Elements State    .notice p    visible    5
    Get Text                   .notice p    equal      Boas vindas ao Mark85, o seu gerenciador de tarefas.

    #Take Screenshot


Nao deve permitir o cadastro com email duplicado
    [Tags]    dup    #com a tag vc roda somente o teste indicado >> robot -d ./logs -i dup tests/signup.robot

    ${user}    Create Dictionary    name=Leo Rodrigues    email=rodrigues@gmail.com    password=pwd123

    #${name} =         Set Variable    Leo Rodrigues  >>> fivou dicionario
    #${email} =        Set Variable    rodrigues@gmail.com
    #${password} =     Set Variable    pwd123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}
           

    #Start Session    
    Go To            ${BASE_URL}/signup
        
    Wait For Elements State    xpath=//h1        visible       5
    Get Text                   css=h1            equal         Faça seu cadastro

    Fill Text    id=name                          ${user}[name]
    Fill Text    css=#email                       ${user}[email]
    Fill Text    xpath=//input[@id='password']    ${user}[password]

    Click    id=buttonSignup

    Wait For Elements State    .notice p    visible    5
    Get Text                   .notice p    equal      Oops! Já existe uma conta com o e-mail informado.

   
