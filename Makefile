##########################################################################################################################
# File automatically-generated by tool: [projectgenerator] version: [3.16.0] date: [Sat Apr 09 15:13:02 CEST 2022] 
##########################################################################################################################
# File edited by Pararera. Most settings are on the top of this file. Adjusted for CPP files and JLink.
##########################################################################################################################

# ------------------------------------------------
# Generic Makefile (based on gcc)
#
# ChangeLog :
#	2017-02-10 - Several enhancements + project update mode
#   2015-07-22 - first version
# ------------------------------------------------

######################################
# settings
######################################
# CPU CORE
CPU = -mcpu=cortex-m3

# CHIP TYPE
CHIP = STM32F103CB

# START ADDRESS FOR .bin FILE
ADDR = 0x08000000

# LD SCRIPT FILE
LDSCRIPT = STM32F103CBTx_FLASH.ld


# OUTPUT NAME
TARGET = _Makefile_Template

# OUTPUT LOCATION
BUILD_DIR = .build

# RELEASE BUILD
RELEASE = 1

# LAST LINE OF DEFENCE IN CASE OF ROM SHORTAGE
FLTO = 0

# JLINK SCRIPTS
FLASH_SCRIPT = JLink_Flash.jlink
ERASE_SCRIPT = JLink_Erase.jlink

######################################
# source
######################################
# C sources
C_SOURCES =  \
Core/Src/main.c \
Core/Src/gpio.c \
Core/Src/iwdg.c \
Core/Src/usart.c \
Core/Src/stm32f1xx_it.c \
Core/Src/stm32f1xx_hal_msp.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio_ex.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_iwdg.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_rcc_ex.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_gpio.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_dma.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_cortex.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_pwr.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_flash_ex.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_exti.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_tim_ex.c \
Drivers/STM32F1xx_HAL_Driver/Src/stm32f1xx_hal_uart.c \
Core/Src/system_stm32f1xx.c

# CPP sources
CPP_SOURCES =  \

# ASM sources
ASM_SOURCES =  \
startup_stm32f103xb.s


# AS includes
AS_INCLUDES =  \

# C includes
C_INCLUDES =  \
-ICore/Inc \
-IDrivers/STM32F1xx_HAL_Driver/Inc \
-IDrivers/STM32F1xx_HAL_Driver/Inc/Legacy \
-IDrivers/CMSIS/Device/ST/STM32F1xx/Include \
-IDrivers/CMSIS/Include


# AS defines
AS_DEFS =  \

# C defines
# *** CHANGE ***
C_DEFS +=  \
-DSTM32F103xB \
-DUSE_HAL_DRIVER

ifeq ($(RELEASE), 0)
C_DEFS += -DDEBUG
endif

ifeq ($(RELEASE), 1)
# DEBUG OPT
OPT = -Og
else
# SPEED OPT
OPT = -Os
endif


#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-
# *** CUSTOM *** GCC CHANGED TO G++
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)g++
AS = $(GCC_PATH)/$(PREFIX)g++ -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)g++
AS = $(PREFIX)g++ -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S
 
#######################################
# CFLAGS
#######################################
# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

# compile gcc flags
ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

# *** CUSTOM *** ADDED "-Wdouble-promotion"
CFLAGS = $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections -Wdouble-promotion

# *** CUSTOM ***
ifeq ($(RELEASE), 0)
CFLAGS += -g -gdwarf-2
else
ifeq ($(FLTO), 1)
CFLAGS += -flto
ASFLAGS += -flto
endif
endif

# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"

#######################################
# LDFLAGS
#######################################
# libraries
# *** CUSTOM  ADDED "-specs=nosys.specs -u_printf_float" AND "-print-memory-usage" AFTER "-Wl," ***
LIBS = -lc -lm -lnosys 
LIBDIR = 
LDFLAGS = $(MCU) -specs=nano.specs -specs=nosys.specs -u_printf_float -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,-print-memory-usage,--gc-sections

# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin


#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))

# *** CUSTOM FOR CPP ***
OBJECTS_CPP = $(addprefix $(BUILD_DIR)/,$(notdir $(CPP_SOURCES:.cpp=.o)))
vpath %.cpp $(sort $(dir $(CPP_SOURCES)))

# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

# *** CUSTOM FOR CPP ***
$(BUILD_DIR)/%.o: %.cpp Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.cpp=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) $(OBJECTS_CPP) Makefile
	$(CC) $(OBJECTS) $(OBJECTS_CPP) $(LDFLAGS) -o $@
	$(CC) --version
#$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@	
	
$(BUILD_DIR):
	mkdir $@



#######################################
# FLASH CHIP
#######################################
flash: all
	if not exist $(FLASH_SCRIPT) (echo Creating flash script & (echo r& echo h& echo loadbin $(BUILD_DIR)/$(TARGET).bin,$(ADDR)& echo verifybin $(BUILD_DIR)/$(TARGET).bin,$(ADDR)& echo r& echo q) > $(FLASH_SCRIPT)) else (echo Flash script exists) 
	JLink.exe -device $(CHIP) -if SWD -speed 4000 -autoconnect 1 -CommandFile $(FLASH_SCRIPT)
	
#######################################
# ERASE CHIP FLASH MEMORY
#######################################		
erase:
	if not exist $(ERASE_SCRIPT) (echo Creating erase script & (echo r& echo h& echo erase& echo r& echo q) > $(ERASE_SCRIPT)) else (echo Erase script exists)
	JLink.exe -device $(CHIP) -if SWD -speed 4000 -autoconnect 1 -CommandFile $(ERASE_SCRIPT)
	

#######################################
# REMOVE BUILD FOLDER & OTHER STUFF
#######################################
clean:
	if exist $(BUILD_DIR) (echo Deleting build directory & rmdir /s /q $(BUILD_DIR))
	if exist $(FLASH_SCRIPT) (echo Deleting flash script & del $(FLASH_SCRIPT))
	if exist $(ERASE_SCRIPT) (echo Deleting erase script & del $(ERASE_SCRIPT))
  
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)
