# Guide for Lubuntu Install
License: CC0-1.0 https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt  
Version: 24.04.00
## Startup
* Limit CPU Speed  
    `for x in /sys/devices/system/cpu/*/cpufreq/; do echo 1700000 | sudo tee $x/scaling_max_freq; done`
* Additional Return-Key for German Keyboards  
    `sudo xmodmap -e "keycode 51 = Return"`  
    Note: `xev` for info

## Packages
Minimum:  
`idle geany synaptic net-tools audacious mtpaint gnome-disk-utility xournalpp pdfarranger`

Notes:

* `idle` installs Python3
* pdfarranger is successor of pdfshuffler
* Other Python packages: `python-numpy python-scipy`

### Firefox
#### Firefox ESR (optional)
```
sudo add-apt-repository ppa:mozillateam/ppa
sudo apt-get update
sudo apt remove firefox
sudo snap remove firefox
sudo apt install firefox-esr
```

#### Extensions (optional)
* uBlock Origin

### Documentation Tools
* Graphviz/graphviz-dot
    * For flow charts
    * `sudo apt install graphviz`
* Doxygen
    * Generates documentation from source code comments
    * Requires Graphviz
    * <https://www.doxygen.nl/index.html>
    * `sudo apt install doxygen`
* PlantUML
    * UML-based (text input, based on graphviz-dot)
    * For various diagram types like state diagrams, timing diagrams
    * <https://plantuml.com>
    * `sudo apt install plantuml`
* yEd Editor
    * Graphical tool
    * For System diagrams
    * <https://www.yworks.com/products/yed/download> (Windows, Linux, Mac)
* WaveDrom
    * JSON-based
    * For timing diagrams
    * <https://wavedrom.com/tutorial.html>
    * <https://github.com/wavedrom/wavedrom.github.io/releases> (Windows, Linux, Mac)    

### Office Tools
* Libre Office (Windows, Linux, Mac)
    * Graphical Office Suite
    * For documents, spreadsheets, presentation, draw
* Latex
    * Typesetting program, text-based
    * <https://miktex.org/download> (Windows, Linux, Mac)
    * <https://www.tug.org/texlive> (sudo apt install ...)
* Lyx
    * Similar to Latex, but WYSIWYG
    * <https://www.lyx.org> (Windows, Linux)
    * `sudo apt install lyx`
* Xournal++
    * For annotating PDFs
    * <https://xournalpp.github.io/> (Windows, Linux, Mac)
    * `sudo apt install xournalpp`

### Multimedia
* Graphics
    * `sudo apt install mtpaint` (Basic paint program similar to MS paint)
    * `sudo apt install gscan2pdf` (Scan device to PDF file)
        * `tesseract-ocr-...` (OCR engine, optional)
* Audio
    * `sudo apt install audacious` (Audio player)
    * `sudo apt install audacity` (Audio editor)
* Video
    * `sudo apt install vlc` (VLC media player)

### System
* `sudo apt install htop` (Process manager for terminal with mouse support)
* `sudo apt install gnome-disk-utility` (Manager for partitions and disk images)
* `sudo apt install gsmartcontrol` (SMART: For disc health, disc tests) 
* `sudo apt install gtkterm` (Terminal program)
* `sudo apt install synaptic` (Package Manager)

### Code Editor Tools
* Geany
    * `sudo apt install geany`
    * <https://www.geany.org/download/releases> (Windows)
* Emacs
    * sudo apt install emacs
    * <https://www.gnu.org/software/emacs/download.html> (Windows)
    * Emacs VHDL mode
        * <https://iis-people.ee.ethz.ch/~zimmi/emacs/vhdl-mode.html>
        * See installation instructions
        * Ubuntu 24.04 global site-lisp location: /usr/local/share/emacs/site-lisp
        * Includes VHDL beautifier


### MyPhoneExplorer
```
sudo apt install wine winetricks
winetricks vb6run
winetricks msxml3
```

