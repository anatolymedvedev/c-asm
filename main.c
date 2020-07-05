#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>

typedef int32_t (*callback)(int32_t);

extern int32_t factor(int32_t x, callback cb);


int32_t process_result(int32_t x)
{
    printf("*%d",x);
    return 0;
}


int main(int argc, char* argv[])
{
   if(argc != 2)
   {
       printf("Я ожидаю от вас одно число для факторизации\n");
       return 1;
   }

    int32_t num = atoi(argv[1]);
    
    if(num == -1)
    {
        int32_t y = (-1)*num;
        printf("%d*%d\n", num, y);
        return 0;
    }
    
    if (num == 0)
    {
        printf("Вы передали некорректный номер \n");
        return 1;
    }

    if (num == 1)
    {
        printf("%d\n", num);
        return 0;
    }

    if (num < 0) 
    {
        num = (-1) * num;
    }

    printf("1");
    factor(num, process_result);
    printf("\n");
    
    return 0;
}
