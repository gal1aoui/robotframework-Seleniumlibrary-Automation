*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  String
Library     BuiltIn

*** Variables ***
${url}      https://www.leboncoin.fr/voitures/2161331390.htm
${browser}  Chrome
${var}    //button[@title="voir le numéro"]
${nav}      xpath://*[@id="container"]/div[1]/div/div[1]/div[2]/div/header/div[1]/nav[2]/div[2]/a[3]/div/span

*** Test Cases ***
LoginTest
    open browser   ${url}   ${browser}
    click element   //button[@id="didomi-notice-agree-button"]
    click element   ${var}
    input text  id:email    admin@espacebazar.com
    input text  id:password     Espacebazar2022
    click element   xpath://*[@id="__next"]/div/main/div/div/form/div[5]/button
    Wait Until Element Is Visible   ${var}      4 minutes
    ReadLinks  

*** Keywords ***
ReadLinks
    ${File}=    Get File  contacts.txt
    @{list}=    Split to lines  ${File}
    FOR    ${line}   IN    @{list}
        ${Value}=   Get Variable Value  ${line}
        go to   ${value}
        ${navbarExist}      Get Element Count   ${nav}

        IF  ${navbarExist} != 0

            ${present}    Get Element Count    ${var}

            IF  ${present} != 0
                click element   ${var}
                Sleep   5sec
                ${waits}    Get Element Count    //a[@class="_2qvLx _3osY2 _35pAC _1Vw3w _kC3e _32ILh _2L9kx _30q3D _1y_ge _3QJkO"]
                
                IF  ${waits} == 0     CONTINUE
                
                IF  ${waits} != 0
                    ${number}  Get Text    //a[@class="_2qvLx _3osY2 _35pAC _1Vw3w _kC3e _32ILh _2L9kx _30q3D _1y_ge _3QJkO"]
                    InsertNumbers  ${number}
                    ${str}    Append to file  ${CURDIR}\\links_numbers.txt  ${number} :: ${Value}\n
                END
                
            END

            IF  ${present} == 0     CONTINUE
            
        END
        IF  ${navbarExist} == 0
            Log To Console      ${Value}
            ${str}    Append to file  ${CURDIR}\\dernier_lien.txt  ${Value}\n
            Close Browser
        END
    END 

InsertNumbers
  [Arguments]  ${variable}
  ${str}    Append to file  ${CURDIR}\\phone_numbers.txt  ${variable}\n