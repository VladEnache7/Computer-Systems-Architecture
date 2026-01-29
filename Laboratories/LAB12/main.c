#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void ASMconcatenate(char arr1[], char arr2[], int lens2);

int main() {
    char test[1];
    int n;
    printf("n = ");
    scanf("%d", &n);
    gets(test);

    char arrstr[100][200];

    for (int i = 0; i < n; ++i) {
        printf("arrstr[%d] = ", i);
        fgets(arrstr[i], 200, stdin);
    }

    //using strtok to separate the words
    char *token;
	char concat[100][200];
    for (int i = 0; i < n; ++i) {
        int k = 0;
        token = strtok(arrstr[i], " ");
        while (token != NULL) {
            if (k == i) {
                strcpy(concat[i], token);
                break;
            }
            token = strtok(NULL, " ");
            k++;
        }
    }
    for (int i = 1; i < n; ++i) {
        ASMconcatenate(concat[0], concat[i], strlen(concat[i]));
    }
    strcat(concat[0], ".");
    printf("%s", concat[0]);
    return 0;
}
