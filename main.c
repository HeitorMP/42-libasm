#include "headers/libasm.h"
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

void print_errno_comparison(const char *func_name) {
    printf("Errno from %s: %d\n", func_name, errno);
}

void free_list(t_list *list) {
    t_list *tmp;

    while (list) {
        tmp = list;
        list = list->next;
        free(tmp);
    }
}

void print_list(t_list *list) {
    t_list *tmp = list;
    while (tmp) {
        printf("%s\n", (char *)tmp->data);
        tmp = tmp->next;
    }
}

int main()
{
     // Test 1: ft_strlen vs strlen
    const char *str = "Hello, World!";
    printf("Testing ft_strlen vs strlen:\n");
    printf("ft_strlen: %zu\n", ft_strlen(str));
    printf("strlen: %zu\n\n", strlen(str));

    // Test 2: ft_strcpy vs strcpy
    char dest1[50], dest2[50];
    ft_strcpy(dest1, str);
    strcpy(dest2, str);
    printf("Testing ft_strcpy vs strcpy:\n");
    printf("ft_strcpy: %s\n", dest1);
    printf("strcpy: %s\n\n", dest2);

    // Test 3: ft_strcmp vs strcmp
    const char *str1 = "Hello";
    const char *str2 = "Hello";
    const char *str3 = "World";
    printf("Testing ft_strcmp vs strcmp:\n");
    printf("ft_strcmp (str1 vs str2): %d\n", ft_strcmp(str1, str2));
    printf("strcmp (str1 vs str2): %d\n", strcmp(str1, str2));
    printf("ft_strcmp (str1 vs str3): %d\n", ft_strcmp(str1, str3));
    printf("strcmp (str1 vs str3): %d\n\n", strcmp(str1, str3));

    // Test 4: ft_write vs write
    const char *message = "Hello, write test!\n";
    printf("Testing ft_write vs write:\n");
    
    // Test ft_write
    if (ft_write(STDOUT_FILENO, message, strlen(message)) == -1) {
        print_errno_comparison("ft_write");
    }

    // Test write
    if (write(STDOUT_FILENO, message, strlen(message)) == -1) {
        print_errno_comparison("write");
    }
    printf("\n");

    // Test 5: ft_read vs read
    char buffer[100];
    printf("Testing ft_read vs read:\n");

    // Test ft_read
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

    // Test 6: ft_strdup vs strdup
    const char *str_to_duplicate = "Duplicate me!";
    char *dup1 = ft_strdup(str_to_duplicate);
    char *dup2 = strdup(str_to_duplicate);
    printf("Testing ft_strdup vs strdup:\n");
    printf("ft_strdup: %s\n", dup1);
    printf("strdup: %s\n", dup2);

    free(dup1);
    free(dup2);

    //Atoi Base
    printf("Atoi base: %d\n", ft_atoi_base("", "01"));

    // push front
    t_list *list = NULL;
    ft_list_push_front(&list, "first");
    print_list(list);

    ft_list_push_front(&list, "second");
    print_list(list);

    free_list(list);

    // remove if e list size
    list = NULL;
    printf("List before remove: \n");
    ft_list_push_front(&list, "World");
    ft_list_push_front(&list, "Hello");
    ft_list_push_front(&list, "World");
    ft_list_push_front(&list, "Hello");
    print_list(list);
    printf("\nList size: %d\n", ft_list_size(list));
    printf("\nList after remove: \n");
    ft_list_remove_if(&list, "World", strcmp, free);
    print_list(list);
    printf("\nList size: %d\n", ft_list_size(list));
    free_list(list);

    // sort list
    list = NULL;
    printf("List before sorting: \n");
    ft_list_push_front(&list, "1");
    ft_list_push_front(&list, "2");
    ft_list_push_front(&list, "3");
    ft_list_push_front(&list, "4");
    print_list(list);

    printf("List after sorting: \n");
    ft_list_sort(&list, &ft_strcmp);
    print_list(list);

    free(list);
    return 0;
}