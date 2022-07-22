*** Settings ***
Library  SeleniumLibrary
Library  func.py

*** Variables ***
${url}  https://www.leboncoin.fr/caravaning/2193988887.htm
${browser}  chrome
${var}    xpath://*[@id="aside"]/section/div/div[3]/div[3]/div/button

*** Test Cases ***
LoginTest
    # Open Browser    http://www.leboncoin.fr/   Firefox
    # sleep   3s
    Open Browser    ${url}  ${browser}
    LoginTry
    # Execute Javascript    window.open('https://www.leboncoin.fr/voitures/2194103197.htm')
    sleep   5s
    close Browser   

*** Keywords ***
LoginTry
    click element   //button[@id="didomi-notice-agree-button"]
    click element   xpath://*[@id="aside"]/section/div/div[3]/div[3]/div/button
    # ${var}  Get Element Count    xpath://*[@id="aside"]/section/div/div[3]/div[3]/div/button
    # Run Keyword If  ${var} > 0  log to console  "Successfull"   ELSE    log to console  "Failed"    END
    input text  id:email    admin@espacebazar.com
    input text  id:password     Espacebazar2022
    click element   xpath://*[@id="__next"]/div/main/div/div/form/div[5]/button
    Sleep   3s
    click element   //button[@title="voir le numéro"]
    Sleep   5s
    ${number}  Get Text    //a[@class="_2qvLx _3osY2 _35pAC _1Vw3w _kC3e _32ILh _2L9kx _30q3D _1y_ge _3QJkO"]