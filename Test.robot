*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  String
Suite Teardown    Run Keyword And Ignore Error  Suite shutdown

*** Variables ***
${browser}  chrome
${var}    //button[@title="voir le numéro"]

*** Test Cases ***
LoginTest
    Open Browser    https://www.leboncoin.fr/voitures/2194364218.htm  ${browser}
    click element   //button[@id="didomi-notice-agree-button"]
    click element   ${var}
    input text  id:email    admin@espacebazar.com
    input text  id:password     Espacebazar2022
    click element   xpath://*[@id="__next"]/div/main/div/div/form/div[5]/button
    Wait Until Element Is Visible   ${var}
    ReadLinks  

*** Keywords ***
ReadLinks
    ${File}=    Get File  contacts.txt
    @{list}=    Split to lines  ${File}
    FOR    ${line}   IN    @{list}
        ${Value}=   Get Variable Value  ${line}
        go to   ${value}
        ${present}    Get Element Count    ${var}
        IF  ${present} != 0     LoginTry
        IF  ${present} == 0     CONTINUE
    END 

LoginTry
    click element   ${var}
    Wait Until Element Is Visible   //a[@class="_2qvLx _3osY2 _35pAC _1Vw3w _kC3e _32ILh _2L9kx _30q3D _1y_ge _3QJkO"]
    ${number}  Get Text    //a[@class="_2qvLx _3osY2 _35pAC _1Vw3w _kC3e _32ILh _2L9kx _30q3D _1y_ge _3QJkO"]
    InsertNumbers  ${number}

InsertNumbers
  [Arguments]  ${variable}
  ${str}    Append to file  ${CURDIR}\\file_with_variable.txt  ${variable}\n

Suite shutdown
     Erro1234r 
     Close All Browsers