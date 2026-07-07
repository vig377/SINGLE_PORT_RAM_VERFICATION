`include "package.sv"
`include "RAM.sv"
`include "interface.sv"
module top;
import ram_package::*;
logic clk=0;
logic reset;
initial begin
forever #10 clk=~clk;
end
initial begin
@(posedge clk);
reset=0;
@(posedge clk);
reset=1;
@(posedge clk);
reset=0;
@(posedge clk);
reset=1;
end
ram intrf(clk,reset);
RAM duv(.data_in(intrf.data_in),.write_enb(intrf.write_enb),.read_enb(intrf.read_enb),.data_out(intrf.data_out),.address(intrf.address),.clk(clk),.reset(reset));
ram_test test=new(intrf.driv,intrf.mon);
test1 tb1=new(intrf.driv,intrf.mon);
test2 tb2=new(intrf.driv,intrf.mon);
test3 tb3=new(intrf.driv,intrf.mon);
test4 tb4=new(intrf.driv,intrf.mon);
test_regression tb_reg=new(intrf.driv,intrf.mon);

initial begin
tb_reg.run();
//test.run();
//tb1.run();
//tb2.run();
//tb3.run();
//tb4.run();
$finish();
end
endmodule
