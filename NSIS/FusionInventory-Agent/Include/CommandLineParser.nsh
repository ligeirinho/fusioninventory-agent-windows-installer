/*
   ------------------------------------------------------------------------
   FusionInventory
   Copyright (C) 2010-2012 by the FusionInventory Development Team.

   http://www.fusioninventory.org/   http://forge.fusioninventory.org/
   ------------------------------------------------------------------------

   LICENSE

   This file is part of FusionInventory project.

   FusionInventory is free software: you can [...]

   FusionInventory is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU Affero General Public License for more details.

   You should have received a copy of [...]

   ------------------------------------------------------------------------

   @package   FusionInventory Agent Installer for Microsoft Windows
   @file      .\FusionInventory Agent\Include\CommandLineParser.nsh
   @author    Tomas Abad
   @copyright Copyright (c) 2010-2012 FusionInventory Team
   @license   [...]
   @link      http://www.fusioninventory.org/
   @link      http://forge.fusioninventory.org/projects/fusioninventory-agent
   @since     2012

   ------------------------------------------------------------------------
*/


!ifndef __FIAI_COMMANDLINEPARSER_INCLUDE__
!define __FIAI_COMMANDLINEPARSER_INCLUDE__


!include FileFunc.nsh
!include LogicLib.nsh
!include WordFunc.nsh
!include "${FIAIDIR}\Include\FileFunc.nsh"
!include "${FIAIDIR}\Include\INIFunc.nsh"
!include "${FIAIDIR}\Include\StrFunc.nsh"


; Define command line parser logfile
!define COMMANDLINE_PARSER_LOGFILE "$PLUGINSDIR\CommandLineParser.log"


; GetCommandLineOptions
!define CommandLineOptionsSearchBlock "!insertmacro CommandLineOptionsSearchBlock"

!macro CommandLineOptionsSearchBlock ParamToSearch ParamIntoINIFile
   ${If} $R7 = 0
   ${AndIf} $R0 != ""
      ${Do}
         ${FileWriteLine} $R9 "--------------------"

         StrCpy $R2 "${ParamToSearch}"
         StrCpy $R3 ""
         StrCpy $R4 "${ParamIntoINIFile}"

         ${FileWriteLine} $R9 "Searching for '$R2'..."
         ${GetOptionsS} "$R0" "$R2" $R3
         ${FileWriteLine} $R9 "GetOptionsS('$R0', '$R2'): '$R3'"

         ${IfNot} ${Errors}
            ${FileWriteLine} $R9 "...'$R2' found!"

            ; Remove the first occurrence of $R2$R3 from $R0
            ${WordReplace} "$R0" "$R2$R3" "" "+1" $R1
            ${If} "$R0" == "$R1"
               ${WordReplace} "$R0" "$R2$\'$R3$\'" "" "+1" $R1
               ${If} "$R0" == "$R1"
                  ${WordReplace} "$R0" "$R2$\"$R3$\""  "" "+1" $R1
                  ${If} "$R0" == "$R1"
                     ${WordReplace} "$R0" "$R2$\`$R3$\`"  "" "+1" $R1
                  ${EndIf}
               ${EndIf}
            ${EndIf}
            ${Trim} $R0 "$R1"

            ${FileWriteLine} $R9 "New parameters (without '$R2[|$\'|$\"|$\`]$R3[$\`|$\"|$\'|]'): '$R0'"

            ; Check whether option $R2 already exist in Options.ini
            ${ReadINIOption} $R5 "$R8" "$R4"

            ${If} ${Errors}
               ; It's the first occurrence of $R2 into the command line

               ; Checks about $R3 below
               ; See examples inside 'GetCommandLineOptions' macro definition.
!macroend


!define EndCommandLineOptionsSearchBlock "!insertmacro EndCommandLineOptionsSearchBlock"

!macro EndCommandLineOptionsSearchBlock
               ; After checks about $R3
               ; See examples inside 'GetCommandLineOptions' macro definition.

               ; Write "$R4=$R3" into the section $R8 of the file Options.ini
               ${WriteINIOption} "$R8" "$R4" "$R3"

               ${FileWriteLine} $R9 "'$R4=$R3' written into the section [$R8] of the file '$PLUGINSDIR\Options.ini'"
            ${Else}
               ; It's the second occurrence of $R2 into the command line
               ; Syntax error. Only one occurrence is allowed.
               SetErrors
               StrCpy $R7 1
               ${FileWriteLine} $R9 "Syntax error. Only one occurrence of '$R2' is allowed into the command line."
               ${Break}
            ${EndIf}

            ${If} "$R0" == ""
               ${Break}
            ${EndIf}
         ${Else}
            ${FileWriteLine} $R9 "...'$R2' not found."
            ${Break}
         ${EndIf}
      ${Loop}
   ${EndIf}
