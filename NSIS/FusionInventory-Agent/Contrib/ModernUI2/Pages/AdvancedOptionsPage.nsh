/*
   ------------------------------------------------------------------------
   FusionInventory Agent Installer for Microsoft Windows
   Copyright (C) 2010-2013 by the FusionInventory Development Team.

   http://www.fusioninventory.org/ http://forge.fusioninventory.org/
   ------------------------------------------------------------------------

   LICENSE

   This file is part of FusionInventory project.

   FusionInventory Agent Installer for Microsoft Windows is free software;
   you can redistribute it and/or modify it under the terms of the GNU
   General Public License as published by the Free Software Foundation;
   either version 2 of the License, or (at your option) any later version.


   FusionInventory Agent Installer for Microsoft Windows is distributed in
   the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
   the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
   PURPOSE. See the GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software Foundation,
   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA,
   or see <http://www.gnu.org/licenses/>.

   ------------------------------------------------------------------------

   @package   FusionInventory Agent Installer for Microsoft Windows
   @file      .\FusionInventory Agent\Contrib\ModernUI2\Pages\AdvancedOptionsPage.nsh
   @author    Tomas Abad <tabadgp@gmail.com>
   @copyright Copyright (c) 2010-2013 FusionInventory Team
   @license   GNU GPL version 2 or (at your option) any later version
              http://www.gnu.org/licenses/old-licenses/gpl-2.0-standalone.html
   @link      http://www.fusioninventory.org/
   @link      http://forge.fusioninventory.org/projects/fusioninventory-agent
   @since     2012

   ------------------------------------------------------------------------
*/

/*
   ------------------------------------------------------------------------
   This file was generated with the help of NSISDialogDesigner 1.1.2.0
   http://coolsoft.altervista.org/nsisdialogdesigner
   ------------------------------------------------------------------------
*/


!include LogicLib.nsh
!include "${FIAI_DIR}\Include\INIFunc.nsh"
!include "${FIAI_DIR}\Contrib\ModernUI2\Pages\AdvancedOptionsPageLangStrings.nsh"


;--------------------------------
; Handle variables

Var hCtl_AdvancedOptionsPage
Var hCtl_AdvancedOptionsPage_Label1
Var hCtl_AdvancedOptionsPage_GroupBox1
Var hCtl_AdvancedOptionsPage_Label2
Var hCtl_AdvancedOptionsPage_Number1
Var hCtl_AdvancedOptionsPage_Label3
Var hCtl_AdvancedOptionsPage_Number2
Var hCtl_AdvancedOptionsPage_Label4
Var hCtl_AdvancedOptionsPage_Number3
Var hCtl_AdvancedOptionsPage_Label5
Var hCtl_AdvancedOptionsPage_Number4
Var hCtl_AdvancedOptionsPage_GroupBox2
Var hCtl_AdvancedOptionsPage_CheckBox1
Var hCtl_AdvancedOptionsPage_Label6
Var hCtl_AdvancedOptionsPage_TextBox1
Var hCtl_AdvancedOptionsPage_Label7
Var hCtl_AdvancedOptionsPage_Label8
Var hCtl_AdvancedOptionsPage_TextBox2
Var hCtl_AdvancedOptionsPage_Label9



;--------------------------------
; Advanced Options Page Functions

Function AdvancedOptionsPage_Back
   Call AdvancedOptionsPage_Leave
FunctionEnd


