//
//  ASBezierCurve.c
//  ARKit_SCNGeometry
//
//  Created by 杨孟强 on 2017/9/8.
//  Copyright © 2017年 杨孟强. All rights reserved.
//

#include "ASBezierCurve.h"

float decas(int degree,float coeff[],float t){
    int r,i;
    float t1;
    float coeffa[10];
    t1 = 1.0 - t;
    for(i = 0; i <= degree; i++){
        coeffa[i] = coeff[i];
    }
    for(r=1; r <= degree; r++){
        for(i = 0; i <= degree-r; i++){
            coeffa[i] = t1*coeffa[i]+t*coeffa[i+1];
        }
    }
    return (coeffa[0]);
}

void ASGetASBezierPoint(void(^block)(int n, int x, int y))
{
    int i, n, k;
    float t, x, y;
    static float px[4];
    static float py[4];
    n = 3;
    k = 1000;//拆分点数
    px[0] = 50;  px[1] = 140; px[2]=400; px[3]=600;
    py[0] = 400; py[1] = 20;  py[2]=40; py[3]=400;

    for(i = 0; i <= k; i++){
        t = (float)i / k;
        x = decas(n, px, t);
        y = decas(n, py, t);
        
        if (block) {
            block(i, x, y);
        }
    }
}
