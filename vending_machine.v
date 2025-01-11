`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2024 21:38:13
// Design Name: 
// Module Name: vending_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vending_machine(clk,rst,coin,delivery,change);
input clk,rst;
input[2:0]coin;
output reg[2:0]delivery,change;

parameter s0=3'b000,
          s1=3'b001,
          s2=3'b010,
          s3=3'b011;
          
 reg[2:0]pre,next;
 
 always@(posedge clk)
 begin
    if(rst)
      pre<=s0;
    else
      pre<=next;
 end
 
 always@(*)
 begin
   next=s0;
   case(pre)
   s0: if(coin==1)
          next=s1;
       else if(coin==2)
          next=s2;
       else if(coin==5)
          next=s3;
       else if(coin==0 || coin==3 || coin>5)
          next=s0;
   s1: if(coin==1)
          next=s2;
       else if(coin==2)
          next=s3;
       else if(coin==5)
          next=s3;
       else if(coin==3 || coin>5)
          next=s0;
       else
          next=s1;
    s2: next=s0;
    s3: next=s0;
    default: next=s0;
   endcase
 end
 
 always@(posedge clk)
   begin
      delivery<=0;
      change<=0; 
      case(pre)
      s0:if(coin==2)
           delivery<=1;
         else if(coin==5)
           begin
            delivery<=1;
            change<=3;
           end
      s1: if(coin==1)
          delivery<=1;
          else if(coin==2)
           begin
             delivery<=1;
             change<=1;
           end
           else if(coin==5)
            begin
              delivery<=1;
              change<=4;
            end   
       default: begin
                 delivery<=0;
                  change<=0;
                end
       endcase
      end
      
endmodule
