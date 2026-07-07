class ram_trans;
rand logic[7:0]data_in;
rand logic write_enb,read_enb;
rand logic [4:0]address;
logic [7:0]data_out;
logic reset;
//constraint concurent { write_enb==1;read_enb==1;}
constraint normal_addre{address inside{[0:31]};}
constraint read_write_normal{{write_enb,read_enb} inside{[0:3]};}
virtual function ram_trans copy_1();
copy_1=new;
copy_1.data_in=this.data_in;
copy_1.write_enb=this.write_enb;
copy_1.read_enb=this.read_enb;
copy_1.address=this.address;
copy_1.reset=this.reset;
return copy_1;
endfunction
endclass
class ram_trans1 extends ram_trans;
constraint read_write_normal{{write_enb,read_enb}==2'b10;}
virtual function ram_trans copy_1();
ram_trans1 copy_2;
copy_2=new;
copy_2.data_in=this.data_in;
copy_2.write_enb=this.write_enb;
copy_2.read_enb=this.read_enb;
copy_2.address=this.address;
copy_2.reset=this.reset;
return copy_2;
endfunction
endclass
class ram_trans2 extends ram_trans;
constraint read_write_normal{{write_enb,read_enb}==2'b01;}
virtual function ram_trans copy_1();
ram_trans2 copy_3;
copy_3=new;
copy_3.data_in=this.data_in;
copy_3.write_enb=this.write_enb;
copy_3.read_enb=this.read_enb;
copy_3.address=this.address;
copy_3.reset=this.reset;
return copy_3;
endfunction
endclass
class ram_trans3 extends ram_trans;
constraint read_write_normal{{write_enb,read_enb}==2'b00;}
virtual function ram_trans copy_1();
ram_trans3 copy_4;
copy_4=new;
copy_4.data_in=this.data_in;
copy_4.write_enb=this.write_enb;
copy_4.read_enb=this.read_enb;
copy_4.address=this.address;
copy_4.reset=this.reset;
return copy_4;
endfunction
endclass
class ram_trans4 extends ram_trans;
constraint read_write_normal{{write_enb,read_enb}==2'b11;}
virtual function ram_trans copy_1();
ram_trans4 copy_5;
copy_5=new;
copy_5.data_in=this.data_in;
copy_5.write_enb=this.write_enb;
copy_5.read_enb=this.read_enb;
copy_5.address=this.address;
copy_5.reset=this.reset;
return copy_5;
endfunction
endclass
