# AHK Console OutputDebug
Ansi Styled OutputDebug Messages
- Tested with Visual Studio Code's debug console

How to use

    ; When console.ahk is in `\lib`
    ;#Include <console>

    ; When console.ahk is in same folder
    ;#Include console.ahk

    ; Example usage of "string".print() prototype using `console.log()`
    A_AhkVersion.print()
    
    ; Example usage of console.success()
    console.success("Operation completed successfully!")
    
    ; Example usage of console.info()
    console.info("Informational message: The process is running smoothly.")
    
    ; Example usage of console.warn()
    console.warn("Warning: Potential Issue Detected"
                ,"Detailed Warning: The operation you attempted might cause unexpected behavior."
                ,"Please verify your inputs and ensure all conditions are met before proceeding.")
    
    ; Example usage of console.error()
    console.error("Error: Critical Failure"
                 ,"An unexpected error occurred during the execution of the script."
                 ,"Please check your configuration and try again.")
    
    ; Example usage of console.log()
    complexArray := ["example string"
                    ,[7, 8, 9, "nested array"]
                    ,{id: 1, name: "Alice", attributes: {age: 30, occupation: "Engineer"}}]
    console.log("Logging a complex array:", complexArray)

![image](https://github.com/KR1ZZ1/ahk-console/assets/102970447/11fb94f9-1a6b-4348-bc3e-d9f121046b02)


