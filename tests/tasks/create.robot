*** Settings ***
Documentation            Cenarios de cadastro de tarefas

Resource        ../../resources/base.resource


Test Setup       Start Session
Test Teardown    Take Screenshot


*** Test Cases ***

Deve poder cadastrar uma nova tareda
     
   ${data}        Get fixture    tasks    create

   Clean user from database         ${data}[user][email]
   Insert user from database        ${data}[user]

   Submit login from           ${data}[user]
   User should be logged in    ${data}[user][name]

   Go to task form

   Submit task form    ${data}[task]

   Task should be registered    ${data}[task][name]

   #Log    ${data}[create][user]    #so pega os dados do usuario


Não deve cadastrar tarefa com nome duplicado
   [Tags]    dup

   ${data}        Get fixture    tasks    duplicate

   # Dado que eu tenho um novo usuario
   Reset user from database    ${data}[user]

   # E que esse usuario ja cadastrou uma tarefa
   #POST user session    ${data}[user]
   #POST a new task    ${data}[task]
   Create a new task from API    ${data}


   # E que estou logado na aplicação web
   #Submit login from           ${data}[user]
   #User should be logged in    ${data}[user][name]
   Do login    ${data}[user]


   # Quando tento fazer um cadastro de uma tarefa já cadastrada
   Go to task form
   Submit task form    ${data}[task]

   # Então devo ver uma notificação de duplicidade
   Notice should be    Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atinge o limite de Tags
   [Tags]    limit

   ${data}        Get fixture    tasks    tags_limit

   #Clean user from database         ${data}[user][email]
   #Insert user from database        ${data}[user]
   Reset user from database    ${data}[user]


   Submit login from           ${data}[user]
   User should be logged in    ${data}[user][name]

   Go to task form
   Submit task form    ${data}[task]

   Notice should be    Oops! Limite de tags atingido.


    


