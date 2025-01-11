`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2024 10:12:23
// Design Name: 
// Module Name: vending_machine_fpga
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


module vending_machine_fpga(clk,rst,coin,d,enable,an);
input clk,rst;
input[2:0]coin;
output reg[6:0]d;
input  enable;
output reg [7:0] an;

parameter s0=3'b000,
          s1=3'b001,
          s2=3'b010,
          s3=3'b011;
          
 reg[2:0]pre,next;
reg [2:0] delivery,change;
 
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


always @(posedge clk) begin 

if(enable)  begin 
an=8'b11110111;

case(change)
3'b011: d= 7'b0000110;
    
3'b001: d=7'b1001111;
3'b100: d = 7'b1001100;
default: d=7'b0000001;
endcase
end

else  begin 
an = 8'b11111110;
case(delivery)
3'b001: d=7'b1001111;
default: d=7'b0000001;
endcase


end  

end 
      
endmodule


