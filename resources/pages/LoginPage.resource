*** Settings ***
Documentation        Elementos e ações da pagina de login

Library    Browser
Library    String



*** Keywords ***

User should be logged in

   [Arguments]        ${user_name}

   @{splited_name}    Split String    ${user_name}

   ${element}         Set Variable    header .right small

   Wait For Elements State    ${element}    visible    5

   Get Text    ${element}    equal    Olá, ${splited_name}[0]

