#include<stdio.h>
#include<math.h>

float func(float t, float y) {
    float f;
    f = y - (t*t) + 1;
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

