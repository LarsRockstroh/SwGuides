##---------------------------------------------------------------------------------
## License: CC0-1.0 https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt
## Repository: https://github.com/LarsRockstroh/SwGuides/
## Filename: Makefile
## Language: Makefile
## Description: Makefile for simiulation
## History:
## 01.00, 2026-02-28
##   Initial
##----------------------------------------------------------------------------------

GHDL=$$HOME/tools/GHDL/ghdl-mcode-5.1.1-ubuntu24.04-x86_64/bin/ghdl 
GHDLFLAGS= --std=08
#MODULES= $(shell tr '\n' ' ' < Design_Files.txt)
#MODULES= #MODULES $(shell tr '\n' ' ' < TB_Files.txt)
MODULES=\
../Design/WaveGen4Bit_top_VarA.vhd \
../TB/tb_WaveGen4Bit_top_VarA.vhd 

TOPLEVEL= tb_WaveGen4Bit_top_VarA

simulation: $(MODULES)
	$(GHDL) -i $(GHDLFLAGS) $(MODULES)
	$(GHDL) -m $(GHDLFLAGS) $(TOPLEVEL)
	$(GHDL) -r --coverage $(GHDLFLAGS) $(TOPLEVEL) --vcd=$(TOPLEVEL).vcd

coverage: $(shell find . -name '*.json')
	$(GHDL) coverage --format=lcov $^ > lcov.info
	./Fix_lcov.py
	genhtml --flat -no-function-coverage -o html lcov.info

clean:
	$(RM) *.vcd *.cf *.info *.json
	$(RM) -r html