!macroend


!define GetCommandLineOptions "Call GetCommandLineOptions"

Function GetCommandLineOptions
   ; $R0 Command line parameters
   ; $R1 Command line parameters (auxiliary string)
   ; $R2 Option to search in command line parameters
   ; $R3 Option value in command line parameters
   ; $R4 Option to search in Options.ini
   ; $R5 Option value in Options.ini
   ;
   ; $R7 Syntax error flag
   ; $R8 Options.ini section
   ; $R9 Command line parser logfile handle

   ; Push $R0, $R1, $R2, $R3, $R4, $R5, $R7, $R8 & $R9 onto the stack
   Push $R0
   Push $R1
   Push $R2
   Push $R3
   Push $R4
   Push $R5
   Push $R7
   Push $R8
   Push $R9

   ; Initialize syntax error flag
   StrCpy $R7 0

   ; Set Options.ini file section
   StrCpy $R8 "${IOS_COMMANDLINE}"

   ; Create an empty command line parser logfile
   Delete "${COMMANDLINE_PARSER_LOGFILE}"
   FileOpen $R9 "${COMMANDLINE_PARSER_LOGFILE}" w

   ; Delete '$R8' section from Options.ini
   ${DeleteINIOptionSection} "$R8"

   ; Get command line parameters
   ${GetParameters} $R0

   ${FileWriteLine} $R9 "$$CMDLINE: '$CMDLINE'"
   ${FileWriteLine} $R9 "GetParameters(): '$R0'"

   ; Search for '/acceptlicense' option.
   ${CommandLineOptionsSearchBlock} "/acceptlicense" "${IO_ACCEPTLICENSE}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 1
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/add-firewall-exception' option.
   ${CommandLineOptionsSearchBlock} "/add-firewall-exception" "${IO_ADD-FIREWALL-EXCEPTION}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 1
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/backend-collect-timeout' option.
   ${CommandLineOptionsSearchBlock} "/backend-collect-timeout=" "${IO_BACKEND-COLLECT-TIMEOUT}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 < 0
       ${OrIf} $R3 > 600
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/ca-cert-dir' option.
   ${CommandLineOptionsSearchBlock} "/ca-cert-dir=" "${IO_CA-CERT-DIR}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/ca-cert-file' option.
   ${CommandLineOptionsSearchBlock} "/ca-cert-file=" "${IO_CA-CERT-FILE}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/ca-cert-uri' option.
   ${CommandLineOptionsSearchBlock} "/ca-cert-uri=" "${IO_CA-CERT-URI}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/debug' option.
   ${CommandLineOptionsSearchBlock} "/debug" "${IO_DEBUG}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 1
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/delaytime' option.
   ${CommandLineOptionsSearchBlock} "/delaytime=" "${IO_DELAYTIME}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 < 0
       ${OrIf} $R3 > 86400
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/dumphelp' option.
   ${CommandLineOptionsSearchBlock} "/dumphelp" "${IO_DUMPHELP}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 1
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/execmode' option.
   ${CommandLineOptionsSearchBlock} "/execmode=" "${IO_EXECMODE}"
       ; Check $R3 domain
       ${If} "$R3" != "${EXECMODE_SERVICE}"
       ${AndIf} "$R3" != "${EXECMODE_TASK}"
       ${AndIf} "$R3" != "${EXECMODE_MANUAL}"
       ${AndIf} "$R3" != "${EXECMODE_CURRENTCONF}"
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/help' option.
   ${CommandLineOptionsSearchBlock} "/help" "${IO_HELP}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 1
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/html' option.
   ${CommandLineOptionsSearchBlock} "/html" "${IO_HTML}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 1
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/httpd' option.
   ${CommandLineOptionsSearchBlock} "/httpd" "${IO_NO-HTTPD}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 0
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/httpd-ip' option.
   ${CommandLineOptionsSearchBlock} "/httpd-ip=" "${IO_HTTPD-IP}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/httpd-port' option.
   ${CommandLineOptionsSearchBlock} "/httpd-port=" "${IO_HTTPD-PORT}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 < 0
       ${OrIf} $R3 > 65535
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/httpd-trust' option.
   ${CommandLineOptionsSearchBlock} "/httpd-trust=" "${IO_HTTPD-TRUST}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/installdir' option.
   ${CommandLineOptionsSearchBlock} "/installdir=" "${IO_INSTALLDIR}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/installtasks' option.
   ${CommandLineOptionsSearchBlock} "/installtasks=" "${IO_INSTALLTASKS}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/installtype' option.
   ${CommandLineOptionsSearchBlock} "/installtype=" "${IO_INSTALLTYPE}"
       ; Check $R3 domain
       ${If} $R3 != "${INSTALLTYPE_FROMSCRATCH}"
       ${AndIf} $R3 != "${INSTALLTYPE_FROMCURRENTCONFIG}"
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/local' option.
   ${CommandLineOptionsSearchBlock} "/local=" "${IO_LOCAL}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/logfile' option.
   ${CommandLineOptionsSearchBlock} "/logfile=" "${IO_LOGFILE}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/logfile-maxsize' option.
   ${CommandLineOptionsSearchBlock} "/logfile-maxsize=" "${IO_LOGFILE-MAXSIZE}"
       ; Check $R3 domain
       ${If} $R3 < 0
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/logger' option.
   ${CommandLineOptionsSearchBlock} "/logger=" "${IO_LOGGER}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/no-category' option.
   ${CommandLineOptionsSearchBlock} "/no-category=" "${IO_NO-CATEGORY}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/no-debug' option.
   ${CommandLineOptionsSearchBlock} "/no-debug" "${IO_DEBUG}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 0
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/no-html' option.
   ${CommandLineOptionsSearchBlock} "/no-html" "${IO_HTML}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 0
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/no-httpd' option.
   ${CommandLineOptionsSearchBlock} "/no-httpd" "${IO_NO-HTTPD}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 1
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/no-p2p' option.
   ${CommandLineOptionsSearchBlock} "/no-p2p" "${IO_NO-P2P}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 1
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/no-scan-homedirs' option.
   ${CommandLineOptionsSearchBlock} "/no-scan-homedirs" "${IO_SCAN-HOMEDIRS}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 0
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/no-ssl-check' option.
   ${CommandLineOptionsSearchBlock} "/no-ssl-check" "${IO_NO-SSL-CHECK}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 1
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/no-task' option.
   ${CommandLineOptionsSearchBlock} "/no-task=" "${IO_NO-TASK}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/p2p' option.
   ${CommandLineOptionsSearchBlock} "/p2p" "${IO_NO-P2P}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 0
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/password' option.
   ${CommandLineOptionsSearchBlock} "/password=" "${IO_PASSWORD}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/proxy' option.
   ${CommandLineOptionsSearchBlock} "/proxy=" "${IO_PROXY}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/runnow' option.
   ${CommandLineOptionsSearchBlock} "/runnow" "${IO_RUNNOW}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 1
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/scan-homedirs' option.
   ${CommandLineOptionsSearchBlock} "/scan-homedirs" "${IO_SCAN-HOMEDIRS}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 1
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/server' option.
   ${CommandLineOptionsSearchBlock} "/server=" "${IO_SERVER}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/ssl-check' option.
   ${CommandLineOptionsSearchBlock} "/ssl-check" "${IO_NO-SSL-CHECK}"
       ; Check $R3 domain
       ${If} "$R3" != ""
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
          ${Break}
       ${Else}
          ; Override $R3
          StrCpy $R3 0
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/tag' option.
   ${CommandLineOptionsSearchBlock} "/tag=" "${IO_TAG}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 != $R3
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/task-dayly-modifier' option.
   ${CommandLineOptionsSearchBlock} "/task-dayly-modifier=" "${IO_TASK-DAYLY-MODIFIER}"
       ; Check $R3 domain
       ${If} $R3 < 1
       ${OrIf} $R3 > 30
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/task-hourly-modifier' option.
   ${CommandLineOptionsSearchBlock} "/task-hourly-modifier=" "${IO_TASK-HOURLY-MODIFIER}"
       ; Check $R3 domain
       ${If} $R3 < 1
       ${OrIf} $R3 > 23
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/task-frequency' option.
   ${CommandLineOptionsSearchBlock} "/task-frequency=" "${IO_TASK-FREQUENCY}"
       ; Check $R3 domain
       ${If} $R3 != "${FREQUENCY_MINUTE}"
       ${AndIf} $R3 != "${FREQUENCY_HOURLY}"
       ${AndIf} $R3 != "${FREQUENCY_DAYLY}"
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/task-minute-modifier' option.
   ${CommandLineOptionsSearchBlock} "/task-minute-modifier=" "${IO_TASK-MINUTE-MODIFIER}"
       ; Check $R3 domain
       ${If} $R3 <> 15
       ${AndIf} $R3 <> 20
       ${AndIf} $R3 <> 30
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/timeout' option.
   ${CommandLineOptionsSearchBlock} "/timeout=" "${IO_TIMEOUT}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 < 0
       ${OrIf} $R3 > 600
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/user' option.
   ${CommandLineOptionsSearchBlock} "/user=" "${IO_USER}"
      ; Check $R3 domain
      ; ToDo
      ${If} $R3 != $R3
         ; Syntax error.
         SetErrors
         StrCpy $R7 1
         ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
         ${Break}
      ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/wait' option.
   ${CommandLineOptionsSearchBlock} "/wait=" "${IO_WAIT}"
       ; Check $R3 domain
       ; ToDo
       ${If} $R3 < 0
       ${OrIf} $R3 > 86400
          ; Syntax error.
          SetErrors
          StrCpy $R7 1
          ${FileWriteLine} $R9 "Syntax error. The value '$R3' is not allowed."
          ${Break}
       ${EndIf}
   ${EndCommandLineOptionsSearchBlock}

   ; Search for '/S' option.
   ${CommandLineOptionsSearchBlock} "/S" "${IO_SILENTMODE}"
               ; Check $R3 domain
               ${If} "$R3" != ""
                  ; Syntax error.
                  SetErrors
                  StrCpy $R7 1
                  ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
                  ${Break}
               ${Else}
                  ; Override $R3
                  StrCpy $R3 1
               ${EndIf}

               ; Like ${EndCommandLineOptionsSearchBlock} but not exactly.

               ; Write "$R4=$R3" into the section $R8 of the file Options.ini
               ${WriteINIOption} "$R8" "$R4" "$R3"

               ${FileWriteLine} $R9 "'$R4=$R3' written into the section [$R8] of the file '$PLUGINSDIR\Options.ini'"
            ${Else}
               ; It's the nth occurrence of $R2 into the command line
               ; It's allowed in this case.
               Nop
            ${EndIf}

            ${If} "$R0" == ""
               ${Break}
            ${EndIf}
         ${Else}
            ${FileWriteLine} $R9 "...'$R2' not found."
            ${Break}
         ${EndIf}
      ${Loop}
   ${EndIf}

   ; Search for '/NCRC' option.
   ${If} $R7 = 0
   ${AndIf} $R0 != ""
      ${Do}
         ${FileWriteLine} $R9 "--------------------"

         StrCpy $R2 "/NCRC"
         StrCpy $R3 ""
         StrCpy $R4 ""

         ${FileWriteLine} $R9 "Searching for '$R2'..."
         ${GetOptionsS} "$R0" "$R2" $R3
         ${FileWriteLine} $R9 "GetOptionsS('$R0', '$R2'): '$R3'"

         ${IfNot} ${Errors}
            ${FileWriteLine} $R9 "...'$R2' found!"

            ; Remove the first occurrence of $R2$R3 from $R0
            ${WordReplace} "$R0" "$R2$R3" "" "+1" $R1
            ${If} "$R0" == "$R1"
               ${WordReplace} "$R0" "$R2$\'$R3$\'" "" "+1" $R1
               ${If} "$R0" == "$R1"
                  ${WordReplace} "$R0" "$R2$\"$R3$\""  "" "+1" $R1
                  ${If} "$R0" == "$R1"
                     ${WordReplace} "$R0" "$R2$\`$R3$\`"  "" "+1" $R1
                  ${EndIf}
               ${EndIf}
            ${EndIf}
            ${Trim} $R0 "$R1"

            ${FileWriteLine} $R9 "New parameters (without '$R2[|$\'|$\"|$\`]$R3[$\`|$\"|$\'|]'): '$R0'"

            ; Check $R3 domain
            ${If} "$R3" != ""
               ; Syntax error.
               SetErrors
               StrCpy $R7 1
               ${FileWriteLine} $R9 "Syntax error. '$R2' is a switch, it has no values."
               ${Break}
            ${EndIf}

            ${If} "$R0" == ""
               ${Break}
            ${EndIf}
         ${Else}
            ${FileWriteLine} $R9 "...'$R2' not found."
            ${Break}
         ${EndIf}
      ${Loop}
   ${EndIf}

   ${FileWriteLine} $R9 "--------------------"
   ${FileWriteLine} $R9 "End of command line parser"

   ; Trim
   ${TrimLeft} $R1 "$R0"
   ${TrimRight} $R0 "$R1"

   ${If} $R7 == 0
      ${If} "$R0" != ""
         ; Syntax error. Invalid options.
         SetErrors
         ${FileWriteLine} $R9 "Syntax error. Invalid options '$R0'."
      ${Else}
         ${FileWriteLine} $R9 "Syntax OK. All options have been recognized."
      ${EndIf}
   ${Else}
         ; Syntax Error.
         ${FileWriteLine} $R9 "Syntax error. For more information see above."
   ${EndIf}

   ; Close the command line parser logfile
   FileClose $R9

   ; Pop $R9, $R8, $R7, $R5, $R4, $R3, $R2, $R1 & $R0 off of the stack
   Pop $R9
   Pop $R8
   Pop $R7
   Pop $R5
   Pop $R4
   Pop $R3
   Pop $R2
   Pop $R1
   Pop $R0
FunctionEnd


!endif
