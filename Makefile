# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jopedro- <jopedro-@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/07 13:30:23 by jopedro-          #+#    #+#              #
#    Updated: 2024/11/07 13:30:25 by jopedro-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		= libftprintf.a
EXEC 		= a.out

SRC_PATH	= .
INC_PATH	= inc/
BUILD_PATH	= .build

LIBFT_PATH	= $(INC_PATH)libft/
LIBFT_ARC	= $(LIBFT_PATH)libft.a

SRC 		= $(addprefix $(SRC_PATH)/, ft_printf.c ft_printf_hex.c \
			  ft_printf_ptr.c ft_printf_unsigned.c)

OBJS 		= $(addprefix $(BUILD_PATH)/,$(notdir $(SRC:.c=.o)))

#==============================================================================#
#                            FLAGS & CMDS                                      #
#==============================================================================#

# SHELL := zsh

MAKE		= make -C
CFLAGS		= -Wall -Wextra -Werror
CFLAGS		= -g
#CFLAGS		+= -fsanitize=address -fsanitize=undefined -fsanitize=leak 
# CFLAGS		+= -lm
INC			= -I.

CC			= cc
RM			= rm -rf
AR			= ar rcs
MKDIR_P		= mkdir -p

#==============================================================================#
#                                  RULES                                       #
#==============================================================================#

##@ ft_printf Compilation Rules 🏗

all: deps $(NAME)	## Compile ft_printf

$(BUILD_PATH)/%.o: $(SRC_PATH)/%.c
	@echo -n "$(CYA)█$(D)"
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_PATH)/%.o: $(SRCB_PATH)/%.c
	@echo -n "$(CYA)█$(D)"
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_PATH):
	$(MKDIR_P) $(BUILD_PATH)

$(LIBFT_ARC):
	@echo "\nCompiling libft..."
	$(MAKE) $(LIBFT_PATH) extra
	@printf "$(D)$(B)$(BLU)\nlibft compiled\n\n$(D)"

$(NAME): $(LIBFT_ARC) $(BUILD_PATH) $(OBJS)
	@echo "Compiling ft_printf..."
	$(AR) $(NAME) $(OBJS) $(LIBFT_ARC) -o $(NAME)
	@echo "\n\t$(GRN)SUCCESS!$(D)\n"

deps:			## Download/Update libft
	@if test ! -d "$(LIBFT_PATH)"; then make get_libft; \
		else echo "$(YEL)[libft]$(D) folder found"; fi
##	@make update_modules

update_modules:	## Update modules
	@echo "[$(CYA)Updating submodules$(D)]"
	git submodule init
	git submodule update --recursive --remote
	@echo "[$(GRN)Submodules successfully updated$(D)]"

get_libft:
	@echo "[$(CYA)Getting Libft submodule$(D)]"
	git clone git@github.com:4Rr0x/42_libft.git $(LIBFT_PATH)
	@echo "[$(GRN)Libft submodule successfully downloaded$(D)]"

test: all		## Run ft_printf's test
	@echo "[$(YEL)Compiling main.c for test$(D)]"
	$(CC) $(CFLAGS) main.c $(SRC) $(LIBFT_ARC) -o $(EXEC)
	./$(EXEC)

##@ Clean-up Rules 󰃢

clean:			## Remove ft_printf object files
	$(MAKE) $(LIBFT_PATH) clean
	@echo "[$(RED)Removing $(BUILD_PATH) 󰃢$(D)]"
	$(RM) $(BUILD_PATH)
	@echo "[$(GRN)Object files successfully removed!$(D)]\n"

fclean: clean	## Remove ft_printf object files and executable
	@echo "[$(RED)Cleaning executable 󰃢$(D)]"
	$(MAKE) $(LIBFT_PATH) fclean
	$(RM) $(NAME)
	@echo "[$(GRN)$(NAME) Successfully removed!$(D)]\n"

libclean: fclean	## Remove libft
	@echo "[$(RED)Cleaning libft 󰃢$(D)]"
	$(RM) $(LIBFT_PATH)
	@echo "==> $(GRN)libft successfully removed!$(D)\n"
	$(RM) $(INC_PATH)
	@echo "==> $(GRN)inc folder successfully removed!$(D)\n"

re: fclean all	## Purge and Recompile

##@ Help 󰛵

.PHONY: help
help: 			## Display this help page
	@awk 'BEGIN {FS = ":.*##"; \
			printf "\n=> Usage:\n\tmake $(GRN)<target>$(D)\n"} \
		/^[a-zA-Z_0-9-]+:.*?##/ { \
			printf "\t$(GRN)%-15s$(D) %s\n", $$1, $$2 } \
		/^##@/ { \
			printf "\n=> %s\n", substr($$0, 5) } ' Makefile
## Tweaked from source:
### https://www.padok.fr/en/blog/beautiful-makefile-awk

.PHONY: all bonus deps update_modules get_libft test clean fclean re

#==============================================================================#
#                                  UTILS                                       #
#==============================================================================#

# Colors
#
# Run the following command to get list of available colors
# bash -c 'for c in {0..255}; do tput setaf $c; tput setaf $c | cat -v; echo =$c; done'
#
B  		= $(shell tput bold)
BLA		= $(shell tput setaf 0)
RED		= $(shell tput setaf 1)
GRN		= $(shell tput setaf 2)
YEL		= $(shell tput setaf 3)
BLU		= $(shell tput setaf 4)
MAG		= $(shell tput setaf 5)
CYA		= $(shell tput setaf 6)
WHI		= $(shell tput setaf 7)
GRE		= $(shell tput setaf 8)
BRED 	= $(shell tput setaf 9)
BGRN	= $(shell tput setaf 10)
BYEL	= $(shell tput setaf 11)
BBLU	= $(shell tput setaf 12)
BMAG	= $(shell tput setaf 13)
BCYA	= $(shell tput setaf 14)
BWHI	= $(shell tput setaf 15)
D 		= $(shell tput sgr0)
BEL 	= $(shell tput bel)
CLR 	= $(shell tput el 1)
