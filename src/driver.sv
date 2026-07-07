class ram_driver;
ram_trans t2;
mailbox #(ram_trans)mbx_gdr;
mailbox#(ram_trans)mbx_dr_sb;
virtual ram.driv vif;
covergroup dr_cg;
write:coverpoint t2.write_enb{bins wt[]={0,1};}
read :coverpoint t2.read_enb{bins rd[]={0,1};}
data_in:coverpoint t2.data_in{bins data={[0:255]};} 
address:coverpoint t2.address{bins add={[0:31]};}
cr:cross write,read;
endgroup
function new(mailbox#(ram_trans)mbx_gdr,mailbox#(ram_trans)mbx_dr_sb,virtual ram.driv vif);
this.mbx_gdr=mbx_gdr;
this.mbx_dr_sb=mbx_dr_sb;
this.vif=vif;
dr_cg=new;
endfunction
task start();
repeat(3)@(vif.drv_cb);
for(int i=0;i<=10;i++)
begin
t2=new;
mbx_gdr.get(t2);
if(vif.drv_cb.reset==0)
repeat(1)@(vif.drv_cb)
begin
vif.drv_cb.write_enb<=0;
vif.drv_cb.read_enb<=0;
vif.drv_cb.address<=0;
vif.drv_cb.data_in<=8'bz;
t2.write_enb=0;
t2.read_enb=0;
t2.address=0;
t2.data_in=8'bz;
t2.reset=vif.drv_cb.reset;
mbx_dr_sb.put(t2.copy_1());

$display("data to interfaceon reset  data_in=%d write_enb =%b read_enb =%b address=%d %t",t2.data_in,t2.write_enb,t2.read_enb,t2.address,$time);
end
else
repeat(1)@(vif.drv_cb)
begin
vif.drv_cb.write_enb<=t2.write_enb;
vif.drv_cb.read_enb<=t2.read_enb;
vif.drv_cb.data_in<=t2.data_in;
vif.drv_cb.address<=t2.address;
t2.reset=vif.drv_cb.reset;
$display("data to interface  data_in=%d write_enb =%b read_enb =%b address=%d %t",t2.data_in,t2.write_enb,t2.read_enb,t2.address,$time);
mbx_dr_sb.put(t2.copy_1());
dr_cg.sample();
end
end
endtask
endclass

