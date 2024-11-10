/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_remove_if.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: hmaciel- <hmaciel-@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/10 15:38:44 by hmaciel-          #+#    #+#             */
/*   Updated: 2024/11/10 15:39:27 by hmaciel-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"

void    ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
{
    t_list *current;
    t_list *previous;

    current = *begin_list;
    previous = NULL;
    while (current)
    {
        if ((*cmp)(current->data, data_ref) == 0)
        {
            if (previous)
                previous->next = current->next;
            else
                *begin_list = current->next;
            (*free_fct)(current->data);
            free(current);
            current = previous ? previous->next : *begin_list;
        }
        else
        {
            previous = current;
            current = current->next;
        }
    }
}