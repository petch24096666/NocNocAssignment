*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close Browser

*** Variables ***
${browser}      Chrome
${login_url_nocnoc}    https://nocnoc.com/login
${url_nocnoc}   https://nocnoc.com/
${element}    xpath=//*
${Banner}    xpath=//*[@id="CAR_9317F06F08040"]/div/div[2]/div/div/div/div
${Click NocNoc's-Choice}    document.querySelector('a.sm-banner-img-link').click()
${logo_click}    document.querySelector('img[src="/static/images/new_nocnoc_logo.svg?v=2"]').click()
${NocNoc's-Choice_Path}    https://nocnoc.com/pl/NocNoc's-Choice?area=banner-nocnoc_choice_hotkey&fq=stockStatus%3Aeq%3AIN_STOCK%7CLOW_STOCK%7CisMadeToOrder.code%7CCOMING_SOON.uc%2Ctag.code%3Aeq%3ANocNoc_Choice
${Flashsale_path}    https://nocnoc.com/pl/Noc%20Flash%20Sale?fq=tag.code
${filter_1}    xpath=//*[@id="filterAccordion"]/div[1]/div[2]/div/div[2]/div[1]/label
${filter_2}    xpath=//*[@id="filterAccordion"]/div[1]/div[2]/div/div[2]/div[2]/label
${Category_result_span}    xpath=//*[@id="approot"]/main/div/div[4]/div/div[2]/div/ul/li/span
${Search Box}    document.getElementById("search-suggestion-input").click()
${Search input}    xpath=//*[@id="search-suggestion-input"]
${Search Button}    document.querySelector('button[name="searchButton"]').click()
${Search Text Result}    xpath=//*[@id="approot"]/main/div/div[2]/div[2]/div/div/h1
${ExampleProduct}    document.querySelector('p.product-item-description').click()
${Email_Pnumber_Input}    xpath=//*[@id="email-phone"]
${Username}    petch24096666.sa@gmail.com
${LoginButton}    document.querySelector('.btn.btn-primary.big-btn').click()
${Password_Input}    name:password
${Password}    test1234
${Change_Languge_Button}    document.querySelector('button.choose-language').click()
${Change_to_en}    document.querySelector('ul.account-types li[value="en"]').click()
${Change_to_th}    document.querySelector('ul.account-types li[value="th"]').click()
${Promotion_IMG}    document.querySelector('a.banner-img-link').click();
***Test Cases ***
Test Login
    Open Browser    ${login_url_nocnoc}    Chrome
    Maximize Browser Window
    Execute JavaScript    document.body.style.zoom = '75%'
    Sleep    2s
    Input Text    ${Email_Pnumber_Input}    ${Username}
    Sleep    2s
    Execute JavaScript    ${LoginButton}
    Sleep    4s
    Input Text    ${Password_Input}     ${Password}
    Sleep    2s
    Execute JavaScript    ${LoginButton}
    Sleep    2s
Test Element Homepage is Visible
    ${title}=    Get Title
    Should Be Equal As Strings  ${title}  NocNoc - ตลาดออนไลน์วัสดุและของแต่งบ้าน พร้อมติดตั้งครบวงจร
    Wait Until Element Is Visible    ${element}
    ${element_visible}    Run Keyword And Return Status    Element Should Be Visible    ${element}
    Run Keyword If    ${element_visible}    Log    Element is visible
    ...    ELSE    Log    Element is not visible
    ${path}=    Get Location
    Should Be Equal As Strings  ${path}  ${url_nocnoc}
Test Change Language to Engish
    Execute JavaScript    ${Change_Languge_Button}
    Sleep    2s
    Execute JavaScript    ${Change_to_en}
    Sleep    3s
    ${title}=    Get Title
    Should Be Equal As Strings    ${title}    NocNoc Online Shopping: Enjoy shopping with us!
Test Change Language to Thai
    Execute JavaScript    ${Change_Languge_Button}
    Sleep    2s
    Execute JavaScript    ${Change_to_th}
    Sleep    3s
    ${title}=    Get Title
    Should Contain    ${title}    NocNoc - ตลาดออนไลน์วัสดุและของแต่งบ้าน พร้อมติดตั้งครบวงจร
Test Promotion IMG path
    Execute Javascript    ${Promotion_IMG}
    ${path}=    Get Location
    Should Contain    ${path}    https://nocnoc.com/promotions/
    Sleep    5s
    Execute Javascript    ${logo_click}
Test NocNoc's-Choice
    Sleep     5s
    Execute JavaScript    ${Click NocNoc's-Choice}
    ${path}=    Get Location
    Should Be Equal As Strings  ${path}  ${NocNoc's-Choice_Path}
    Sleep    3s
    ${title_name}=    Get Title
    Should Be Equal As Strings  ${title_name}    NocNoc's-Choice Category - NocNoc - ตลาดออนไลน์วัสดุและของแต่งบ้าน พร้อมติดตั้งครบวงจร - NocNoc
    Sleep    3s
    Execute JavaScript    ${logoclick}
    Sleep    3s
Test Flash sale Promotion
    Execute JavaScript    document.querySelector('img[src="https://cdn.nocnoc.com/campaign-assets/images/carousel-assets/logo-tab.png"]').click()
    Sleep    3s
    ${path}=    Get Location
    Should Contain   ${path}  ${Flashsale_path}
    Sleep    3s
    ${title_name}=    Get Title
    Should Be Equal As Strings  ${title_name}    Noc Flash Sale Category - NocNoc - ตลาดออนไลน์วัสดุและของแต่งบ้าน พร้อมติดตั้งครบวงจร - NocNoc
Test Filter in Flash Sale
    Click Element    ${filter_1}
    Sleep    3s
    ${filter}=    Get Text    ${Category_result_span}
    Should Contain   ${filter}    เครื่องใช้ไฟฟ้า
    Click Element    ${filter_1}
    Click Element    ${filter_2}
    Sleep    3s
    ${filter}=    Get Text    ${Category_result_span}
    Should Contain   ${filter}    เครื่องออกกำลังกาย
    Execute JavaScript    ${logoclick}
    Sleep    5s
Test Search input
    Execute JavaScript    ${Search Box}
    Input Text    ${Search input}   พัดลม
    Execute JavaScript    ${Search Button}
    Sleep    5s
    ${Search_value}=    Get Text    ${Search Text Result}
    Should Be Equal As Strings  ${Search_value}    รายการสินค้า: "พัดลม"
    Execute JavaScript    ${logoclick}
    Sleep    3s
Test Click Product
    Execute JavaScript    ${Click NocNoc's-Choice}
    Sleep    3s
    Execute JavaScript    ${ExampleProduct}
    Sleep    3s
    ${path}=    Get Location
    Should Contain  ${path}  https://nocnoc.com/pl/NocNoc's-Choice?area=banner-nocnoc_choice_hotkey
    Close Browser