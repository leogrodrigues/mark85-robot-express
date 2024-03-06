*** Settings ***
Documentation        Cenarios de testes de login

Resource       ../resources/base.resource

Library    Collections

Test Setup       Start Session
Test Teardown    Take Screenshot


*** Test Cases ***
Deve poder logar com usuario pré-cadastrado

    ${user}        Create Dictionary        name=Leo Gama   email=gama@gmail.com    password=pwd123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Submit login from           ${user}

    User should be logged in    ${user}[name]


Não deve logar com senha incorreta

    ${user}        Create Dictionary        name=Gama Gama   email=gama_gama@gmail.com    password=123456
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Set To Dictionary    ${user}    password=1234tr

    Submit login from    ${user}

    Notice should be    Ocorreu um erro ao fazer login, verifique suas credenciais.
        

    
