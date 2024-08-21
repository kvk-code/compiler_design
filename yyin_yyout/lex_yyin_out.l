%{
#include <stdio.h>
%}

%%
[a-z]      { fprintf(yyout, "Lowercase: %s\n", yytext); }
[A-Z]      { fprintf(yyout, "Uppercase: %s\n", yytext); }
[0-9]      { fprintf(yyout, "Digit: %s\n", yytext); }
.          { fprintf(yyout, "Other: %s\n", yytext); }
%%

int main() {
    const char* input_filename = "input.txt";
    const char* output_filename = "output.txt";
    
    FILE *input_file = fopen(input_filename, "r");
    if (!input_file) {
        perror("Error opening input file");
        return 1;
    }
    yyin = input_file;

    FILE *output_file = fopen(output_filename, "w");
    if (!output_file) {
        perror("Error opening output file");
        fclose(input_file);
        return 1;
    }
    yyout = output_file;

    yylex();

    fclose(yyin);
    fclose(yyout);

    printf("Processing complete. Check %s for results.\n", output_filename);

    return 0;
}
