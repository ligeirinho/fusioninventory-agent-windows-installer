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

   @package    FusionInventory Agent Installer for Microsoft Windows
   @file       .\FusionInventory Agent\Contrib\ModernUI2\Pages\InstallationTypePageLangStrings.nsh
   @author     Tomas Abad <tabadgp@gmail.com>
   @translator Emmanuel Le Normand <manu@le-normand.org> (French Translation)
   @copyright  Copyright (c) 2010-2013 FusionInventory Team
   @license    GNU GPL version 2 or (at your option) any later version
               http://www.gnu.org/licenses/old-licenses/gpl-2.0-standalone.html
   @link       http://www.fusioninventory.org/
   @link       http://forge.fusioninventory.org/projects/fusioninventory-agent
   @since      2012

   ------------------------------------------------------------------------
*/


!ifndef __FIAI_INSTALLMODEPAGE_LANGSTRINGS_INCLUDE__
!define __FIAI_INSTALLMODEPAGE_LANGSTRINGS_INCLUDE__


;--------------------------------
; LangString Variables

; InstallationTypePage_Text
LangString InstallationTypePage_Text ${LANG_ENGLISH} "Choose an Installation Type"
LangString InstallationTypePage_Text ${LANG_FRENCH} "Choisissez le Type d'Installation"
LangString InstallationTypePage_Text ${LANG_SPANISH} "Elija un tipo de instalaci�n"

; InstallationTypePage_SubText
LangString InstallationTypePage_SubText ${LANG_ENGLISH} "Choose how you want to install ${PRODUCT_NAME}."
LangString InstallationTypePage_SubText ${LANG_FRENCH} "Choisissez o� vous d�sirez installer ${PRODUCT_NAME}."
LangString InstallationTypePage_SubText ${LANG_SPANISH} "Elija c�mo quiere instalar ${PRODUCT_NAME}."

; InstallationTypePage_Label1_Text
LangString InstallationTypePage_Label1_Text ${LANG_ENGLISH} "You have FusionInventory Agent $R0 ($R1 edition) already installed in your computer. In your case, you have two different types of installation to install this new version.$\r$\n$\r$\nYou should decide whether you want to:"
LangString InstallationTypePage_Label1_Text ${LANG_FRENCH} "Vous avez l'Agent FusionInventory $R0 ($R1 �dition) d�j� d'install� sur votre machine. Dans ce cas, vous avez deux types d'installation possible pour installer cette nouvelle version.$\r$\n$\r$\nVous devez choisir si vous voulez :"
LangString InstallationTypePage_Label1_Text ${LANG_SPANISH} "Usted ya tiene FusionInventory Agent $R0 ($R1 edition) instalado en su computador. En su caso, usted dispone de dos diferentes tipos de instalaci�n para instalar esta nueva versi�n.$\r$\n$\r$\nUsted deber�a decidir si quiere:"

; InstallationTypePage_RadioButton1
LangString InstallationTypePage_RadioButton1_Text ${LANG_ENGLISH} "Install from scratch"
LangString InstallationTypePage_RadioButton1_Text ${LANG_FRENCH} "Installer � partir de z�ro"
LangString InstallationTypePage_RadioButton1_Text ${LANG_SPANISH} "Instalar desde cero"

; InstallationTypePage_Label2
LangString InstallationTypePage_Label2_Text ${LANG_ENGLISH} "The new FusionInventory Agent will be installed using options values based on its default values."
LangString InstallationTypePage_Label2_Text ${LANG_FRENCH} "Le nouvel Agent FusionInventory sera install� avec les options param�tr�es par d�faut."
LangString InstallationTypePage_Label2_Text ${LANG_SPANISH} "El nuevo FusionInventory Agent ser� instalado usando valores de opciones basados en sus valores por defecto."

; InstallationTypePage_RadioButton2
LangString InstallationTypePage_RadioButton2_Text ${LANG_ENGLISH} "Install from current configuration"
LangString InstallationTypePage_RadioButton2_Text ${LANG_FRENCH} "Installer avec la configuration actuelle"
LangString InstallationTypePage_RadioButton2_Text ${LANG_SPANISH} "Instalar desde la configuraci�n actual"

; InstallationTypePage_Label3
LangString InstallationTypePage_Label3_Text ${LANG_ENGLISH} "The new FusionInventory Agent will be installed using options values based on its current values."
LangString InstallationTypePage_Label3_Text ${LANG_FRENCH} "Le nouvel Agent FusionInventory sera install� avec les options param�tr�es selon la configuration actuelle."
LangString InstallationTypePage_Label3_Text ${LANG_SPANISH} "El nuevo FusionInventory Agent ser� instalado usando valores de opciones basados en sus valores actuales."


!endif
