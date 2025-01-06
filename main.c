#include "headers/libasm.h"
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

void print_errno_comparison(const char *func_name) {
    printf("Errno from %s: %d\n", func_name, errno);
}

int main()
{
     // Teste 1: ft_strlen vs strlen
    const char *str = "Hello, World!";
    printf("Testing ft_strlen vs strlen:\n");
    printf("ft_strlen: %zu\n", ft_strlen(str));
    printf("strlen: %zu\n\n", strlen(str));

    // Teste 2: ft_strcpy vs strcpy
    char dest1[50], dest2[50];
    ft_strcpy(dest1, str);
    strcpy(dest2, str);
    printf("Testing ft_strcpy vs strcpy:\n");
    printf("ft_strcpy: %s\n", dest1);
    printf("strcpy: %s\n\n", dest2);

    // Teste 3: ft_strcmp vs strcmp
    const char *str1 = "Hello";
    const char *str2 = "Hello";
    const char *str3 = "World";
    printf("Testing ft_strcmp vs strcmp:\n");
    printf("ft_strcmp (str1 vs str2): %d\n", ft_strcmp(str1, str2));
    printf("strcmp (str1 vs str2): %d\n", strcmp(str1, str2));
    printf("ft_strcmp (str1 vs str3): %d\n", ft_strcmp(str1, str3));
    printf("strcmp (str1 vs str3): %d\n\n", strcmp(str1, str3));

    // Teste 4: ft_write vs write
    const char *message = "Hello, write test!\n";
    printf("Testing ft_write vs write:\n");
    
    // Teste ft_write
    if (ft_write(STDOUT_FILENO, message, strlen(message)) == -1) {
        print_errno_comparison("ft_write");
    }

    // Teste write
    if (write(STDOUT_FILENO, message, strlen(message)) == -1) {
        print_errno_comparison("write");
    }
    printf("\n");

    // Teste 5: ft_read vs read
    char buffer[100];
    printf("Testing ft_read vs read:\n");

    // Teste ft_read
    printf("Enter some text: ");
    ft_read(STDIN_FILENO, buffer, sizeof(buffer));
    print_errno_comparison("ft_read");

    read(STDIN_FILENO, buffer, sizeof(buffer));
    print_errno_comparison("read");


    write(STDOUT_FILENO, "You entered: ", 13);
    print_errno_comparison("ft_write");
    write(STDOUT_FILENO, buffer, ft_strlen(buffer));
    print_errno_comparison("write");
    printf("\n");

    // Teste 6: ft_strdup vs strdup
    const char *str_to_duplicate = "Duplicate me!";
    char *dup1 = ft_strdup(str_to_duplicate);
    char *dup2 = strdup(str_to_duplicate);
    printf("Testing ft_strdup vs strdup:\n");
    printf("ft_strdup: %s\n", dup1);
    printf("strdup: %s\n", dup2);

    // Liberar a memória alocada por ft_strdup e strdup
    free(dup1);
    free(dup2);

    //Atoi Base
    printf("Atoi base: %d\n", ft_atoi_base("", "01"));

    //
    t_list *list = NULL;
    char* data = NULL;

    // Test 1: null list
    ft_list_push_front(&list, "first");
    printf("Element 1: %s\n", (char*)list->data);

    ft_list_push_front(&list, "second");
    printf("Element 1: %s\n", (char*)list->data);
    printf("Element 2: %s\n", (char*)list->next->data);

    


    return 0;
}
