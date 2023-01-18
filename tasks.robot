*** Settings ***
Documentation

Library    RPA.Robocorp.WorkItems
Library    String
Library    Collections
Library    RPA.Notifier
Library    RPA.Robocorp.Vault

*** Tasks ***
Minimal task
    ${secret}=    Get Secret    SlackNotifier
    ${payload}=    Get Work Item Payload

    ${emailContent}=    Set Variable     ${payload["email"]["text"]}
    ${contentSplitByNewLines}=    Split String    ${emailContent}    \n

    ${endOfContentIndex}=    Get Index From List    ${contentSplitByNewLines}    Do you have comments or suggestions about F5Bot? Please hit reply and let me know what you think!
    ${startOfContentIndex}=    Set Variable    1
    ${withoutFooterAndHeader}=    Get Slice From List    ${contentSplitByNewLines}    ${startOfContentIndex}    ${endOfContentIndex}
    ${trimmedAndWithoutEmptyStrings}=    Evaluate    [x.strip() for x in @{withoutFooterAndHeader} if x]
    ${mentionToPost}=    Catenate    SEPARATOR=${\n}    @{trimmedAndWithoutEmptyStrings}

    Notify Slack
    ...    ${mentionToPost}
    ...    channel=%{SLACK_CHANNEL}
    ...    webhook_url=${secret["WEBHOOK"]}