Function AdvancedOptionsPage_Create
   ; === AdvancedOptionsPage (type: Dialog) ===
   nsDialogs::Create 1018
   Pop $hCtl_AdvancedOptionsPage
   ${If} $hCtl_AdvancedOptionsPage == error
     Abort
   ${EndIf}
   !insertmacro MUI_HEADER_TEXT "$(hCtl_AdvancedOptionsPage_Text)" "$(hCtl_AdvancedOptionsPage_SubText)"

   ; === Label1 (type: Label) ===
   ${NSD_CreateLabel} 0u 0u 294u 18u "$(hCtl_AdvancedOptionsPage_Label1_Text)"
   Pop $hCtl_AdvancedOptionsPage_Label1

   ; === GroupBox1 (type: GroupBox) ===
   ${NSD_CreateGroupBox} 0u 21u 144u 108u "$(hCtl_AdvancedOptionsPage_GroupBox1_Text)"
   Pop $hCtl_AdvancedOptionsPage_GroupBox1

   ; === Label2 (type: Label) ===
   ${NSD_CreateLabel} 11u 34u 123u 8u "$(hCtl_AdvancedOptionsPage_Label2_Text)"
   Pop $hCtl_AdvancedOptionsPage_Label2
   ${NSD_AddStyle} $hCtl_AdvancedOptionsPage_Label2 ${SS_CENTER}

   ; === Number1 (type: Number) ===
   ${NSD_CreateNumber} 47u 43u 53u 11u ""
   Pop $hCtl_AdvancedOptionsPage_Number1
   ${NSD_AddStyle} $hCtl_AdvancedOptionsPage_Number1 ${SS_CENTER}
   ${NSD_SetTextLimit} $hCtl_AdvancedOptionsPage_Number1 "4"

   ; === Label3 (type: Label) ===
   ${NSD_CreateLabel} 11u 57u 123u 8u "$(hCtl_AdvancedOptionsPage_Label3_Text)"
   Pop $hCtl_AdvancedOptionsPage_Label3
   ${NSD_AddStyle} $hCtl_AdvancedOptionsPage_Label3 ${SS_CENTER}

   ; === Number2 (type: Number) ===
   ${NSD_CreateNumber} 47u 66u 53u 11u ""
   Pop $hCtl_AdvancedOptionsPage_Number2
   ${NSD_AddStyle} $hCtl_AdvancedOptionsPage_Number2 ${SS_CENTER}
   ${NSD_SetTextLimit} $hCtl_AdvancedOptionsPage_Number2 "4"

   ; === Label4 (type: Label) ===
   ${NSD_CreateLabel} 11u 79u 123u 8u "$(hCtl_AdvancedOptionsPage_Label4_Text)"
   Pop $hCtl_AdvancedOptionsPage_Label4
   ${NSD_AddStyle} $hCtl_AdvancedOptionsPage_Label4 ${SS_CENTER}

   ; === Number3 (type: Number) ===
   ${NSD_CreateNumber} 47u 88u 53u 11u ""
   Pop $hCtl_AdvancedOptionsPage_Number3
   ${NSD_AddStyle} $hCtl_AdvancedOptionsPage_Number3 ${SS_CENTER}
   ${NSD_SetTextLimit} $hCtl_AdvancedOptionsPage_Number3 "4"

   ; === Label5 (type: Label) ===
   ${NSD_CreateLabel} 11u 102u 123u 8u "$(hCtl_AdvancedOptionsPage_Label5_Text)"
   Pop $hCtl_AdvancedOptionsPage_Label5
   ${NSD_AddStyle} $hCtl_AdvancedOptionsPage_Label5 ${SS_CENTER}

   ; === Number4 (type: Number) ===
   ${NSD_CreateNumber} 47u 111u 53u 11u ""
   Pop $hCtl_AdvancedOptionsPage_Number4
   ${NSD_AddStyle} $hCtl_AdvancedOptionsPage_Number4 ${SS_CENTER}
   ${NSD_SetTextLimit} $hCtl_AdvancedOptionsPage_Number4 "4"

   ; === GroupBox2 (type: GroupBox) ===
   ${NSD_CreateGroupBox} 155u 20u 142u 108u "$(hCtl_AdvancedOptionsPage_GroupBox2_Text)"
   Pop $hCtl_AdvancedOptionsPage_GroupBox2

   ; === CheckBox1 (type: Checkbox) ===
   ${NSD_CreateCheckbox} 165u 38u 121u 11u "$(hCtl_AdvancedOptionsPage_CheckBox1_Text)"
   Pop $hCtl_AdvancedOptionsPage_CheckBox1

   ; === Label6 (type: Label) ===
   ${NSD_CreateLabel} 168u 56u 118u 8u "$(hCtl_AdvancedOptionsPage_Label6_Text)"
   Pop $hCtl_AdvancedOptionsPage_Label6

   ; === TextBox1 (type: Text) ===
   ${NSD_CreateText} 165u 65u 121u 11u ""
   Pop $hCtl_AdvancedOptionsPage_TextBox1

   ; === Label7 (type: Label) ===
   ${NSD_CreateLabel} 165u 77u 121u 8u "$(hCtl_AdvancedOptionsPage_Label7_Text)"
   Pop $hCtl_AdvancedOptionsPage_Label7
   ${NSD_AddStyle} $hCtl_AdvancedOptionsPage_Label7 ${SS_CENTER}

   ; === Label8 (type: Label) ===
   ${NSD_CreateLabel} 168u 90u 118u 8u "$(hCtl_AdvancedOptionsPage_Label8_Text)"
   Pop $hCtl_AdvancedOptionsPage_Label8

   ; === TextBox2 (type: Text) ===
   ${NSD_CreateText} 165u 99u 121u 11u ""
   Pop $hCtl_AdvancedOptionsPage_TextBox2

   ; === Label9 (type: Label) ===
   ${NSD_CreateLabel} 165u 111u 121u 8u "$(hCtl_AdvancedOptionsPage_Label9_Text)"
   Pop $hCtl_AdvancedOptionsPage_Label9
   ${NSD_AddStyle} $hCtl_AdvancedOptionsPage_Label9 ${SS_CENTER}

   ; OnBack Function
   ${NSD_OnBack} AdvancedOptionsPage_Back

   ; Push $R0 & $R1 onto the stack
   Push $R0
   Push $R1

   ; Set default section
   StrCpy $R0 "${IOS_GUI}"

   ; Set Number1 Text
   ${ReadINIOption} $R1 "$R0" "${IO_TIMEOUT}"
   ${NSD_SetText} $hCtl_AdvancedOptionsPage_Number1 "$R1"

   ; Set Number2 Text
   ${ReadINIOption} $R1 "$R0" "${IO_WAIT}"
   ${NSD_SetText} $hCtl_AdvancedOptionsPage_Number2 "$R1"

   ; Set Number3 Text
   ${ReadINIOption} $R1 "$R0" "${IO_DELAYTIME}"
   ${NSD_SetText} $hCtl_AdvancedOptionsPage_Number3 "$R1"

   ; Set Number4 Text
   ${ReadINIOption} $R1 "$R0" "${IO_BACKEND-COLLECT-TIMEOUT}"
   ${NSD_SetText} $hCtl_AdvancedOptionsPage_Number4 "$R1"

   ; Set CheckBox1 Check
   ${ReadINIOption} $R1 "$R0" "${IO_NO-P2P}"
   ${If} "$R1" == "0"
      ${NSD_Uncheck} $hCtl_AdvancedOptionsPage_CheckBox1
   ${Else}
      ${NSD_Check} $hCtl_AdvancedOptionsPage_CheckBox1
   ${EndIf}

   ; Set TextBox1 Text
   ${ReadINIOption} $R1 "$R0" "${IO_NO-TASK}"
   ${NSD_SetText} $hCtl_AdvancedOptionsPage_TextBox1 "$R1"

   ; Set TextBox2 Text
   ${ReadINIOption} $R1 "$R0" "${IO_NO-CATEGORY}"
   ${NSD_SetText} $hCtl_AdvancedOptionsPage_TextBox2 "$R1"

   ; Pop $R1 & $R0 off of the stack
   Pop $R1
   Pop $R0
