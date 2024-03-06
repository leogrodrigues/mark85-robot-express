*** Settings ***
Documentation        Configuração de seção

Library     libs/database.py
Library     Browser
Library     JSONLibrary

Resource       env.resource
Resource       services.resource

Resource       pages/components/Notice.resource
Resource       pages/components/Alert.resource
Resource       pages/components/Header.resource
Resource       pages/SignupPage.resource
Resource       pages/LoginPage.resource
Resource       pages/TaskCreatePage.resource
Resource       pages/TasksPage.resource



*** Keywords ***    
Start Session

    New Browser     browser=${BROWSER}    headless=False  #para abrir uma aba do navegador
    New Page        ${BASE_URL}


#Helpers
Get fixture    
    [Arguments]        ${file_name}        ${scenario}

    ${data}     Load Json From File    ${EXECDIR}/resources/fixtures/${file_name}.json        encoding=utf-8

    [RETURN]        ${data}[${scenario}]


Reset user from database

    [Arguments]        ${user}

    Clean user from database         ${user}[email]
    Insert user from database        ${user}        

Create a new task from API

    [Arguments]    ${data}

    POST user session     ${data}[user]
    POST a new task       ${data}[task]

Do login

    [Arguments]    ${user}

    Submit login from           ${user}
    User should be logged in    ${user}[name]
