//+------------------------------------------------------------------+
//|                                                      Fractal.mqh |
//|                                          Copyright 2016, Li Ding |
//|                                                dingmaotu@126.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, Li Ding"
#property link      "dingmaotu@126.com"
#property strict

#include <LiDing/Utils/Math.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Fractal
  {
public:
   template<typename T>
   static int left(const T &array[],int shift,int range=0)
     {
      int begin=0;
      if(range>0)
        {
         begin=Math::max(shift-range,begin);
        }
      int n=0;
      T v=array[shift];

      if((shift-1)>=begin)
        {
         if(v>array[shift-1])
           {
            for(int i=shift-1; i>=begin; i--)
              {
               if(array[i]<v) n++;
               else break;
              }
           }
         else if(v<array[shift-1])
           {
            for(int i=shift-1; i>=begin; i--)
              {
               if(array[i]>v) n--;
               else break;
              }
           }
        }

      return n;
     }

   template<typename T>
   static int right(const T &array[],int shift,int range=0)
     {
      int end=ArraySize(array)-1;
      if(range>0)
        {
         end=Math::min(shift+range,end);
        }
      int n=0;
      T v=array[shift];
      // right fractal
      if((shift+1)<=end)
        {
         if(v>array[shift+1])
           {
            for(int i=shift+1; i<=end; i++)
              {
               if(array[i]<v) n++;
               else break;
              }
           }
         else if(v<array[shift+1])
           {
            for(int i=shift+1; i<=end; i++)
              {
               if(array[i]>v) n--;
               else break;
              }
           }
        }

      return n;
     }

   template<typename T>
   static bool isLowOrder(const T &array[],int shift,int order)
     {
      return left(array, shift, order) == -order && right(array, shift, order) == -order;
     }

   template<typename T>
   static bool isHighOrder(const T &array[],int shift,int order)
     {
      return left(array, shift, order) == order && right(array, shift, order) == order;
     }

   template<typename T>
   static bool isOrder(const T &array[],int shift,int order)
     {
      int v1 = left(array, shift, order);
      int v2 = right(array, shift, order);
      return v1 == v2 && Math.abs(v1) == order;
     }

   template<typename T>
   static void orders(const T &array[],int &left[],int &right[],int shift=0)
     {
      int size=ArraySize(array);
      if(size>0)
        {
         for(int i=shift; i<size; i++)
           {
            left[i]=Fractal::left(array,i);
           }
         for(int i=0; i<shift; i++)
           {
            if(Math::abs(right[i])==(shift-i-1))
              {
               right[i]=Fractal::right(array,i);
              }
           }
         for(int i=shift; i<size; i++)
           {
            right[i]=Fractal::right(array,i);
           }
        }
     }
  };
//+------------------------------------------------------------------+