FunctionEnd


Function AdvancedOptionsPage_Leave
   ; Push $R0 & $R1 onto the stack
   Push $R0
   Push $R1

   ; Set default section
   StrCpy $R0 "${IOS_GUI}"

   ; Save Number1 Text
   ${NSD_GetText} $hCtl_AdvancedOptionsPage_Number1 $R1
   ${WriteINIOption} "$R0" "${IO_TIMEOUT}" "$R1"

   ; Save Number2 Text
   ${NSD_GetText} $hCtl_AdvancedOptionsPage_Number2 $R1
   ${WriteINIOption} "$R0" "${IO_WAIT}" "$R1"

   ; Save Number3 Text
   ${NSD_GetText} $hCtl_AdvancedOptionsPage_Number3 $R1
   ${WriteINIOption} "$R0" "${IO_DELAYTIME}" "$R1"

   ; Save Number4 Text
   ${NSD_GetText} $hCtl_AdvancedOptionsPage_Number4 $R1
   ${WriteINIOption} "$R0" "${IO_BACKEND-COLLECT-TIMEOUT}" "$R1"

   ; Save CheckBox1 Check
   ${NSD_GetState} $hCtl_AdvancedOptionsPage_CheckBox1 $R1
   ${If} $R1 = ${BST_CHECKED}
      ${WriteINIOption} "$R0" "${IO_NO-P2P}" "1"
   ${Else}
      ${WriteINIOption} "$R0" "${IO_NO-P2P}" "0"
   ${EndIf}

   ; Save TextBox1 Text
   ${NSD_GetText} $hCtl_AdvancedOptionsPage_TextBox1 $R1
   ${WriteINIOption} "$R0" "${IO_NO-TASK}" "$R1"

   ; Save TextBox2 Text
   ${NSD_GetText} $hCtl_AdvancedOptionsPage_TextBox2 $R1
   ${WriteINIOption} "$R0" "${IO_NO-CATEGORY}" "$R1"

   ; Pop $R1 & $R0 off of the stack
   Pop $R1
   Pop $R0
FunctionEnd


Function AdvancedOptionsPage_Show
   Call AdvancedOptionsPage_Create
   nsDialogs::Show $hCtl_AdvancedOptionsPage
FunctionEnd