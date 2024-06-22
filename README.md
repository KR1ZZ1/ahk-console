# AHK Console OutputDebug
Ansi Styled OutputDebug Messages
- Tested with Visual Studio Code's debug console

How to use

    ; When console.ahk is in `\lib`
    ;#Include <console>

    ; When console.ahk is in same folder
    ;#Include console.ahk

    console.success("This is console.success(), its pretty chill.")

    console.info("This is console.info() doing its thing")

    console.error("Error?!"
                 ,"This is console.error()"
                 ,"The first parameter serves as a blinking title to grab attention,"
                 ,"while any additional parameters has a red text color.")

    console.log("This is console.log()"
               ,"Strings and integers uses the console's default text color but"
               ,"it works well with simple and associative arrays"
               ,[1234, 4321, {asdf: 1234, fdas: 4321}, [2345, 2345, 5678, "asdf"]])