class ram_generator;
ram_trans t1;
mailbox#(ram_trans)mbx_gdr;
function new(mailbox #(ram_trans)mbx_gdr);
this.mbx_gdr=mbx_gdr;
t1=new;
endfunction
task start();
for(int i=0;i<=10;i++)
begin
assert(t1.randomize())
$display(" generator : data_in %d write_enb %b read_enb %b address %d  at %t\n",t1.data_in,t1.write_enb,t1.read_enb,t1.address,$time);
mbx_gdr.put(t1.copy_1());
end
endtask
endclass

