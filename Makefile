# Compilers and options
ASM             = nasm
CC              = cc
ASMFLAGS        = -f elf64
CFLAGS          = -Wall -Werror -Wextra -I headers

# NAMES and DIRS
NAME            = libasm.a
BONUS_NAME      = libasm_bonus.a
SRCSDIR         = srcs
OBJSDIR         = objs
BONUS_OBJSDIR   = objs_bonus

# Source and object files
ASM_SRC         = $(SRCSDIR)/ft_strlen.s 				\
                  $(SRCSDIR)/ft_strcpy.s 				\
                  $(SRCSDIR)/ft_strcmp.s 				\
                  $(SRCSDIR)/ft_write.s  				\
                  $(SRCSDIR)/ft_read.s   				\
                  $(SRCSDIR)/ft_strdup.s

ASM_SRC_BONUS   = $(SRCSDIR)/ft_strlen.s 				\
                  $(SRCSDIR)/ft_strcpy.s 				\
                  $(SRCSDIR)/ft_strcmp.s 				\
                  $(SRCSDIR)/ft_write.s  				\
                  $(SRCSDIR)/ft_read.s   				\
                  $(SRCSDIR)/ft_strdup.s 				\
		  		  $(SRCSDIR)/ft_atoi_base_bonus.s 		\
		  		  $(SRCSDIR)/ft_list_push_front_bonus.s \
                  $(SRCSDIR)/ft_list_size_bonus.s 		\
		  		  $(SRCSDIR)/ft_list_remove_if_bonus.s	\
		  		  $(SRCSDIR)/ft_list_sort_bonus.s

ASM_OBJ         = $(ASM_SRC:$(SRCSDIR)/%.s=$(OBJSDIR)/%.o)
ASM_OBJ_BONUS   = $(ASM_SRC_BONUS:$(SRCSDIR)/%.s=$(BONUS_OBJSDIR)/%.o)

# RULES
all: $(NAME)

bonus: $(BONUS_NAME)

$(NAME): $(ASM_OBJ)
	ar -rcs $(NAME) $(ASM_OBJ)

$(BONUS_NAME): $(ASM_OBJ_BONUS)
	ar -rcs $(BONUS_NAME) $(ASM_OBJ_BONUS)

$(OBJSDIR)/%.o: $(SRCSDIR)/%.s | $(OBJSDIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

$(BONUS_OBJSDIR)/%.o: $(SRCSDIR)/%.s | $(BONUS_OBJSDIR)
	$(ASM) $(ASMFLAGS) -o $@ $<

$(OBJSDIR):
	mkdir -p $(OBJSDIR)

$(BONUS_OBJSDIR):
	mkdir -p $(BONUS_OBJSDIR)

clean:
	rm -rf $(OBJSDIR) $(BONUS_OBJSDIR)

fclean: clean
	rm -f $(NAME) $(BONUS_NAME)

re: fclean all bonus

re_bonus: fclean bonus
