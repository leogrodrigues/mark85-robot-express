*** Settings ***
Documentation        Cenarios de testes do cadastro de usuarios

Resource       ../resources/base.resource

Test Setup       Start Session
Test Teardown    Take Screenshot


*** Test Cases ***
Deve poder cadastrar um novo usuario

    ${user}        Create Dictionary        name=Leo Gama    email=gama@gmail.com    password=pwd123
  
    Remove user from database    ${user}[email]

    Go to signup Page
    Submit signup from    ${user}
    Notice should be    Boas vindas ao Mark85, o seu gerenciador de tarefas.


Nao deve permitir o cadastro com email duplicado
    [Tags]    dup    #com a tag vc roda somente o teste indicado >> robot -d ./logs -i dup tests/signup.robot

    ${user}    Create Dictionary    name=Leo Rodrigues    email=rodrigues@gmail.com    password=pwd123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}
           
    Go to signup Page
    Submit signup from    ${user}
    Notice should be    Oops! Já existe uma conta com o e-mail informado.
     
Campos obrigatorios
    [Tags]    required

    ${user}        Create Dictionary        name=${EMPTY}    email=${EMPTY}    password=${EMPTY}

    Go to signup Page
    Submit signup from    ${user}

    #Antes de coloar para page objctive
    #Wait For Elements State    css=.alert-error >> text=Informe seu nome completo                     visible    5   
    #Wait For Elements State    css=.alert-error >> text=Informe seu e-email                           visible    5
    #Wait For Elements State    css=.alert-error >> text=Informe uma senha com pelo menos 6 digitos    visible    5

    Alert should be    Informe seu nome completo 
    Alert should be    Informe seu e-email 
    Alert should be    Informe uma senha com pelo menos 6 digitos

   
Não deve cadastrar com email incorreto
    [Tags]    email

    ${user}        Create Dictionary        name=Leo Gama    email=leo.leo    password=123456

    Go to signup Page
    Submit signup from    ${user}

    Alert should be    Digite um e-mail válido 
    

Não pode cadastrar com senha curta
    [Tags]    email_0

    @{pass_list}        Create List        1    12    123    1234    12345

    FOR    ${pass}    IN    @{pass_list}
        ${user}        Create Dictionary        name=Leo Gama    email=leo@gmail.com    password=${pass}

        Go to signup Page
        Submit signup from    ${user}

        Alert should be    Informe uma senha com pelo menos 6 digitos
            
    END
    



Não pode cadastrar senha com menos de 6 digitos velho
    [Tags]    email_6

    ${user}        Create Dictionary        name=Leo Gama    email=leo@gmail.com    password=1234

    Go to signup Page
    Submit signup from    ${user}

    Alert should be    Informe uma senha com pelo menos 6 digitos


Não pode cadastrar senha com menos de 2 digitos
    [Tags]    email_6
    [Template]
    Short password    1


Não pode cadastrar senha com menos de 3 digitos
    [Tags]    email_6
    [Template]
    Short password    12

    
*** Keywords ***
Short password        #templete de testes
    [Arguments]        ${short_pass}

    ${user}        Create Dictionary        name=Leo Gama    email=leo@gmail.com    password=${short_pass}

    Go to signup Page
    Submit signup from    ${user}

    Alert should be    Informe uma senha com pelo menos 6 digitos

    