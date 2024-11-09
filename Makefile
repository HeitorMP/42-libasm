# Compilers and options
ASM             = nasm
CC              = cc
ASMFLAGS        = -f elf64
CFLAGS          = -Wall -Werror -Wextra -I headers

# NAMES and DIRS
NAME            = libasm.a
TESTERNAME      = tester
TESTSDIR		= srcs/tests
SRCSDIR         = srcs
OBJSDIR         = objs

# Source and object files
ASM_SRC         = $(SRCSDIR)/ft_strlen.s 				\
                  $(SRCSDIR)/ft_strcpy.s 				\
                  $(SRCSDIR)/ft_strcmp.s 				\
                  $(SRCSDIR)/ft_write.s  				\
                  $(SRCSDIR)/ft_read.s   				\
                  $(SRCSDIR)/ft_strdup.s 				\
				  $(SRCSDIR)/ft_atoi_base.s 	 		\
				  $(SRCSDIR)/ft_list_push_front_bonus.s \
                  $(SRCSDIR)/ft_list_size_bonus.s 		\
				  $(SRCSDIR)/ft_list_remove_if.s 		\
				  $(SRCSDIR)/ft_list_sort.s 	 		\

ASM_OBJ         = $(ASM_SRC:$(SRCSDIR)/%.s=$(OBJSDIR)/%.o)
ASM_OBJ_BONUS   = $(ASM_BONUS_SRC:$(SRCSDIR)/%.s=$(OBJSDIR)/%.o)

# Rules
all: $(NAME)

bonus: all

$(OBJSDIR)/%.o: $(SRCSDIR)/%.s | $(OBJSDIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

$(NAME): $(ASM_OBJ)
	ar -rcs $(NAME) $(ASM_OBJ)

$(OBJSDIR):
	mkdir -p $(OBJSDIR)

clean:
	rm -rf $(OBJSDIR)

fclean: clean
	rm -f $(NAME)

re: fclean all

re_bonus: fclean all bonus