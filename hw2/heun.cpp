#include<stdio.h>
#include<math.h>
#include<stdlib.h>

float f(float x,float y) {
    float m;
    m = y - (x*x) + 1;
    return m;
}

int main() {
    float x0,y0,m1,m2,m3,k1,k2,m,y,x,h,xn;
    float heun, euler, meuler;
    float heun_error, euler_error, meuler_error;
    FILE* file = fopen("output05.csv", "w");
    printf("Enter x0,y0,xn,h:");
    scanf("%f %f %f %f",&x0,&y0,&xn,&h);
    x = x0;
    y = y0;
    heun = y0;
    euler = y0;
    meuler = y0;
    printf("\n\nX\t\tY\t\tHeun\t\tHeun_Err\tEuler\t\tEuler_Err\tMod_Euler\tMeuler_Err\n");
    while(x <= xn) {
        //Heun Method
        m1 = f(x,heun);
        m2 = f((x + (h/3)),(heun + m1*(h/3)));
        m3 = f((x + (h*2/3)),(heun + m2*(h*2/3)));
        m = m1 + 3*m3;
        heun = heun + m*(h/4);
        
        //Euler Method
        euler = euler + (h * f(x, euler));

        //Modified Euler Method
        k1 = f(x, meuler);
        k2 = f(x + h, meuler + h*k1);
        meuler = meuler + (h/2)*(k1 + k2);

        //Exact value
        y = (x+h+1)*(x+h+1) - 0.5*exp(x+h);

        //Compute errors
        heun_error = y - heun;
        euler_error = y - euler;
        meuler_error = y - meuler;

        x = x + h;
        printf("%f\t%f\t%f\t%f\t%f\t%f\t%f\t%f\n",x,y,heun,heun_error,euler,euler_error,meuler,meuler_error);
        fprintf(file, "%f\t%f\t%f\t%f\n",x,heun_error,euler_error,meuler_error);
    }
}
