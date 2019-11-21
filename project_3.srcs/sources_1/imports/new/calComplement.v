`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/25 18:59:52
// Design Name: 
// Module Name: calComplement
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


module calWithRegs_FIB(
    input clk,
    input rst,
    input [3:0] n,
    output [31:0]result
    );
    reg[5:0] addr;
   
    reg [31:0] wdata;
    reg[4:0] ra1,ra2,wa;
    reg[0:0] we,ramWe;
    
    wire [31:0]a,b,f;
    wire z;
   // assign result=f;
    
    integer count=2;
    reg[1:0] status=2'b00; 
    parameter op=4'b0001;
     RAM32bit_64 ram(.addr(addr),.wdata(f),.clk(clk),.we(ramWe),.rst(~rst),.rdata(result));
    registerGroup regs(.oc(~rst),.raddr1(ra1),.raddr2(ra2),.waddr(wa),.wdata(wdata),.clk(clk),.WE(we),.rdata1(a),.rdata2(b));  
     ALU alu(a,b,op,f,z);    
    always @(posedge clk )
    begin    
        addr<=0;
        if(rst==1'b0)
            begin          
            status<=2'b00;
            count<=2; 
            ra1<=5'b0;
            ra2<=5'b0;
            wa<=5'b0;
            wdata<=32'b0;
            we<=1'b0;
            end
        else
            begin
            case (status)
            2'b00:
                begin
                ra1<=5'b1;
                ra2<=5'b10;
                we<=1'b1;
                wa<=5'b1;
                wdata<=32'b1;
                status<=2'b01; 
                $monitor($time,"test");                         
                end
            2'b01:
                begin
                if(wa>2)
                begin
                ra1<=ra1+1;
                ra2<=ra2+1;
                status<=2'b10;
                end
                else
                    begin
                    we<=1'b1;
                    wa<=5'b10;
                    wdata<=32'b1;
                    status<=2'b10;
                    end
                    $monitor($time,"test");
                end
            2'b10:
                begin
                we<=1'b1;
                wa<=ra2+1'b1;                              
                status<=2'b11;
                count<=count+1;
                $monitor($time,"test");
                ramWe<=1; 
                end
            2'b11:
                begin
                if(count<n)
                    begin
                    wdata<=f; 
                    status<=2'b01;
                    $monitor($time,"test");
                    end                
                 else 
                    begin
                    $monitor($time,"testread");
                        ramWe<=0;
                    end
                end
             default:
                begin
                end
            endcase
            end
    end
endmodule
