*** Settings ***
Documentation        Configuração de seção

Library    libs/database.py
Library    Browser


*** Variables ***
${BASE_URL}    http://localhost:3000



*** Keywords ***    
Start Session

    New Browser     browser=chromium    headless=False  #para abrir uma aba do navegador
    New Page        http://localhost:3000
        