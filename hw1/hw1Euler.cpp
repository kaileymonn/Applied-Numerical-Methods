Euler's Method:

#include<stdio.h>
#include<math.h>

float func(float t, float y) {
    float f;
    float ex = 1 / exp(t);
    f = y * y * ex;
    return f;
}

int main() {
    float a, b, x, y, h, t, k;
    printf("Enter x0, y0, h, xn: ");
    scanf("%f%f%f%f", &a, &b, &h, &t);
    x = a;
    y = b; 
    printf("\n  x\t  y\n");
    while(x <= t) {
        k = h * func(x, y);
        y = y + k;
        x = x + h;
        printf("%0.3f\t%0.3f\n", x, y);
    }
}


Taylor's Method of order 2:

#include<stdio.h>
#include<math.h>

float func(float t, float y) {
    float f;
    float ex = 1 / exp(t);
    f = y * y * ex;
    return f;
}

int main() {
    float x, y, h, t, k, a, b;
    printf("Enter x0, y0, h, xn: ");
    scanf("%f%f%f%f", &a, &b, &h, &t);
    x = a;
    y = b; 
    printf("\n  x\t  y\n");
    while(x <= t) {
        k = h * func(x, y) + (((h * h)/2) * func(x, y) * ((2 * y) - 1));
        y = y + k;
        x = x + h;
        printf("%0.3f\t%0.3f\n", x, y);
    }
}
