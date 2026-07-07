interface ram(input bit clk,reset);
logic [7:0]data_in,data_out;
logic write_enb,read_enb;
logic [4:0]address;
clocking drv_cb@(posedge clk);
default input #1ns output #1ns ;
output write_enb,read_enb,data_in,address;
input reset;
endclocking
clocking mon_cb@(posedge clk);
default input #1ns output #1ns;
input data_out;
endclocking
modport driv(clocking drv_cb);
modport mon(clocking mon_cb);
endinterface