* MyPhoneExplorer <https://www.fjsoft.at>
    * Tested version: MyPhoneExplorer_Setup_2.3
    * Tested version: MyPhoneExplorer_Setup_1.8.7
    * Select portable installation, install path: C:\Program Files\MyPhoneExplorer portable
* Notes
    * WiFI only, no USB, no Bluetooth
    * msxml3 or msxml4 or msxml6 (less warnings with 6 than with 4)
    * No advantage with playonlinux python3-pyasyncore
    
### Download for Later Install
* Location: /var/cache/apt/archives
* For Download
    * `sudo apt clean`
    * `sudo apt install -d PackageName`
* Store Packages
* For Install
    * `sudo dpkg -i *`

## Desktop Settings
* Session Settings
    * Autostart -> Disable picom, Qlipper
    * Autostart -> Add as needed
* Power Management Settings
    * Set "When power is low then"
    * Set "Lid"/"Action when lid is closed"
* Optional desktop background: 22,26,75 (HTML: #161a4b)
* Optional panal background: 176,176,176 (HTML: #b0b0b0)
* Fonts
    * DejaVu
    * Size on 15" HD for DejaVu Sans Mono: 10 (Terminal, Text Editors, ...)
    * Size on 15" FHD for DejaVu Sans Mono: 14 (Terminal, Text Editors, ...)  
* LXQT Apperance Configuration
    * Widget Style -> QT Style Breeze
    * Icons Theme -> Humanity (Smooth modern theme)
    * LXQT Theme -> Light
    * Font -> DejaVu Sans, Font hinting Full, Autohint
* Openbox
    * Theme -> Clearlooks-3.4
    * Apperance -> Animate iconify and restore (to DISABLED)
    * Mouse -> Double click time (300 or 400)
    * Desktops -> only 1
* Configure Panel
    * Placement -> Size: 150px (For 15" FHD)
    * Placement -> Rows: 4 (For 15" FHD)
    * Placement -> Position: Right of desktop (For 15" FHD)
    * Styling -> Background color: 176,176,176 (HTML: #b0b0b0) (Optional)
    * Widgets -> Remove elements as needed
    * Widgets -> Clock: Time: Custom, Show seconds, pad hour wih zero
    * Widgets -> Clock: Date: Below, Custom, Show year

### Tiling Windows
Steps:

1. In "Shortcut Keys"/"Global Actions Manager"
    * Change "Show/hide main menu" (panel) from "Super_L" to "Meta+Space" or "CTRL+ESC"
    * Background: "Super_L"/"W" single key-press needs to be freed to be available in keybind file
2. Add to .config/openbox/rc.xml:

```
    <!-- Keybindings for window tiling -->
    <keybind key="W-Left">			# Left Half
      <action name="UnmaximizeFull"/>
      <action name="MoveResizeTo"><x>0</x><y>0</y><height>100%</height><width>50%</width></action>
    </keybind>
    <keybind key="W-Right">			# Right Half
      <action name="UnmaximizeFull"/>
      <action name="MoveResizeTo"><x>-0</x><y>0</y><height>100%</height><width>50%</width></action>
    </keybind>
    <keybind key="W-Up">			# Top Half
      <action name="UnmaximizeFull"/>
      <action name="MoveResizeTo"><x>0</x><y>0</y><height>50%</height><width>100%</width></action>
    </keybind>
    <keybind key="W-Down">			# Bottom Half
      <action name="UnmaximizeFull"/>
      <action name="MoveResizeTo"><x>0</x><y>-0</y><height>50%</height><width>100%</width></action>
    </keybind>
  </keyboard>
```

### DPI Change
* Via .Xresources
* 16" at 2560x1600: `Xft.dpi: 170`
* Note: For Xorg, settings are the same for all monitors; only pixel scaling for differentiation of DPI

### Gamma correction
* `xgamma -bgamma 1.2` (as needed)

## SwapFile
### Size Increase
```
sudo swapoff --all  
sudo dd if=/dev/zero of=/swapfile bs=1G count=16  
sudo chmod 0600 /swapfile  
sudo mkswap /swapfile  
sudo swapon /swapfile
```
